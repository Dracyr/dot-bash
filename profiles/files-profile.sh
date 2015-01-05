#!/bin/bash

alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll="ls -l --color=auto"
alias mv='mv -i' # prompt if duplicate filename
alias grep='grep --color=auto'

alias hs='history | grep --color=auto'
alias o='open'
alias c='clear'
# Colored and paginated directory tree
alias treep='tree -C "$@" | less -R'
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

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
  if [ -f $1 ] ; then
    # NAME=${1%.*}
    # mkdir $NAME && cd $NAME
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.tar.xz)    tar xvJf $1    ;;
      *.lzma)      unlzma $1      ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x -ad $1 ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *.xz)        unxz $1        ;;
      *.exe)       cabextract $1  ;;
      *)           echo "extract: '$1' - unknown archive method" ;;
    esac
  else
      echo "$1 - file does not exist"
  fi
fi
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function archive() {
  local tmpFile="${@%/}.tar"
  tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1

  size=$(
    stat -f"%z" "${tmpFile}" 2> /dev/null; # OS X `stat`
    stat -c"%s" "${tmpFile}" 2> /dev/null # GNU `stat`
  )

  local cmd=""
  if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
    # the .tar file is smaller than 50 MB and Zopfli is available; use it
    cmd="zopfli"
  else
    if hash pigz 2> /dev/null; then
      cmd="pigz"
    else
      cmd="gzip"
    fi
  fi

  echo "Compressing .tar using \`${cmd}\`…"
  "${cmd}" -v "${tmpFile}" || return 1
  [ -f "${tmpFile}" ] && rm "${tmpFile}"
  echo "${tmpFile}.gz created successfully."
}

## __NAVIGATION__ ##

# Go back N-dots-directories
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'


# Quick navigation between folders
# Usage:
#             $ mark any_name           # marks the current directory and adds a reference to it called any_name
#             $ jump any_name           # jumps to the marked directory named any_name
#             $ unmark any_name       # removes the reference
#             $ marks                           # lists all curent marks
# Source:
#         http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
export MARKPATH=$HOME/.marks
jump() {
  cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
mark() {
  mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
unmark() {
  rm -i "$MARKPATH/$1"
}
marks() {
  ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
alias j="jump"
