class Motokano < Formula
  desc "Self-immolating MCP server: serve N tool calls, then wipe state and exit"
  homepage "https://new1direction.github.io/ningen-shikkaku/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/New1Direction/ningen-shikkaku/releases/download/v0.1.0/motokano-aarch64-apple-darwin.tar.xz"
      sha256 "41354f419a905180bc0aaab2175b5ca42bb74e338c7b37ebf16e14da80abd66b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/New1Direction/ningen-shikkaku/releases/download/v0.1.0/motokano-x86_64-apple-darwin.tar.xz"
      sha256 "a10716eece44e03bb77cf08f2e401a68b025fbdf7ef0966c626b456d594d1d0c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/New1Direction/ningen-shikkaku/releases/download/v0.1.0/motokano-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f03107144d3130d23ade5527e9bee1f650e23fe9f05185f230618f5c274b093a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/New1Direction/ningen-shikkaku/releases/download/v0.1.0/motokano-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "48677a637bae32747a891b98ff73a25371817315a3d7815dead615fe73923678"
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
      bin.install "motokano"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "motokano"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "motokano"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "motokano"
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
