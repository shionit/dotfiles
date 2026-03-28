# dotfiles

A repository to automate macOS setup from scratch.

## File Structure

- `Brewfile` — Manages everything installed via Homebrew (brew, cask, mas)
- `README.md` — Lists apps that require manual download (not available via Homebrew)
- `install_mac.sh` — macOS setup script (Xcode, Homebrew, Brewfile, macOS defaults)
- `install_any.sh` — Entry point that detects the OS and calls install_mac.sh

## Editing Rules

- Anything installable via Homebrew goes in Brewfile. Do not add it to README.md.
- Only apps that require manual download should be listed in the "by Download" section of README.md.
- Avoid duplicate entries across files when adding or removing items.
