# homebrew-tap

Homebrew tap for [**Seer**](https://github.com/TheZacillac/seer) — a
multi-interface domain name utility (WHOIS, RDAP, DNS, and domain status
checking) with a CLI, REPL, and full-screen TUI.

## Install

```sh
brew install TheZacillac/tap/seer
```

Or tap first, then install:

```sh
brew tap TheZacillac/tap
brew install seer
```

## Upgrade

```sh
brew upgrade seer
```

## About this tap

The `Formula/seer.rb` in this repository is generated and published
automatically by [cargo-dist](https://opensource.axo.dev/cargo-dist/) on every
tagged release of the [seer](https://github.com/TheZacillac/seer) repository.
Please don't edit it by hand — changes should be made in the main repo's
release pipeline.
