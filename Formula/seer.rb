class Seer < Formula
  desc "Interactive CLI for Seer domain name utilities"
  homepage "https://github.com/TheZacillac/seer"
  version "0.51.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.51.0/seer-cli-aarch64-apple-darwin.tar.xz"
      sha256 "55e5f2d41cae529de635dbf32cf205001b92305727a6f8013e761b25af6a48c3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.51.0/seer-cli-x86_64-apple-darwin.tar.xz"
      sha256 "7de104cfd121860295f475b3a6b7da8ead814c46c9db2af33dd7c3b040f25a48"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.51.0/seer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3255fe2795c5da6abc9e23caeac5dd625ec8cf6141dd3aa9e2142935f9fc97ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.51.0/seer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a01cdda538af20f5e560534caf659dabfca05a34c7eb51a86d058ab649ec8e2f"
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
