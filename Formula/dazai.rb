class Dazai < Formula
  desc "dazai Phase 2 CLI — hardened dead-man's-switch daemon"
  homepage "https://new1direction.github.io/ningen-shikkaku/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/New1Direction/ningen-shikkaku/releases/download/v0.1.0/dazai-aarch64-apple-darwin.tar.xz"
      sha256 "2dedec2e1418698cb3f41ca9e08c51479476c90b3f1cf9546163dc0a5922293c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/New1Direction/ningen-shikkaku/releases/download/v0.1.0/dazai-x86_64-apple-darwin.tar.xz"
      sha256 "61631288873758ce5861cb51ec6c6bc812aef2c771966c87c3fb85717086c1fa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/New1Direction/ningen-shikkaku/releases/download/v0.1.0/dazai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9520a5787749221be32e64609060d6fdd9188fd4940ea9950c8501f2aa5e74b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/New1Direction/ningen-shikkaku/releases/download/v0.1.0/dazai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4c4c060f3ad4405df913be1da136ff48a8a1f874cb26df1a257a0077fe465c4b"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "dazai"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dazai"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dazai"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dazai"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
