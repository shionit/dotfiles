#!/bin/bash
BREWFILE_DIR="$(cd "$(dirname "$0")" && pwd)"

ask() {
  printf "$* [y/n] "
  local answer
  read answer

  case $answer in
    "yes" ) return 0 ;;
    "y" )   return 0 ;;
    * )     return 1 ;;
  esac
}

set -e

if ask 'xcode install?'; then
  if xcode-select -p >/dev/null 2>&1; then
    echo "Xcode Command Line Tools are already installed."
  else
    xcode-select --install
  fi
fi

if ask 'Homebrew install?'; then
  if command -v brew >/dev/null 2>&1; then
    echo "Homebrew is already installed."
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
fi

# Make brew available in this shell (Apple Silicon: /opt/homebrew, Intel: /usr/local)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if ask 'execute brew bundle(Brewfile)?'; then
  brew bundle --file="$BREWFILE_DIR/Brewfile"
fi

if ask 'setup finder?'; then
  defaults write com.apple.finder AppleShowAllFiles TRUE
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool yes
  defaults write -g NSNavPanelExpandedStateForSaveMode -bool yes
  killall Finder
fi

if ask 'setup Mission Control?'; then
  defaults write com.apple.dock mru-spaces -bool false
fi
