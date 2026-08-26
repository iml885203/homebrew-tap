class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.1/orbit-darwin-arm64"
      sha256 "64d1cb0b732c69a055280e1067427d7058025d9d9e1796ec5f83e6db4a820648"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.1/orbit-darwin-amd64"
      sha256 "1298239ca566970df292c364841604eb482719410a378530e82be42dce632c97"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.1/orbit-linux-arm64"
      sha256 "bd5bc0141d9b6482f8e0877369c154e67c71b4e36f351572215dd26f45775f91"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.1/orbit-linux-amd64"
      sha256 "5eb1f077fec01fefd7949c7e70f8d7857302a159c82b370ce4efd0e6637ab363"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
