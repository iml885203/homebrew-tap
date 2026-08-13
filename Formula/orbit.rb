class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.0/orbit-darwin-arm64"
      sha256 "fe7dcc44a5b58772adf37d0ca8f354e55c416000e894624ec60d103e78b0f81b"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.0/orbit-darwin-amd64"
      sha256 "97d7085fabda4b53a7cfff65e3985517e31786e8d4c85956a524c2014abb7bb4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.0/orbit-linux-arm64"
      sha256 "e440d29b9d4fb088f60ad95749f5a41a39e4740a5bbea5d3a760570e50a934db"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.0/orbit-linux-amd64"
      sha256 "cdc8c69f8d63a2844486a3cf28541e2642abcd1ebc4090bef812bd60c8a2649c"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
