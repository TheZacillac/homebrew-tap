class Seer < Formula
  desc "Interactive CLI for Seer domain name utilities"
  homepage "https://github.com/TheZacillac/seer"
  version "0.40.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.40.0/seer-cli-aarch64-apple-darwin.tar.xz"
      sha256 "ae1a8bbab93a202078d2e9e86a824acfa0c0423160886a369ae2407aae1af5fe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.40.0/seer-cli-x86_64-apple-darwin.tar.xz"
      sha256 "d7e1e4fde73a7edcd5f5c68b4b31a2e29f56d8a84a5c99a57384e38bdbe34978"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.40.0/seer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d56f74899116a5bd9a648f1925f15c7b42bdb8d4d65fc5be599fe7fee4592c91"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.40.0/seer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d508640ce22e298b8502e6cf854a2a7660f684a6342c3da425ac79a3ab1965f9"
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
