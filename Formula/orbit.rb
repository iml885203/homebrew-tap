class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.10/orbit-darwin-arm64"
      sha256 "b070eef3a2feb2f5c4a9bd5f25c15390a612725fc3744031976ade0bc1f41c83"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.10/orbit-darwin-amd64"
      sha256 "dc56ad4eb743f3d117d559e149d5ce91c5fafdcfd008ac39a2d6f006c7ad0f1e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.10/orbit-linux-arm64"
      sha256 "bf2a0a75f996a850a15026564168aa69897ab3eef57808628cf35c01864c7c1f"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.10/orbit-linux-amd64"
      sha256 "0adcccd22d77e1d519d1178abc5d374ee41973d19087c5d1cd487692a2d76068"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
