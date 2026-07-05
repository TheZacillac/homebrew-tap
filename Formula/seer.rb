class Seer < Formula
  desc "Interactive CLI for Seer domain name utilities"
  homepage "https://github.com/TheZacillac/seer"
  version "0.40.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.40.1/seer-cli-aarch64-apple-darwin.tar.xz"
      sha256 "5b724fcf86bd2b7831e34fbcb8f05a2e7a85faede57f33785765cd056a5b9413"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.40.1/seer-cli-x86_64-apple-darwin.tar.xz"
      sha256 "733e248dac8c88b6837f36ad7f117bef84ddaf99e86173d7b4164a68b9c1c4bf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.40.1/seer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3de49081d86c83023b86bb78e523977ae3c8ae3ecc5538ac071e4e43a780d074"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.40.1/seer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fb34e609f706df5fe5434e82d4fc25c63f8ded411f4d58543ac9543a4103be4a"
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
