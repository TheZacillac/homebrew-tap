class Seer < Formula
  desc "Interactive CLI for Seer domain name utilities"
  homepage "https://github.com/TheZacillac/seer"
  version "0.58.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.58.0/seer-cli-aarch64-apple-darwin.tar.xz"
      sha256 "7f021509285ea5f9d29934e54a4cf17c944ebad4d52a0ef5cc0a56ef3fe5aedd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.58.0/seer-cli-x86_64-apple-darwin.tar.xz"
      sha256 "7c02c884c3cfb5bda4f1ec04e6521e4c6cc048ef3e26933a1e18a8e50f74a715"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.58.0/seer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4cae63ffb5a8b0ed66d321298da012948653739de2c9cfe4fab0849987517e9f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.58.0/seer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0ef70a37290501ae5dbb89200011f49977f6b5e74cb6a1181003158f97377711"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
      bin.install "seer"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "seer"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "seer"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "seer"
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
