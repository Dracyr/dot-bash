#!/bin/bash

## Oh My Zsh config ##
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"
DEFAULT_USER="per-victor"

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

plugins=(gitfast debian wd history extract autojump colored-man colorize ruby gem rvm bundler)

source $ZSH/oh-my-zsh.sh