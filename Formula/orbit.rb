class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.5.0/orbit-darwin-arm64"
      sha256 "c993d5eaf2473e42196518f73d71555b304c323770053bc3bab9750e782cb817"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.5.0/orbit-darwin-amd64"
      sha256 "b02f72e25459a4c00d95bff01843640b23bd191a75393fda722b75e844cbc364"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.5.0/orbit-linux-arm64"
      sha256 "2806d7f97004be02b46b293fffddf6eda4368943f114f1ce773229ba9ac9198b"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.5.0/orbit-linux-amd64"
      sha256 "3f5d399107a1179026c48f77e77aaf44cd74a544006fd0dc63c41e45bc9cc5c2"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
