#!/bin/bash

## __GIT__ ##
git config --global help.autocorrect 20 # Auto correct misspellings, after a 2 sec delay
git config --global color.ui auto       # Use colors by default
git config --global merge.stat true     # Always show merge stats

# Finds
alias gfindreg='git rev-list --all | xargs git grep'  # Find in history regex
alias gfind='git rev-list --all | xargs git grep -F'  # Find in history string search

alias gs='git status'
alias grhh='git reset --hard HEAD'
alias gcd='git checkout'
gac() { 
  git add --all :/
  git commit -m "$1" 
}

gcaa() {
  git add --all :/
  git commit --amend
}

alias github="open \`github_url\`"
alias github_url="git remote -v | grep git@github.com | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/:/\//' -e 's/git@/http:\/\//'"