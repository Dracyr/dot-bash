#!/bin/bash

## __GIT__ ##
git config --global help.autocorrect 20 # Auto correct misspellings, after a 2 sec delay
git config --global color.ui auto       # Use colors by default
git config --global merge.stat true     # Always show merge stats

# Finds
alias gfindreg='git rev-list --all | xargs git grep'  # Find in history regex
alias gfind='git rev-list --all | xargs git grep -F'  # Find in history string search

#alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset'
alias gs='git status'
alias grhh='git reset --hard HEAD'
alias gcd='git checkout'
gac() { 
  git add --all
  git commit -m "$1" 
}

gpush() {
  if [ -z "$1" ]; then
      echo "usage:"
      echo "'\t gpush <branch> <commit_message>"
      return
  elif [ -z "$2" ]; then
    git push origin $1
  else
    git add --all
    git commit -m "$2"
    git push origin $1
  fi
}

# TODO: cd to the cloned directory
qclone()  {
  clone_url=$1
  git clone --depth=1 $clone_url
}

alias github_open="open \`git remote -v | grep git@github.com | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/:/\//' -e 's/git@/http:\/\//'\`"

# open all changed files (that still actually exist) in the editor
function ged() {
  local files=()
  for f in $(git diff --name-only "$@"); do
    [[ -e "$f" ]] && files=("${files[@]}" "$f")
  done
  local n=${#files[@]}
  echo "Opening $n $([[ "$@" ]] || echo "modified ")file$([[ $n != 1 ]] && \
    echo s)${@:+ modified in }$@"
  subl "${files[@]}"
}

# GitHub URL for current repo.
function gurl() {
  local remotename="${@:-origin}"
  local remote="$(git remote -v | awk '/^'"$remotename"'.*\(push\)$/ {print $2}')"
  if ![[ '$remote' ]]; then
    return
  fi
  local user_repo="$(echo "$remote" | perl -pe 's/.*://;s/\.git$//')"
  echo "https://github.com/$user_repo"
}


# open last commit in GitHub, in the browser.
function gfu() {
  local n="${@:-1}"
  n=$((n-1))
  open $(git log -n 1 --skip=$n --pretty=oneline | awk "{printf \"$(gurl)/commit/%s\", substr(\$1,1,7)}")
}
