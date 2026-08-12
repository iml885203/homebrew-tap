class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.14.4/orbit-darwin-arm64"
      sha256 "c01f74ffe2fe7ffe86b015910c6ea41e8aa4f3eaedea9a025ff9637aff7b4bfe"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.14.4/orbit-darwin-amd64"
      sha256 "ec40c86f3d5b35b2c7ddce04892a6350b7bb4379eab368b4f3c82aa5250ca061"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.14.4/orbit-linux-arm64"
      sha256 "a81e2d037d3f7846a49d536e81eafacf571591e43e69e883ac823e87c3a36eb6"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.14.4/orbit-linux-amd64"
      sha256 "a7161ebe5293b5b71c5fa4537f759fecc3f1215568c515d7b6fc5ce94d142125"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
