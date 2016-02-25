#!/bin/bash

PVSH_DIR=$HOME/.pvsh

## __INITIALIZERS__ ##
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Lazy load
k() {
  source ~/.k/k.sh
  k "$@"
}

# Add Rbenv to path, lazy load it.
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)" # Takes about 60ms to load, don't have to lazy load it.

# Used to load node
nave() {
  ~/.nave/nave.sh "$@"
}

## __USER CUSTOMIZATION__ ##

source ~/.pvsh/utils/cli.sh
source ~/.pvsh/shell_scripts/terminal-profile.sh
source ~/.pvsh/shell_scripts/oh-my-zsh-profile.sh

# Add all files in bin/ to PATH
PATH=$PATH:$HOME/.pvsh/bin/
export PATH
