class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.1.0/orbit-darwin-arm64"
      sha256 "e69b2f3d8d0c392d55436abc9e9e6e39c4cfaa75d8e36daf342082aa248b7dbc"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.1.0/orbit-darwin-amd64"
      sha256 "1c90d4086265a377a43003042a58c1af6016b5a7644d9033fde03221491c567c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.1.0/orbit-linux-arm64"
      sha256 "efabbc30284e9b75d7f9a79709f44e4b4ece0aa04209cd49904c1d6338e65357"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.1.0/orbit-linux-amd64"
      sha256 "556188caa41f66cd7f67cf1a91e0fc0f13d36312bb3409391b9a1bebc23f7808"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
