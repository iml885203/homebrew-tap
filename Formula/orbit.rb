class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.2/orbit-darwin-arm64"
      sha256 "c86ac0dfd536290aad35688a39d5a8d8ce4e49d0f36871cbf5077c0ba72c38fb"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.2/orbit-darwin-amd64"
      sha256 "5bb0a61e670cced545d3466b5a44c7eca934befd7d728d72bda1b87453e581b7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.2/orbit-linux-arm64"
      sha256 "2798edc00f6b7a1152db9ce1fcc8cc28196d174ba85920f7f6b36594379bf5f1"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.2/orbit-linux-amd64"
      sha256 "05d7d42c92a18aa9dd34a3aa0a8c5e2833d3f4b6cd58b13feb27aaf68b0d2027"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
