class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.5/orbit-darwin-arm64"
      sha256 "6070677f2032e1d5544d03385e970d26d34df3dda84309e8c893d45d4c1136e6"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.5/orbit-darwin-amd64"
      sha256 "908426e60e77782abbe392b4b5d2ad956a770ad0c5dcd6e9683587d15d721e39"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.5/orbit-linux-arm64"
      sha256 "8743df61252b58a9bf4ae52c3667b0daa7b725fce1fb14a03303f59d28025d00"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.5/orbit-linux-amd64"
      sha256 "8b05c52543d873ccab44cfaf19e11d211e30aae850a1a9e2ee38c010b32002d5"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
