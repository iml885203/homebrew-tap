class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.0/orbit-darwin-arm64"
      sha256 "5cc795a6faa7fcb6ea4db97a280462478133966016ac76c5986213b80c4ce965"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.0/orbit-darwin-amd64"
      sha256 "4f4b7238839e5d3e5c5fdc92fcba6a1a8d3c646ed5bd7b8fd8b27f70a3f50af0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.0/orbit-linux-arm64"
      sha256 "a0d12c64c99189c98cd6c02bcd619dd804a508333b0d676441deb0632911f43d"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.0/orbit-linux-amd64"
      sha256 "38a4013f2756989a17afbf7a5fb071246fa3ea288ac7d4e12f65f8b43f2ac07f"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
