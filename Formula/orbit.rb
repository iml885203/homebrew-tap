class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.13.0/orbit-darwin-arm64"
      sha256 "072a68919e3a72111c10c325efabe3909a1ddcf1541615dad4dbd11496af0375"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.13.0/orbit-darwin-amd64"
      sha256 "fd9144978233d6598776235665da7766267e5cb683fa63a31f206a1ab81d33f3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.13.0/orbit-linux-arm64"
      sha256 "a2bbbc53326daf4511503fb2b121c5eb75034f3ac7b7fd0a6373dcbfe830b41a"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.13.0/orbit-linux-amd64"
      sha256 "4a1b1d62f30502bf661826cd5a109280ed1f6df969ca804fe603c6a50c35b34e"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
