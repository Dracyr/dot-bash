#!/bin/bash

## Oh My Zsh config ##
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"

# completion
autoload -U compinit
compinit

# prompt
autoload -U promptinit
promptinit

#Dont show duplicate commands in history
setopt HIST_IGNORE_DUPS
# correction
setopt correctall

#Don't try to start sublime when in ssh
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  alias zshconfig="vim ~/.zshrc"
  plugins=(gitfast debian wd history extract autojump colored-man colorize ruby gem bundler)
else
  alias zshconfig="subl ~/.zshrc"
  DEFAULT_USER=$(whoami)
  plugins=(gitfast debian wd history extract autojump colored-man colorize ruby gem bundler zsh-syntax-highlighting)
fi

source $ZSH/oh-my-zsh.sh