#!/usr/bin/env python3
import pathlib
import re
import os
import shutil
import subprocess
import tempfile

import yaml


ROOT = pathlib.Path(__file__).resolve().parents[2]
SHA_PIN = re.compile(r"uses:\s+[^./\s][^@\s]*@[0-9a-f]{40}(?:\s+#\s+\S.*)?$")
ORBIT_VERIFY_ACTION = (
    "iml885203/orbit/.github/actions/verify-orbit-release"
    "@d7f2c503228479f27162e558720a6e679627f809"
)


def require(text, value, source):
    if value not in text:
        raise AssertionError(f"{source} is missing {value!r}")


def verify_action_pins(path):
    for number, line in enumerate(path.read_text().splitlines(), 1):
        if "uses:" not in line or "uses: ./" in line:
            continue
        if not SHA_PIN.search(line):
            raise AssertionError(f"{path.relative_to(ROOT)}:{number} is not SHA-pinned: {line.strip()}")
        if " # " not in line:
            raise AssertionError(f"{path.relative_to(ROOT)}:{number} has no version comment")


def job(workflow, name):
    match = re.search(rf"^  {name}:\n(.*?)(?=^  [a-zA-Z0-9_-]+:\n|\Z)", workflow, re.MULTILINE | re.DOTALL)
    if match is None:
        raise AssertionError(f"update workflow has no {name} job")
    return match.group(1)


def grants_write(permissions):
    if permissions == "write-all":
        return True
    if permissions in (None, "read-all"):
        return False
    if not isinstance(permissions, dict):
        raise AssertionError(f"unsupported permissions value: {permissions!r}")
    return any(level == "write" for level in permissions.values())


def write_capable_jobs(workflow):
    try:
        document = yaml.safe_load(workflow)
    except yaml.YAMLError as error:
        raise AssertionError(f"invalid workflow YAML: {error}") from error
    inherited = document.get("permissions")
    writers = []
    for name, definition in document["jobs"].items():
        permissions = definition.get("permissions", inherited)
        if grants_write(permissions):
            writers.append(name)
    return writers


EXPECTED_UPDATE_CONDITION = " ".join(
    """always() &&
    needs.resolve.result == 'success' &&
    needs.resolve.outputs.current != 'true' &&
    (needs.resolve.outputs.project != 'orbit' || needs.verify-orbit.result == 'success')""".split()
)


def canonical_condition(value):
    return " ".join(value.split())


def validate_workflow_policy(workflow):
    try:
        document = yaml.safe_load(workflow)
    except yaml.YAMLError as error:
        raise AssertionError(f"invalid workflow YAML: {error}") from error
    jobs = document["jobs"]
    if document.get("permissions") != {"contents": "read"}:
        raise AssertionError("workflow top-level permissions must be exactly contents: read")
    verification = jobs["verify-orbit"]
    if verification.get("needs") != "resolve":
        raise AssertionError("Orbit verification must depend on resolve")
    if verification.get("if") != "needs.resolve.outputs.project == 'orbit'":
        raise AssertionError("Orbit verification has a fail-open or non-canonical condition")
    verification_steps = verification["steps"]
    matching_actions = [step for step in verification_steps if step.get("uses") == ORBIT_VERIFY_ACTION]
    if len(matching_actions) != 1:
        raise AssertionError("Orbit verification must use the exact commit-pinned shared action")
    action = matching_actions[0]
    if action.get("env") != {"GH_TOKEN": "${{ github.token }}"}:
        raise AssertionError("Orbit verification action must use only the read-only workflow token")
    if action.get("with") != {
        "mode": "published",
        "tag": "${{ needs.resolve.outputs.tag }}",
    }:
        raise AssertionError("Orbit verification action has incorrect published-release inputs")
    for step in verification_steps:
        if "continue-on-error" in step:
            raise AssertionError("Orbit verification must not continue on error")
        if "if" in step:
            raise AssertionError("Orbit verification steps must not be conditional")
    update = jobs["update"]
    if update.get("needs") != ["resolve", "verify-orbit"]:
        raise AssertionError("writer must depend on resolve and Orbit verification")
    if canonical_condition(update.get("if", "")) != EXPECTED_UPDATE_CONDITION:
        raise AssertionError("writer has a fail-open or non-canonical condition")
    if write_capable_jobs(workflow) != ["update"]:
        raise AssertionError("update must be the only write-capable job")
    for step in update["steps"]:
        run = step.get("run", "")
        if "gh workflow run" in run:
            if "always()" in step.get("if", ""):
                raise AssertionError("downstream dispatch must not run with always()")
            if "|| true" in run:
                raise AssertionError("downstream dispatch must not suppress failure")
    return document


def run_resolver(resolver, project="", requested_version="", latest_tag="v1.2.3"):
    with tempfile.TemporaryDirectory() as directory:
        root = pathlib.Path(directory)
        (root / "Formula").mkdir()
        (root / ".github/scripts").mkdir(parents=True)
        (root / "Formula/tunlease.rb").write_text(
            'url "https://github.com/iml885203/tunlease/archive/refs/tags/v1.0.0.tar.gz"\n'
        )
        (root / "Formula/orbit.rb").write_text(
            'url "https://github.com/iml885203/orbit/releases/download/v0.9.0/orbit-darwin-amd64"\n'
        )
        shutil.copy(ROOT / ".github/scripts/semver-not-older.py", root / ".github/scripts")
        fake_bin = root / "bin"
        fake_bin.mkdir()
        (fake_bin / "gh").write_text(
            """#!/usr/bin/env bash
set -euo pipefail
printf '%s\\n' "$*" >> "$FAKE_GH_LOG"
if [ "$1" = api ] && [[ "$2" == repos/iml885203/*/releases/latest ]]; then
  printf '%s\\n' "$FAKE_LATEST_TAG"
  exit 0
fi
echo "unexpected gh invocation: $*" >&2
exit 2
"""
        )
        (fake_bin / "gh").chmod(0o755)
        output = root / "output"
        log = root / "gh.log"
        env = os.environ | {
            "PATH": f"{fake_bin}:{os.environ['PATH']}",
            "GITHUB_OUTPUT": str(output),
            "FAKE_GH_LOG": str(log),
            "FAKE_LATEST_TAG": latest_tag,
            "REQUESTED_PROJECT": project,
            "REQUESTED_VERSION": requested_version,
        }
        result = subprocess.run(["bash", "-c", resolver], cwd=root, env=env, text=True, capture_output=True)
        return result, output.read_text() if output.exists() else "", log.read_text() if log.exists() else ""


def assert_rejected(check, mutated, description):
    try:
        check(mutated)
    except AssertionError:
        return
    raise AssertionError(f"contract test accepted mutation: {description}")


def writer_should_run(resolve_result, current, project, verification_result):
    return (
        resolve_result == "success"
        and current != "true"
        and (project != "orbit" or verification_result == "success")
    )


def main():
    update_path = ROOT / ".github/workflows/update.yml"
    update = update_path.read_text()
    document = validate_workflow_policy(update)
    resolve = job(update, "resolve")
    verification = job(update, "verify-orbit")
    write = job(update, "update")
    require(resolve, "permissions:\n      contents: read", update_path)
    resolver = document["jobs"]["resolve"]["steps"][1]["run"]
    result, outputs, calls = run_resolver(resolver, latest_tag="v1.0.0")
    if result.returncode != 0:
        raise AssertionError(f"default Tunlease resolver failed: {result.stderr}")
    if "project=tunlease" not in outputs or "tag=v1.0.0" not in outputs or "current=true" not in outputs:
        raise AssertionError(f"default resolver emitted wrong outputs: {outputs}")
    if "repos/iml885203/tunlease/releases/latest" not in calls or "orbit/releases/latest" in calls:
        raise AssertionError(f"default resolver queried the wrong release: {calls}")
    result, outputs, calls = run_resolver(resolver, project="orbit", latest_tag="v0.9.0")
    if result.returncode != 0 or "project=orbit" not in outputs or "current=true" not in outputs:
        raise AssertionError(f"Orbit resolver failed: {result.stderr}")
    if "repos/iml885203/orbit/releases/latest" not in calls:
        raise AssertionError(f"Orbit resolver queried the wrong release: {calls}")
    result, _, _ = run_resolver(resolver, requested_version="wrong-tag")
    if result.returncode == 0:
        raise AssertionError("resolver accepted an invalid requested tag")
    result, _, _ = run_resolver(resolver, latest_tag="wrong-tag")
    if result.returncode == 0:
        raise AssertionError("resolver accepted an invalid latest-release tag")
    require(verification, "needs: resolve", update_path)
    require(verification, "if: needs.resolve.outputs.project == 'orbit'", update_path)
    require(verification, "permissions:\n      contents: read", update_path)
    require(verification, ORBIT_VERIFY_ACTION, update_path)
    require(write, "needs: [resolve, verify-orbit]", update_path)
    require(write, "permissions:\n      actions: write\n      contents: write\n      pull-requests: write", update_path)
    require(write, "always() &&", update_path)
    require(write, "needs.resolve.result == 'success'", update_path)
    require(write, "needs.resolve.outputs.current != 'true'", update_path)
    require(
        write,
        "needs.resolve.outputs.project != 'orbit' || needs.verify-orbit.result == 'success'",
        update_path,
    )
    writers = write_capable_jobs(update)
    bypass = update + "\n  bypass-update:\n    permissions:\n      contents: write\n    runs-on: ubuntu-latest\n"
    if write_capable_jobs(bypass) == ["update"]:
        raise AssertionError("writer boundary test accepted a bypass write-capable job")
    inline_bypass = update + (
        "\n  inline-bypass-update:\n"
        "    permissions: {contents: write}\n"
        "    runs-on: ubuntu-latest\n"
    )
    if write_capable_jobs(inline_bypass) == ["update"]:
        raise AssertionError("writer boundary test accepted inline write permissions")
    write_all_bypass = update + (
        "\n  write-all-bypass-update:\n"
        "    permissions: write-all\n"
        "    runs-on: ubuntu-latest\n"
    )
    if write_capable_jobs(write_all_bypass) == ["update"]:
        raise AssertionError("writer boundary test accepted write-all permissions")
    inherited_bypass = update.replace(
        "permissions:\n  contents: read", "permissions:\n  contents: write", 1
    ) + "\n  inherited-bypass-update:\n    runs-on: ubuntu-latest\n"
    if write_capable_jobs(inherited_bypass) == ["update"]:
        raise AssertionError("writer boundary test ignored inherited write permissions")
    fail_open_mutations = {
        "top-level token gains write permission": update.replace(
            "permissions:\n  contents: read",
            "permissions:\n  contents: write",
            1,
        ),
        "verification continue-on-error": update.replace(
            f"uses: {ORBIT_VERIFY_ACTION}",
            f"continue-on-error: true\n        uses: {ORBIT_VERIFY_ACTION}",
            1,
        ),
        "verification uses a mutable ref": update.replace(
            ORBIT_VERIFY_ACTION,
            "iml885203/orbit/.github/actions/verify-orbit-release@main",
            1,
        ),
        "verification always runs": update.replace(
            "if: needs.resolve.outputs.project == 'orbit'",
            "if: always()",
            1,
        ),
        "writer ignores verification": update.replace(
            "(needs.resolve.outputs.project != 'orbit' || needs.verify-orbit.result == 'success')",
            "always()",
            1,
        ),
        "dispatch always runs": update.replace(
            "      - name: Open, test, and merge update",
            "      - name: Open, test, and merge update\n        if: always()",
            1,
        ),
        "dispatch suppresses failure": update.replace(
            '          gh workflow run test.yml --ref "$branch"',
            '          gh workflow run test.yml --ref "$branch" || true',
            1,
        ),
    }
    for description, mutation in fail_open_mutations.items():
        assert_rejected(validate_workflow_policy, mutation, description)
    if not writer_should_run("success", "false", "tunlease", "skipped"):
        raise AssertionError("a skipped Orbit verifier blocks the default Tunlease update")
    if writer_should_run("success", "false", "orbit", "failure"):
        raise AssertionError("a failed Orbit verifier permits the write-capable update")
    if not writer_should_run("success", "false", "orbit", "success"):
        raise AssertionError("a successful Orbit verifier does not permit the update")
    if writer_should_run("success", "true", "tunlease", "skipped"):
        raise AssertionError("an already-current Tunlease release starts the writer")
    if writer_should_run("failure", "false", "tunlease", "skipped"):
        raise AssertionError("a failed resolver starts the writer")
    for workflow in (ROOT / ".github/workflows").glob("*.yml"):
        verify_action_pins(workflow)


if __name__ == "__main__":
    main()
