class Tunlease < Formula
  desc "Claim fixed callback paths and tunnel them to localhost"
  homepage "https://github.com/iml885203/tunlease"
  url "https://github.com/iml885203/tunlease/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "410630e4b9ecc56e8344b2640ec298f06423cdd0e4f86455d5047b5a8fe2f541"
  license "MIT"
  head "https://github.com/iml885203/tunlease.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=v#{version} -X main.buildTime=homebrew"
    system "go", "build", *std_go_args(ldflags:, output: bin/"tul"), "./cmd/tunlease"
    generate_completions_from_executable(bin/"tul", "completion")
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/tul --version")

    port = free_port
    (testpath/"config.yaml").write <<~YAML
      listen: "127.0.0.1:#{port}"
      fail_open_url: "http://127.0.0.1:1"
      max_claims: 1
      whitelist: []
      tokens: []
    YAML

    pid = fork do
      exec bin/"tul", "gateway", "--config", testpath/"config.yaml"
    end
    sleep 1
    system "curl", "--fail", "--silent", "http://127.0.0.1:#{port}/_tunlease/healthz"
  ensure
    Process.kill("TERM", pid)
    Process.wait(pid)
  end
end
