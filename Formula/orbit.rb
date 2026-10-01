class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.3/orbit-darwin-arm64"
      sha256 "bf9c1ac2171cd6e9d502e50ae27a39cae89b51ac9623426e0f71921515d8bb42"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.3/orbit-darwin-amd64"
      sha256 "f3451a4a327fe5bfb31302159adc051bb9f1f87c8645b0d073e9b7882bd32528"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.3/orbit-linux-arm64"
      sha256 "453ab901f53ef6d697a72201a0477460f1349006286ad6dfd19663ef4be0e321"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.3/orbit-linux-amd64"
      sha256 "b285dcea9bc844a9bea674753cdcf480a29917101c93b8159a6af6932c5926a1"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
