_install() {
  echo "Installing dot-bash Linux dependencies"
  install-oh-my-zsh
  install-solarized-terminal-colors
  install-translate-cli
  install-terminal-fonts
  install-rbenv
  install-sublime
  install-random
}

install-oh-my-zsh() {
  echo "Installing Oh My Zsh"
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.pvsh/zsh-custom/plugins
  git clone git@github.com:tarruda/zsh-autosuggestions.git ~/.pvsh/zsh-custom/plugins
  echo "Oh My Zsh Installed"
}

# Terminal colors
install-solarized-terminal-colors() {
  echo "Installing terminal colors"
  mkdir ~/.pvsh/terminal-themes
  current_folder=$(pwd)
  cd ~/.pvsh/terminal-themes && git clone --depth=1 https://github.com/sigurdga/gnome-terminal-colors-solarized.git
  echo "Terminal colors installed"
}

install-terminal-fonts() {
  echo "Installing terminal fonts"
  wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
  wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
  mkdir -p ~/.fonts/
  mv PowerlineSymbols.otf ~/.fonts/
  fc-cache -vf ~/.fonts/
  mkdir -p ~/.config/fontconfig/conf.d/
  mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
}

install-rbenv() {
  echo "Installing rbenv"
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  echo "Installing dependencies to build ruby"
  sudo apt-get -y install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
}

symlink() {
  file=$1
  if [[ -f ~/$file ]]; then
    echo "$file already existing skipping symlink for $file"
  else
    ln -s ~/.pvsh/dot-bash/$file $HOME/$file && echo "Symlinked $file" || echo "Failed to symlink $file"
  fi
}

install-sublime-settings() {
  # sudo apt-get -y install sublime_text
  mkdir -p $HOME/.config/sublime-text-3/Packages/User/
  temp_folder=$(pwd)
  cd ~/.pvsh/dot-bash/sublime_text
  for file in *
  do
    install_path=$HOME"/.config/sublime-text-3/Packages/User"
    if [[ -f $install_path/$file ]]; then
      echo "$file already existing skipping symlink for $file"
    else
      ln -s $HOME/.pvsh/dot-bash/sublime_text/$file $install_path/$file && echo "Symlinked $file" || echo "Fail $file"
    fi
  done

  cd $temp_folder
}

install-random() {
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

  git clone --depth 1 https://github.com/supercrabtree/k.git ~/.k
  echo "\nsource ~/.k/k.sh\n" >> ~/.zshrc
}

current_folder=$(pwd)
mkdir ~/.pvsh/dot-bash-temp
cd ~/.pvsh/dot-bash-temp && _install
cd $current_folder
