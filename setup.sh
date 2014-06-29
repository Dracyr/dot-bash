#!/bin/bash

__dot-bash-symlink() {
  file=$1
  if [[ -f ~/$file ]]; then
    echo "$file already existing skipping symlink for $file"
  else
    ln -s ~/.pvsh/dot-bash/$file $HOME/$file && echo "Symlinked $file" || echo "Failed to symlink $file"
  fi
}

__dot-bash-inject-to-profile() {
  if [[ -f ~/.zshrc ]]; then
    echo "Injecting import: zshrc"
    cat ~/.pvsh/dot-bash/setup/import/import_to_bash_profile >> ~/.zshrc
    source ~/.zshrc
  else
    echo "[ERROR] No .zshrc found."
    echo "However the script has been loaded and will be available in the current shell session."
    echo ""
    echo -e "To install add the below line to your bash profile."
    echo -e "\t cat ~/.pvsh/dot-bash/setup/import/import_to_bash_profile >> ~/.your_profile"
  fi
  __dot-bash-symlink '.inputrc'
  __dot-bash-symlink '.curlrc'
  __dot-bash-symlink '.gemrc'
  __dot-bash-symlink '.gitconfig'
  __dot-bash-symlink '.gitconfig_global'
}

mkdir ~/.pvsh
CURRENT_FOLDER=$(pwd) && \
cd ~/.pvsh && \
git clone https://github.com/pvsh/dot-bash.git && \
__dot-bash-inject-to-profile && \
cd $CURRENT_FOLDER
