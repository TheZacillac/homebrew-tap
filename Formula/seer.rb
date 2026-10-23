class Seer < Formula
  desc "Interactive CLI for Seer domain name utilities"
  homepage "https://github.com/TheZacillac/seer"
  version "0.55.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.55.0/seer-cli-aarch64-apple-darwin.tar.xz"
      sha256 "fbe3ed2dbe5fea87c9ef297e894e442fb081291aa7f9415e6d551fc2c7ac41d0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.55.0/seer-cli-x86_64-apple-darwin.tar.xz"
      sha256 "cfa08f8f74fe273562f9b484708b174bd3c2ebaf31d790fd7ff266647d7a2bce"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/TheZacillac/seer/releases/download/v0.55.0/seer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fa75ecf4797b362945b1b782c6457166589f859755a2fe7ad87d85d76c158422"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheZacillac/seer/releases/download/v0.55.0/seer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e298343a08e41fde47aada1172a9de25d6754cae08671315aeb33863b7b6289b"
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
