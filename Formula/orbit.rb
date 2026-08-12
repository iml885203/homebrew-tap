class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.14.2/orbit-darwin-arm64"
      sha256 "069ba524dbaa09bb63b9c22109d1d01aa83eeb45309046e22ed5dc8b9de3e8fa"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.14.2/orbit-darwin-amd64"
      sha256 "c2506ad5f3fb213ba142a8cea4251c1caa41170d7d40241aca8b007945cb0742"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.14.2/orbit-linux-arm64"
      sha256 "5b9f570f0adb6d4369aa2fee766cc5ebde257e9a622ba2e69b24218108e8dc63"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.14.2/orbit-linux-amd64"
      sha256 "e3fb11c0b4e6db4568eeb6e3f044ab3ad68c6e2b92f724ae0135839b3b809268"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
