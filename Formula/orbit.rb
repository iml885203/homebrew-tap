class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.2.0/orbit-darwin-arm64"
      sha256 "1f203e0080d4f162df8d85cda5bbe53aecd21539f1e651eb2883ccbd11620b40"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.2.0/orbit-darwin-amd64"
      sha256 "4b95adb4af931f347d04a25c1b24f246ca1c8d16e379ef7b88d6c90a3d2d23ec"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.2.0/orbit-linux-arm64"
      sha256 "4e809105c241caa8c3630cedec881716ff1a4b1782a97e8abe44f3d23161b3a9"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.2.0/orbit-linux-amd64"
      sha256 "e4abc7609d9a00045e09e4b2839a0105b8ad335d66955c6aeb4a42afba4edbdb"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
