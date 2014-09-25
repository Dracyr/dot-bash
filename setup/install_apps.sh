_install() {
  echo "Installing dot-bash Linux apps"  
  __install-rvm
}

__install-rvm() {
  \curl -sSL https://get.rvm.io | bash -s stable --
}

echo "Installing"
$current_folder=$(pwd)
mkdir ~/.pvsh/dot-bash-temp
cd ~/.pvsh/dot-bash-temp && _install
cd $current_folder

