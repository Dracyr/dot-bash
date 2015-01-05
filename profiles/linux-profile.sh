#!/bin/bash

# __LINUX__ ##
alias install='sudo apt-get install'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'
alias remove="sudo apt-get remove"
alias search="apt-cache search"

export EDITOR=subl

# Larger bash history (allow 32^3 entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoredups
# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help:cd..:cd ..:gs:gp:gac:subl"

# Highlight section titles in manual pages
export LESS_TERMCAP_md="$ORANGE"

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Highlight section titles in manual pages
export LESS_TERMCAP_md="${ORANGE}"
# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto"
export GREP_COLOR='1;31' # green for matches

# Translate text with google-translate-cli
translate() {
  if [[ ! -d ~/.pvsh/bin/google-translate-cli ]];then
    echo "google-translate-cli not found.."
    echo "Init install script"
    sleep 1
    install-translate-cli
  fi
  if [[ "$1" == "--help" ]] || [[ "$1" == "-help" ]];then
    echo -e "usage:
      $ translate {=en+ro+de+it} \"hola mundo\"
      hello world
      Bună ziua lume
      Hallo Welt
      ciao mondo

      $ translate \"Saluton, mondo\"
      Hello, world"
    return
  fi

  tr "$@"
}
alias translate_to_swedish='translate {=sv}'
alias translate_from_swedish='translate {sv=en}'

google_say() { local IFS=+;/usr/bin/mplayer -ao alsa -really-quiet -noconsolecontrols "http://translate.google.com/translate_tts?tl=en&q=$*"; }

## __MISC__ ##

# Mac OSX like 'open' command
# Opens the given input with the default program associated for that type
open() {
  xdg-open $1
}

# Add the below lines to sudoers file (at the bottom):
#       $ sudo visudo           # only way to edit sudoers file
#      <username> ALL=(ALL) ALL
#      <username> ALL = NOPASSWD: /usr/sbin/pm-suspend
# Suspend computer after N-min (Linux specific)
sleepin() {
  if [[ -z "$1" ]]; then
    pmset sleepnow
  else
    echo "Sleeping in $(bc <<< $1*60) minutes"
    sleep $(bc <<< $1*60) && sudo pm-suspend
  fi
}