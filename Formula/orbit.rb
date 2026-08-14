class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.4/orbit-darwin-arm64"
      sha256 "6389f6254113aa5b5596ebb4323f8c71be2600d590647e39a464d450540e8036"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.4/orbit-darwin-amd64"
      sha256 "d9ac7b94c9deb55646ff1953b5a040ddd7b6912e8c047bf7b6184571c08c55fc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.15.4/orbit-linux-arm64"
      sha256 "f38018cd80f5ca1f84faf2928455d2641176b59e364161c688a10e0f2c768ddb"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.15.4/orbit-linux-amd64"
      sha256 "3f003157425c5583ba8ebfcd6ff298cca070a11bb530678e89e17af6d32ec23e"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
