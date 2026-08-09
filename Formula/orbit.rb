class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.12.0/orbit-darwin-arm64"
      sha256 "65169bd41a5a77f74ae6e372642b335dba47e411962015f4be511b7d5801e902"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.12.0/orbit-darwin-amd64"
      sha256 "73f62e172b2f87d62ab6f26fdf60b32db010590d83212dc026d9b54b4043f269"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.12.0/orbit-linux-arm64"
      sha256 "85acae563cb157dd4dbebe79d151082850d6933ae3a2478e72d5d02721bfd547"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.12.0/orbit-linux-amd64"
      sha256 "83d3c220cc5c6db1dbf0ffc0359a89bbba733847dd09fca8cc1be340a9dbda8a"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
