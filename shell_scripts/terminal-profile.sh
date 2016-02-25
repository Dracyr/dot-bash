#!/bin/zsh

# Larger bash history (allow 32^3 entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoredups
# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help:cd..:cd ..:gs:gp:gac:subl"

# Mac OSX like 'open' command
# Opens the given input with the default program associated for that type
open() {
  xdg-open $1
}

# Enable aliases to be sudo’ed
alias sudo='sudo '
alias please='sudo $(fc -ln -1)'

common_commands() {
  history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
}

## __FILES__ ##

alias ls='ls -1Fcrt --color=auto'
alias la='ls -lAFh --color=auto'
alias lr='ls -tRFh'
alias ll="ls -l --color=auto"
alias mv='mv -i' # prompt if duplicate filename
alias grep='grep --color=auto'

alias h='history'
alias hs='history | grep --color=auto'
alias o='open'
alias clr='clear'
# Search running processes
alias tm='ps -ef | grep --color=auto'

alias rsync='rsync --progress'

find_large_files() {
  if [[ -z $1 ]]; then
    folder="."
  else
    folder="$1"
  fi
  find $folder -type f -size +10000k -exec ls -lh {} \; | awk '{ print $9 ": " $5 }'
}

# Counts the number of files in folder
count_files() {
  echo Files: $(ls $1 | wc -l), Size: $(du -sh $1)
}
alias lc='count_files' # short hand for the above function

# Go back N-dots-directories
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

## __GIT__ ##

git config --global help.autocorrect 20 # Auto correct misspellings, after a 2 sec delay
git config --global color.ui auto       # Use colors by default
git config --global merge.stat true     # Always show merge stats

alias gl='git pull'
alias gp='git push'
alias gs='git status'
alias grhh='git reset --hard HEAD'
alias gcd='git checkout'
gac() {
  git add --all :/
  git commit -m "$@"
}

gcaa() {
  git add --all :/
  git commit --amend
}

alias github="open \`github_url\`"
alias github_url="git remote -v | grep git@github.com | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/:/\//' -e 's/git@/http:\/\//'"

## __Ruby / RAILS__ ##

# Rails aliases
alias rc='rails console'
alias rs='rails server'
alias rg='rails generate'
# Rake aliases
alias rdm='rake db:migrate'
alias rdr='rake db:rollback'

alias bi='bundle install'

## __NETWORKING__ ##

# Get local IP
alias localip="hostname --ip-addresses"
# Get external IP
alias externalip='curl ip.appspot.com'

# URL-encode strings
urlencode() {
  if [[ -z "$1" ]] || [[ $1 == "-help" ]] || [[ $1 == "--help" ]]; then
    echo "Usage:"
    echo -e "\t urlencode <any_string>"
    echo "URL-encodes specified string"
  else
    python -c "import sys, urllib as ul; print ul.quote_plus('$1');"
  fi
}

# Shorten given URL
shortenurl() {
  curl -s http://is.gd/api.php?longurl=`perl -MURI::Escape -e "print uri_escape('$1');"`
  echo
}

# Display URL true destination
expandurl() {
  curl -sIL $1 | grep ^Location
}

## __MISC__ ##

alias stopwatch='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'
alias week='date +"%V"'
alias starwars='telnet towel.blinkenlights.nl'
alias print_ascii='man ascii'


alias subl='subl3'
