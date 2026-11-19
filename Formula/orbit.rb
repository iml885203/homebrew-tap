class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.4.1/orbit-darwin-arm64"
      sha256 "aa9dbce9b70bd5ab5cfd8c451fb45a79435cec310440bf04fd4909beaee99b2a"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.4.1/orbit-darwin-amd64"
      sha256 "bf522ee4551d839298d6cf86ef9c5eaf9fb17a67806bc527ac1058a2c65adb23"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.4.1/orbit-linux-arm64"
      sha256 "3f9cf5e2588e4b726a95d7a4a421996e9f74d555ad9aa9014cc21e3218bc3e98"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.4.1/orbit-linux-amd64"
      sha256 "53f6c0774a123aeb4fa5c5276201680ed8c533791db1044a6ebfaf735f07f3be"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
