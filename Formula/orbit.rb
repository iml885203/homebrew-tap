class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.3.0/orbit-darwin-arm64"
      sha256 "5fc41bb9844e59fae9eb4225608b92298baa51ebeea0d0d1ee3b6ec06b733154"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.3.0/orbit-darwin-amd64"
      sha256 "eff8aa4cf4a34a8aa89a7b049c26988fbf3401fb63252c99fbca3119ad1afa00"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.3.0/orbit-linux-arm64"
      sha256 "81b60e5b97e5ef90c3426c2098b75b15c3a7f195d424cc63cb76c1df79713a2f"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.3.0/orbit-linux-amd64"
      sha256 "1e39b4c221f906dc5879ae7ccb7b03a878da963aa89c2f02ba02cbca36db5cb8"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
