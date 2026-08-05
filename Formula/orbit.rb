class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.11.0/orbit-darwin-arm64"
      sha256 "58967da9504c877fc0db63939601bc38e0afb5ebd268cff106ade0824bb488ec"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.11.0/orbit-darwin-amd64"
      sha256 "b438f952731fe09017cd16b664e3ae69c827b0898ec0423059c8f0c697f76ad4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.11.0/orbit-linux-arm64"
      sha256 "c30f67feaf12b768ce77578bba299bc90bea8d278369a3316ab099b189311282"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.11.0/orbit-linux-amd64"
      sha256 "00e6983e5b6518e5fdfb1fd2a24e250519a47c2c02a5256a7cfee68778d8a009"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
