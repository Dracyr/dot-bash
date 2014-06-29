#!/bin/bash

source ~/.pvsh/dot-bash/profiles/aliases-profile.sh
source ~/.pvsh/dot-bash/profiles/oh-my-zsh-profile.sh
source ~/.pvsh/dot-bash/profiles/files-profile.sh
source ~/.pvsh/dot-bash/profiles/git-profile.sh
source ~/.pvsh/dot-bash/profiles/networking-profile.sh
source ~/.pvsh/dot-bash/profiles/terminal-profile.sh
source ~/.pvsh/dot-bash/profiles/ssh-profile.sh
source ~/.pvsh/dot-bash/utils/cli.sh

# Add all files in bin/ to PATH
PATH=$PATH:$HOME/.pvsh/dot-bash/bin/
export PATH

source ~/.pvsh/dot-bash/profiles/linux-profile.sh
