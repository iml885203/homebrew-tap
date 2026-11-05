class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.17.0/orbit-darwin-arm64"
      sha256 "c56c0a8faaf58cf1d2da5034a77b10969363b1dc24d9e96ba000be004dee9f4d"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.17.0/orbit-darwin-amd64"
      sha256 "93878f460e7421aabe3dc4c53c565393970281b407413cf76b3d318a047a429b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.17.0/orbit-linux-arm64"
      sha256 "f7b7098c3003ffa5bc6a7f0f3030d81d3d6153b9448592614242727b66f96d37"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.17.0/orbit-linux-amd64"
      sha256 "719ebb722f1b4320b73d4532da7e732ed9ab2b920f96ffa13b526fee737d3fcc"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
