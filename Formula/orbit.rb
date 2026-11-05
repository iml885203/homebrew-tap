class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.0.0/orbit-darwin-arm64"
      sha256 "22af3231a746c055e47ee54f4430c40d2c871d92919a0ce24e26aa17610fbe37"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.0.0/orbit-darwin-amd64"
      sha256 "b2b73bbd193340f25c94baed1f38d0f608e12b18ee14365eb1025cca72c0eed8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.0.0/orbit-linux-arm64"
      sha256 "780544139f4636fab01f1149802337626b1e08d18bf81aa030de64425979e9cd"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.0.0/orbit-linux-amd64"
      sha256 "e0eccf58f91773ea3bb5afb5b2a60be8fdd75bcc03b55cefdae5902c0b937e4b"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
