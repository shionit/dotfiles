#!/bin/bash
BREWFILE_DIR=.

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
  xcode-select --install
fi

if ask 'Homebrew install?'; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew doctor
  brew install caskroom/cask/brew-cask
fi

if ask 'execute brew bundle(Brewfile)?'; then
  brew tap Homebrew/bundle
  pushd $BREWFILE_DIR
  brew bundle
  popd

  brew link openssl --force
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
