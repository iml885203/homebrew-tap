class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.1/orbit-darwin-arm64"
      sha256 "95c0ee0a748843cf4a26f122167cdedd10b37242396c44c6f2e0120884042978"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.1/orbit-darwin-amd64"
      sha256 "f65a3a0f95b49e2fe9f895f960b6a5640f1562dfce962a157a3eba46eb4189aa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.1/orbit-linux-arm64"
      sha256 "79d2336e9266e4e5ff0c7436ae9e2a4b5052054ab42e946b1c7432b72211147a"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.1/orbit-linux-amd64"
      sha256 "ccf9d5f7f2c58a195299cf17195c386aae7d1570da00463a2ba65bed36496312"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
