#!/bin/bash

source ~/.pvsh/dot-bash/setup/config.sh
source ~/.pvsh/dot-bash/profiles/unix-profile.sh
source ~/.pvsh/dot-bash/profiles/aliases-profile.sh
source ~/.pvsh/dot-bash/profiles/files-profile.sh
source ~/.pvsh/dot-bash/profiles/git-profile.sh
source ~/.pvsh/dot-bash/profiles/networking-profile.sh
source ~/.pvsh/dot-bash/profiles/raspberry-profile.sh
source ~/.pvsh/dot-bash/profiles/terminal-profile.sh
source ~/.pvsh/dot-bash/profiles/ssh-profile.sh
source ~/.pvsh/dot-bash/utils/cli.sh

# Add all files in bin/ to PATH
PATH=$PATH:$HOME/.pvsh/dot-bash/bin/
export PATH

# Git auto complete
if [[ ! -f ~/.git-completion.bash ]]; then
  echo "Git auto complete list not found.. Downloading..."
  cd ~ \
  && touch ~/.git-completion.bash \
  && curl -L https://raw.github.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash \
  && echo "Done" || echo "Something went wrong downloading git-completion."
fi
source ~/.git-completion.bash

if [[ ! -d ~/.git-story/ ]]; then
  curl https://raw2.github.com/pvsh/git-story/master/setup/install | bash
fi

if [[ ! -d ~/.pvsh/util_scripts/ ]]; then
  cd ~/.pvsh && git clone https://github.com/pvsh/util_scripts.git
fi

if [[ "$(uname)" == "Darwin" ]]; then
  source ~/.pvsh/dot-bash/profiles/osx-profile.sh
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
  source ~/.pvsh/dot-bash/profiles/linux-profile.sh
fi
