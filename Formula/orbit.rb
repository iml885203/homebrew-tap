class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.11/orbit-darwin-arm64"
      sha256 "0c03152b30c1222b8a274d8df3ef5e990ce23937d12497ceb761a503cb9027e9"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.11/orbit-darwin-amd64"
      sha256 "4c5f00a627ca3e2129a2616059b37714d4f172ec31d24443e5ac368507f8d3b6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.11/orbit-linux-arm64"
      sha256 "9a600f7e049b6e21d79aee6c6e42c0ac094e8c9fcbd077ea3e8948dcd713299b"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.11/orbit-linux-amd64"
      sha256 "fbab169ecddd6ca71ecc1db86e22ba8f72c0a2739e96d6e4d91d73f3f39b9197"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
