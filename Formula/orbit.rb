class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.6/orbit-darwin-arm64"
      sha256 "dedd4f0df007be14cc6154425f7c48d9ddfa046d0ae30e02dc7972d3361e9bd7"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.6/orbit-darwin-amd64"
      sha256 "369a8f67aca31729f7562089d3eb77ff85739a39e68259852609ff71923f68b4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.6/orbit-linux-arm64"
      sha256 "ae65544b6186d7784ece48a4c1a710651226e2eff4441b831ea928b528ad094b"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.6/orbit-linux-amd64"
      sha256 "9363e61f4770ded56366a796d2a8d4bd891415593d1f9c92721c7868cae4e121"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
