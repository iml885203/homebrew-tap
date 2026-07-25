class Tunlease < Formula
  desc "Claim fixed callback paths and tunnel them to localhost"
  homepage "https://github.com/iml885203/tunlease"
  url "https://github.com/iml885203/tunlease/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "ff404c71ea02683b4a0d8d6b180c2cf085964b59fe927b2974fcfcb73b2746ba"
  license "MIT"
  head "https://github.com/iml885203/tunlease.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=v#{version} -X main.buildTime=homebrew"
    system "go", "build", *std_go_args(ldflags:, output: bin/"tunle"), "./cmd/tunlease"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/tunle --version")

    port = free_port
    (testpath/"config.yaml").write <<~YAML
      listen: "127.0.0.1:#{port}"
      fail_open_url: "http://127.0.0.1:1"
      max_claims: 1
      whitelist: []
      tokens: []
    YAML

    pid = fork do
      exec bin/"tunle", "gateway", "--config", testpath/"config.yaml"
    end
    sleep 1
    system "curl", "--fail", "--silent", "http://127.0.0.1:#{port}/_tunlease/healthz"
  ensure
    Process.kill("TERM", pid)
    Process.wait(pid)
  end
end
