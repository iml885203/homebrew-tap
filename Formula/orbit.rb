class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.6/orbit-darwin-arm64"
      sha256 "2be3c4e92607ce3943f176eff10f53536ecde903f8f8df157910c6a5bb6f0cb4"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.6/orbit-darwin-amd64"
      sha256 "a6d5326a244dcad631e88d4d831e01d2475477065b72b057ae34df0f52c8f554"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.6/orbit-linux-arm64"
      sha256 "b26f0bd7bd6bd0631ba81d5bff7f8773f4ae05c8b8292e0fc0c8f1b056494051"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.6/orbit-linux-amd64"
      sha256 "36fad045599959e595a7256d50a8633e8c84cc10ad88cf0a96efff1c8978e48b"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
