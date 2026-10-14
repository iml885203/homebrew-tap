class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.5/orbit-darwin-arm64"
      sha256 "a1ade21b88899a3c34799815960f9482bcec9536c97cf8d6b1d97deb52c07729"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.5/orbit-darwin-amd64"
      sha256 "0e0db2c2345d556a37458e189833f8968f1613c63811c6e7809dec2ed30a7472"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.5/orbit-linux-arm64"
      sha256 "23aa3470b9ba6a31082c19104c96769d01260fa55fe92f20dffef7fab8c96ed9"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.5/orbit-linux-amd64"
      sha256 "2ab9d74371f662ebd258d51645b8121112c28d3de9a5e2df1399fc3e531d71a6"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
