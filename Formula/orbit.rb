class Orbit < Formula
  desc "Run host services and containers as one local development environment"
  homepage "https://github.com/iml885203/orbit"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.8/orbit-darwin-arm64"
      sha256 "9f034856798a9695b693082bb4be6ab584f18804ce3e24b30d98c1b4750a8e0e"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.8/orbit-darwin-amd64"
      sha256 "d508bdd430f83dafaf991bb4602e03c91019b935c082c596767e6b890264f79d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iml885203/orbit/releases/download/v0.16.8/orbit-linux-arm64"
      sha256 "e07520fecdd90dcac485472eb124469a764800a54de291cc2ffea6ade0b35efd"
    else
      url "https://github.com/iml885203/orbit/releases/download/v0.16.8/orbit-linux-amd64"
      sha256 "f0fb690348885bc8c5ec85720825e04ddcd749aceee18239ada94c2445d76301"
    end
  end

  def install
    bin.install Dir["orbit-*"].first => "orbit"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/orbit --version")
  end
end
