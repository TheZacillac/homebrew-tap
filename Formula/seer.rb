class Seer < Formula
  desc "Interactive CLI for Seer domain name utilities"
  homepage "https://github.com/TheZacillac/seer"
  version "0.49.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.49.1/seer-cli-aarch64-apple-darwin.tar.xz"
      sha256 "2b4450fad500279cd3634bf0e8a4f507fd5c011003d1104ec6cdf9e14beb3ad1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.49.1/seer-cli-x86_64-apple-darwin.tar.xz"
      sha256 "509c634ec058424c6eb71ff93e50de0931a652258586f58d4fd43e9010c2fd59"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.49.1/seer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c79e652d166848a35af03bf073b21711aefcd8ac2fbad30a116c131e37d68c87"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.49.1/seer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d52f4a6f0de26f3cc45076f197892d11f4f1428463f088438a00d07c745fb1dc"
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
