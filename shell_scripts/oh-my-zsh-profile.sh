#!/bin/bash

## Oh My Zsh config ##
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$PVSH_DIR/zsh-custom
ZSH_THEME="agnoster"

ENABLE_CORRECTION=true
DISABLE_UPDATE_PROMPT=true

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  alias zshconfig="vim ~/.zshrc"
else
  alias zshconfig="subl ~/.zshrc"
  DEFAULT_USER=$(whoami)
fi

plugins=(colored-man-pages git_remote_branch gem colorize)

#Dont show duplicate commands in history
setopt HIST_IGNORE_DUPS

source $ZSH/oh-my-zsh.sh

source ~/.pvsh/zsh-custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.pvsh/zsh-custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=11'
