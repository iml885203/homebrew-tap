class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.14.3/orbit-darwin-arm64"
      sha256 "cf92769b223e1bdbbf8c9c274ab0e982661733cc92795e8c0715d7dfc81d7555"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.14.3/orbit-darwin-amd64"
      sha256 "bdb8523b6a8ced7d21a0578ba1c9559ed66a99de54813943f58dc54a3c0fed81"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.14.3/orbit-linux-arm64"
      sha256 "70dcdedcd29621c4d888d35abe7cc2970817e504df0a28215c21ed9122703164"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.14.3/orbit-linux-amd64"
      sha256 "938610c3100f53a90df34f1a0e896e086177b4afe03fa79351a018d90e55d4bd"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
