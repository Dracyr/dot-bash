#!/bin/bash

symlink() {
  file=$1
  if [[ -f ~/$file ]]; then
    echo "$file already existing skipping symlink for $file"
  else
    ln -s ~/.pvsh/dot-bash/$file $HOME/$file && echo "Symlinked $file" || echo "Failed to symlink $file"
  fi
}

inject-to-profile() {
  if [[ -f ~/.zshrc ]]; then
    echo "Injecting import: zshrc"
    cat ~/.pvsh/dot-bash/setup/import/import_to_bash_profile >> ~/.zshrc
    source ~/.zshrc
  else
    echo "[ERROR] No .zshrc found, creating it."
    touch ~/.zshrc
    cat ~/.pvsh/dot-bash/setup/import/import_to_bash_profile >> ~/.zshrc
    source ~/.zshrc
    echo -e "To install to another profile, add the below line to your bash profile."
    echo -e "\t cat ~/.pvsh/dot-bash/setup/import/import_to_bash_profile >> ~/.your_profile"
  fi
  symlink '.inputrc'
  symlink '.irbrc'
  symlink '.gemrc'
  symlink '.gitconfig'
  symlink '.gitignore_global'
}

check_for_app() {
  if command -v $1 2>/dev/null; then
      echo "$1 is installed, continuing"
  else
      echo "$1 is not installed :("
      sudo apt-get install --yes $1 > /dev/null
      echo "But now it is!"
  fi
}

echo "Setup script started, creating folders"
mkdir ~/.pvsh
CURRENT_FOLDER=$(pwd) && \
cd ~/.pvsh && \
check_for_app "git"
echo "Cloning repository"
git clone https://github.com/Dracyr/dot-bash.git && \

check_for_app "zsh"

inject-to-profile
./setup/install_shell.sh
exec zsh
