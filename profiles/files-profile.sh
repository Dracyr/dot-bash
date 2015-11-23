#!/bin/bash

alias ls='ls --color=auto'
alias la='ls -lah --color=auto'
alias ll="ls -l --color=auto"
alias mv='mv -i' # prompt if duplicate filename
alias grep='grep --color=auto'

alias hs='history | grep --color=auto'
alias o='open'
alias clr='clear'
# Search running processes
alias tm='ps -ef | grep --color=auto'

alias rsync='rsync --progress'

count_size() {
  du -sh $1
}

ls_file_permissions() {
  stat -c '%A %a %N' *
}
alias file_permissions="ls_file_permissions"

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
  ls $1 | wc -l
}
alias lc='count_files' # short hand for the above function

## __NAVIGATION__ ##

# Go back N-dots-directories
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'