class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.10.0/orbit-darwin-arm64"
      sha256 "efc4a0ee6da29307d5c5575d0a3ec5f65335d09f012bee551b367b2a6399d0ca"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.10.0/orbit-darwin-amd64"
      sha256 "6c209083fae4e2914cece44ce332113e614c4605dc133943f225d9e2b954e79b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.10.0/orbit-linux-arm64"
      sha256 "fb8af59c2d297f63feff229521fc74f100b0fd1f411076648de1c0dca1be82cb"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.10.0/orbit-linux-amd64"
      sha256 "2681157512868196427130c6fa0913001776e60c98fcfd7cc13cf5f1c232ef6b"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
