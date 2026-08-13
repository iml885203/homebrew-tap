class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.2/orbit-darwin-arm64"
      sha256 "2cccef0ca9a203837c43b2470533ba5c53d59d77c54cc1f4a8081d202f493671"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.2/orbit-darwin-amd64"
      sha256 "f2a23ed012e98437b9566cdcbcda54b14d71499852a121b5e849330c06211436"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.2/orbit-linux-arm64"
      sha256 "df56d6d2b9ee5016bccb18b5aed5ee8c29bbe93eca99be11b262c6a8a1f13f1d"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.2/orbit-linux-amd64"
      sha256 "b018ee2fa6ae75337b5aa3154382f1b5670c2ff46649ac1481d86d8e33313fd5"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
