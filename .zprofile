# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";
# Add `~/.local/bin` to the `$PATH`
export PATH="$HOME/.local/bin:$PATH";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{exports,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Start ssh-agent if it isn’t running yet:
if ps -ef | grep ssh-agent | grep -v grep > /dev/null
then
else
  eval "$(ssh-agent -s)"
fi

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Python version management: pyenv.
#PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"

# nodebrew path
export PATH="$HOME/.nodebrew/current/bin:$PATH"

# Flutter path
export PATH="$PATH:$HOME/programs/flutter/bin"

