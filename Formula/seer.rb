class Seer < Formula
  desc "Interactive CLI for Seer domain name utilities"
  homepage "https://github.com/TheZacillac/seer"
  version "0.44.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.44.2/seer-cli-aarch64-apple-darwin.tar.xz"
      sha256 "12611b207701efad90df1ade55c5dcf2a113722d6354a8fb3c155c0ed81fc554"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.44.2/seer-cli-x86_64-apple-darwin.tar.xz"
      sha256 "8f1c11562d3ae2e4e64ff4052e9f932495e01e96afce00e685b64cecda48e8f5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.44.2/seer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "69af6f9ec21267423707697a2d4c9a15dbacfbd850a0348bb5e4f703b8e9320c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.44.2/seer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "529a656366192cfc4f58b5bd605e707a699d3a92f3b4fae5736f2e3b0e2d6bd3"
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
