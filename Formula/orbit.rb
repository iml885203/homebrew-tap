class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.9.1/orbit-darwin-arm64"
      sha256 "29bcfe975ff00601869b85f2de092c87842539be7b9994a5ebcbefa9481cb276"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.9.1/orbit-darwin-amd64"
      sha256 "0faa9e2df18d41d18423908a9cc0c398f02157a05a33771c7c95269622bfaeb0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.9.1/orbit-linux-arm64"
      sha256 "1f9ac1183bd3349ee8a128acbfcaa7725f1baed871b78124532a099111c4333a"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.9.1/orbit-linux-amd64"
      sha256 "f69c472947595176cf05f4145efecc924574bfa8f6829152103b752fc765b2db"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
