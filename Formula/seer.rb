class Seer < Formula
  desc "Interactive CLI for Seer domain name utilities"
  homepage "https://github.com/TheZacillac/seer"
  version "0.44.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.44.1/seer-cli-aarch64-apple-darwin.tar.xz"
      sha256 "1988d2b595a41ec29cbe044ff2380fcec74b333667f6ead3ef475903a99a410d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.44.1/seer-cli-x86_64-apple-darwin.tar.xz"
      sha256 "892de4251783ae90984c0aecf8689d8769770b0b696c3401788698d9798000f8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.44.1/seer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "844029ca9718aefd0781f1dcb3dc7b3588da5910f9d78309c513ba0987e424b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.44.1/seer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4c98eb0f2b64c8b1b0f197d650db8458c61df54374c88c39de765b0aaa2869e0"
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
