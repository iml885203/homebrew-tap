class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.6.0/orbit-darwin-arm64"
      sha256 "9f2d6a3bf5d2c452a9ac18d1a4650977a5613f4016101c84f16649ba46a956a9"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.6.0/orbit-darwin-amd64"
      sha256 "920271fc92ba7789b334bb1bc9f8f8d14722c35483b88757c0bf2c6c1ba2c46e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.6.0/orbit-linux-arm64"
      sha256 "ee345ec99604379420dbd285fab9269449db098f982e3fee169afa40b9fdda98"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.6.0/orbit-linux-amd64"
      sha256 "41948ad6ef0a01572837a5fc8af3b68d1a1bb123c735d3ba26d514916b59e83d"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
