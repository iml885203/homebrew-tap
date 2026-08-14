class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.3/orbit-darwin-arm64"
      sha256 "d1f185170eeae8496e2309ec6d39601522c5793ee52cce15b807bd1246858571"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.3/orbit-darwin-amd64"
      sha256 "6fc027569c3d92a9351f5620078f642d1c0b162a325c02ab852831cf82fbfa15"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.3/orbit-linux-arm64"
      sha256 "5e4e9c9f92fc3d610f8dec592692bf0f6989f4016f6e6fc32a7a66963e873a58"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.3/orbit-linux-amd64"
      sha256 "18ba080477f3e90601af0204398bf2ed8fcc9924ad322cd4bfe03a34d901a4a0"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
