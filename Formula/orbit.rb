class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.9/orbit-darwin-arm64"
      sha256 "41a421fd8b338d11cba4b429ba7d31cda37334171f6320f7eb59ead8482e3132"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.9/orbit-darwin-amd64"
      sha256 "2bbad0cf41b3ad1401f3f80799f8939dd69ef29e5cfcbd33653644f732c9368a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.9/orbit-linux-arm64"
      sha256 "6436309a80854113efdbecda483502bb346223fd034e06ae173fd848567725ca"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.9/orbit-linux-amd64"
      sha256 "f7dcd36bf3c87d010ec039d0019f6ec5f9cabb3739d5546b465e9065a89422bd"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
