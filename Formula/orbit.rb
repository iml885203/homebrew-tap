class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.8.0/orbit-darwin-arm64"
      sha256 "61fe3ee9d71f9fb859eaf632cede197f51df3ca548a0df2ca8fbd1f3976a3035"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.8.0/orbit-darwin-amd64"
      sha256 "174b6951fe16ff3261b901da1931109951e9defa394909b820061b26af481b0f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.8.0/orbit-linux-arm64"
      sha256 "2769cacac7571eac0214526ec40a43f8237f2a6a0c994b60b69b270032b98b82"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.8.0/orbit-linux-amd64"
      sha256 "66d95beebb53a2f39fa2a5984ab34e828cf9c3393f4d8077407e86199c50e0cb"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
