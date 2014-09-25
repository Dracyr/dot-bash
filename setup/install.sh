_install() {
  echo "Installing dot-bash Linux dependencies"  
  __install-oh-my-zsh
  __dot-bash-install-solarized-terminal-colors
  __dot-bash-install-translate-cli
  __install-terminal-fonts
  #__install-rvm
}

__install-oh-my-zsh() {
  echo "Installing Oh My Zsh"
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  echo "Oh My Zsh Installed"
}

__install-rvm() {
  \curl -sSL https://get.rvm.io | bash -s stable --
}

# Terminal colors
__dot-bash-install-solarized-terminal-colors() {
  echo "Installing terminal colors"
  mkdir ~/.pvsh/terminal-themes
  current_folder=$(pwd)
  cd ~/.pvsh/terminal-themes && git clone --depth=1 https://github.com/sigurdga/gnome-terminal-colors-solarized.git
  echo "Terminal colors installed"
  cd $current_folder
}

__dot-bash-install-translate-cli() {
  [[ ! -d ~/.pvsh/bin ]] && mkdir -p ~/.pvsh/bin/
  cd ~/.pvsh/bin/ && \
  echo "Downloading google-translate-cli" && \
  git clone git://github.com/soimort/google-translate-cli.git && \
  cd  ~/.pvsh/bin/google-translate-cli/ && \
  echo "Installing google-translate-cli" && \
  make install
}

__install-terminal-fonts() {
  wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
  wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
  mkdir -p ~/.fonts/
  mv PowerlineSymbols.otf ~/.fonts/
  fc-cache -vf ~/.fonts/
  mkdir -p ~/.config/fontconfig/conf.d/
  mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
}

echo "Installing"
$current_folder=$(pwd)
mkdir ~/.pvsh/dot-bash-temp
cd ~/.pvsh/dot-bash-temp && _install
cd $current_folder

