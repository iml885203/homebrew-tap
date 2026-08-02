class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.7.0/orbit-darwin-arm64"
      sha256 "da48eae3e5b1083ac8b9fb555259fb42004ca13eab94faf5c6d48f9fbbf43d5f"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.7.0/orbit-darwin-amd64"
      sha256 "a9c041207643c9ea3290ea277162531a7cbad57f9ee25fc6573ddeceb9745698"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.7.0/orbit-linux-arm64"
      sha256 "906335976b9f43842f5a87a52824ac4eed85f98a64818cd89b16605bc977c1e1"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.7.0/orbit-linux-amd64"
      sha256 "1e0c43b96f62de5a9bac861a13d4bdefe0fb9ac4390088e6d1000224784bc539"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
