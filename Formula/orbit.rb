class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.11.1/orbit-darwin-arm64"
      sha256 "9952d48b1bbd30d1629849c497daf926b2add92824efbd3793033e48d2d9a09b"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.11.1/orbit-darwin-amd64"
      sha256 "68a8e38525258536d9274c2542fb7e5a36fc29a3002c9475cffd50feae8d8d4f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.11.1/orbit-linux-arm64"
      sha256 "b25b064d6f72e61c6a50c44c17e532f0b063416efc2611c178ea01a8fc54e6a8"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.11.1/orbit-linux-amd64"
      sha256 "b4ce8788da9520c71ba7e910c25e58e6704393e8b9106e9b5508e57bb2841591"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
