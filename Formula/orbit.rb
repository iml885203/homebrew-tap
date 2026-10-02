class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.4/orbit-darwin-arm64"
      sha256 "f76cabb8732b6c9cd695f8c493430dbfbea7fe7f349a45034900edf37aad1f2c"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.4/orbit-darwin-amd64"
      sha256 "71a81a93fb92674629401ac10ceaa7a26dad2e13b1aab034b985ed2a1026bf49"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.4/orbit-linux-arm64"
      sha256 "8a92d04017f41f965f4d59772ef3796701133474472eac00430a48ed63d291fd"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.4/orbit-linux-amd64"
      sha256 "8cadf58e71a1bb05e92aa79c13a3b1e4b0d0f7825a7aecd6764f68ab9b87f441"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
