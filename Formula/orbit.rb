class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.4.0/orbit-darwin-arm64"
      sha256 "1eb13c85552234f6985e690752f7fd3debd68bd244f5bd73ae94ade7cd1d067d"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.4.0/orbit-darwin-amd64"
      sha256 "4f45f7ecaf01011ba92b4500944d6f9db0c7333e83b2bf0bec4e5ef80602c539"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v1.4.0/orbit-linux-arm64"
      sha256 "9386d882be93cd5dc3603051684e195649df21876fbe45dce2e60684ca21add4"
    else
      url "https://github.com/iml885203/orbit/releases/download/v1.4.0/orbit-linux-amd64"
      sha256 "fd0a3a904b3377c8cb4a798d86ef35b639859598e39660ff6cad0a5f803895b5"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
