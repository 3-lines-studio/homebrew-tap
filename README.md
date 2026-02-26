# 3 Lines Studio Homebrew Tap

This is the official Homebrew tap for [3 Lines Studio](https://github.com/3-lines-studio) applications.

## Installation

```bash
# Add this tap
brew tap 3-lines-studio/tap

# Install Datafrost
brew install datafrost
```

Or install directly without adding the tap:

```bash
brew install 3-lines-studio/tap/datafrost
```

## Available Formulae

- **datafrost** - Database management GUI application

## Updating

```bash
brew update
brew upgrade datafrost
```

## Uninstallation

```bash
brew uninstall datafrost
brew untap 3-lines-studio/tap
```

## Platform Support

- **macOS**: Apple Silicon (M1, M2, M3, or later) - macOS Big Sur (11.0) or later
- **Linux**: x86_64 with GTK3 and WebKit2GTK

Intel Macs are not supported in the pre-built binaries. If you have an Intel Mac, you can build from source:

```bash
brew install --head datafrost
```

## Documentation

For more information about Datafrost, visit the [main repository](https://github.com/3-lines-studio/datafrost).

## Issues

If you encounter any issues with the Homebrew formula, please [open an issue](https://github.com/3-lines-studio/homebrew-tap/issues).

For application issues, please open an issue in the [main repository](https://github.com/3-lines-studio/datafrost/issues).
