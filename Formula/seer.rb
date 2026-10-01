class Seer < Formula
  desc "Interactive CLI for Seer domain name utilities"
  homepage "https://github.com/TheZacillac/seer"
  version "0.52.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.52.1/seer-cli-aarch64-apple-darwin.tar.xz"
      sha256 "a89507a9de4579f4a704a3c3a2e8d7ea6f06b967c78e4bf8d93c4bbf6743a5ca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.52.1/seer-cli-x86_64-apple-darwin.tar.xz"
      sha256 "b2e0796f1c5923022a22db0913235dea4c686307709c2e1ac53fd30fce09cf67"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.52.1/seer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6a1134ed80dbb2cfc5451052410e5fecadcab7ec6e61c354e81b868e9ec727b0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.52.1/seer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "75a714f9414d61b223a005dbe23affb1959605e1cef0dd740089f0a3ba92335d"
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
