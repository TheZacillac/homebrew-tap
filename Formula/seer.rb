class Seer < Formula
  desc "Interactive CLI for Seer domain name utilities"
  homepage "https://github.com/TheZacillac/seer"
  version "0.43.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.43.1/seer-cli-aarch64-apple-darwin.tar.xz"
      sha256 "2615eb77de8c80b6260a314abd4ece519f50fd3f0351fb7161f17a159fefae9f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.43.1/seer-cli-x86_64-apple-darwin.tar.xz"
      sha256 "771c84bd020bc8febe44a3df1c4863a255eb2afbee78aec0c7f74aaf35809e23"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.43.1/seer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "617adf8532d1d56e3266daa0d572a80aefbc30c008a8a525e5fcd36523d4c6ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.43.1/seer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ddd1825f3c7bfbaa64fbe8c280c3a1f13c1a1cc80460eef247a2e14f89d64d51"
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
    bin.install "seer" if OS.mac? && Hardware::CPU.arm?
    bin.install "seer" if OS.mac? && Hardware::CPU.intel?
    bin.install "seer" if OS.linux? && Hardware::CPU.arm?
    bin.install "seer" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
