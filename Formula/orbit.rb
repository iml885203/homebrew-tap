class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.7/orbit-darwin-arm64"
      sha256 "f3e7367f6c884ea0ffea67105df88215251f59e948ae86954604b35b2a3159ad"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.7/orbit-darwin-amd64"
      sha256 "772bd880f5f118084325659a8ce071516269375f576376656fbb5095f097a446"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.7/orbit-linux-arm64"
      sha256 "2c2c356b7e028933a74acccc61bd9ea27ba7407764ae899fd530303c97ef09ef"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.7/orbit-linux-amd64"
      sha256 "a3aa9ef1d225a93bf5b2281ee018e672fa469111a306eeaf67665a59a98efeb6"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
