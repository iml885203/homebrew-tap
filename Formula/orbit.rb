class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.8/orbit-darwin-arm64"
      sha256 "e12517fbd22294980e0f9b0ff85929df819140c80b478b8c8dd9f8a4c2606c64"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.8/orbit-darwin-amd64"
      sha256 "6ac7b4d07215652a3e7db2db0f93bc13018327a3c77ad0973218f794e25ec6b8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.8/orbit-linux-arm64"
      sha256 "47a10dc3b9e22d87512224d90c7d3a3d8e22b41e9e012a745639a821acfe0e9c"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.8/orbit-linux-amd64"
      sha256 "798a8acd477419f9d3d17be25b78cd04d0a4e92eb2c6e521864b16b0b6877be6"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
