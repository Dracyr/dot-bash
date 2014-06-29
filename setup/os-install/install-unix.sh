#!/bin/bash

echo "Installing for unix"
$current_folder=$(pwd)
mkdir ~/.pvsh/dot-bash-temp
cd ~/.pvsh/dot-bash-temp && __unix_install
cd $current_folder

__unix_install() {
  __install-rvm
}

__install-rvm() {
  \curl -sSL https://get.rvm.io | bash -s stable
}