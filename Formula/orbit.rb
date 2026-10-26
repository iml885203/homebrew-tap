class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.7/orbit-darwin-arm64"
      sha256 "4966fc85e7450de8a86a0fb53408fb1872ce82429f84d816da14c5899f499716"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.7/orbit-darwin-amd64"
      sha256 "4aa2fc8387368f6d6e51bb14b2661bc475754214620616976b7ee7facc3bfc0b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.7/orbit-linux-arm64"
      sha256 "c62d7b93f52b955d69edce68506a731a8fb2c8ccea88a04289756c50db97bb12"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.7/orbit-linux-amd64"
      sha256 "e60f12557021674a822b95b0314601626ceacd4dbc339b8527edd04245c54a29"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
