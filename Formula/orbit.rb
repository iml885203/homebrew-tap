class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.5.1/orbit-darwin-arm64"
      sha256 "b9a8b00a6a66211d52104e861e34386a45296f7782d57c8b1910ba73e5413843"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.5.1/orbit-darwin-amd64"
      sha256 "19b746beef34fac9f4085d6e70d9edffcda02a38241dc676581ee1e0f707625f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.5.1/orbit-linux-arm64"
      sha256 "89618b589dcfe2442772b9cf8dd95258b3973ecc1fc8e666504cc7e34bd424ef"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.5.1/orbit-linux-amd64"
      sha256 "cd4fd41aac1f6e230cbbe1d7d73d7b721a1a044c8f258b1493e2d271bd9e9283"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
