#!/bin/bash

# Stopwatch
alias stopwatch='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

alias week='date +"%V"'
alias starwars='traceroute 216.81.59.173'
alias print_ascii='man ascii'

# Enable aliases to be sudo’ed
alias sudo='sudo '
alias please='sudo $(fc -ln -1)'

common_commands() {
  history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
}

redo_with() {
  if [[ -z "$1" ]] || [[ $1 == "-help" ]] || [[ $1 == "--help" ]]; then
    echo "Usage:"
    echo -e "\t $ redo_with <program>"
    echo -e "Run specified program with arguements from previous command."
    echo ""
    echo -e "example:"
    echo -e "\t $ ls <some_file>"
    echo -e "\t $ redo_with <program>"
    echo "will execute: <program> <some_file>"
  else
    $1 $(history -p '!*')
  fi
}
alias rw='redo_with'

# Simple calculator
calc() {
  local result=""
  result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')"
  #                       └─ default (when `--mathlib` is used) is 20
  #
  if [[ "$result" == *.* ]]; then
    # improve the output for decimal numbers
    printf "$result" |
    sed -e 's/^\./0./'        `# add "0" for cases like ".5"` \
        -e 's/^-\./-0./'      `# add "0" for cases like "-.5"`\
        -e 's/0*$//;s/\.$//'   # remove trailing zeros
  else
    printf "$result"
  fi
  printf "\n"
}
