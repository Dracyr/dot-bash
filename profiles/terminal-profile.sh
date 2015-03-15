#!/bin/bash

alias list_functions='compgen -A function'
alias list_aliases='compgen -a'

# Stopwatch
alias stopwatch='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

alias week='date +"%V"'
alias starwars='traceroute 216.81.59.173'
alias print_ascii='man ascii'


# Enable aliases to be sudo’ed
alias sudo='sudo '

# Do sudo a command, or do sudo to the last typed command if no argument given
#please() {
#  if [[ $# == 0 ]]; then
#    sudo !!
#  else
#    sudo "$@"
#  fi
#}

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

terminal-dark() {
  if [[ ! -d ~/.pvsh/terminal-themes/gnome-terminal-colors-solarized ]]; then
    echo "Terminal themes not installed"
    __dot-bash-install-solarized-terminal-colors
  fi
  sh ~/.pvsh/terminal-themes/gnome-terminal-colors-solarized/set_dark.sh
}
terminal-light() {
  if [[ ! -d ~/.pvsh/terminal-themes/gnome-terminal-colors-solarized ]]; then
    echo "Terminal themes not installed"
    __dot-bash-install-solarized-terminal-colors
  fi
  sh ~/.pvsh/terminal-themes/gnome-terminal-colors-solarized/set_light.sh
}

is_prime() {
  check=$(((($1**2)+17)%12))
  if [[ $check -eq 6 ]];then
     echo "Yes"
  else
     echo "No"
  fi
}

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
