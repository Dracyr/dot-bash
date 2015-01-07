_install() {
  echo "Installing dot-bash Linux dependencies"  
  install-oh-my-zsh
  install-solarized-terminal-colors
  install-translate-cli
  install-terminal-fonts
  install-rbenv
}

install-oh-my-zsh() {
  echo "Installing Oh My Zsh"
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
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

install-translate-cli() {
  [[ ! -d ~/.pvsh/bin ]] && mkdir -p ~/.pvsh/bin/
  cd ~/.pvsh/bin/ && \
  echo "Downloading google-translate-cli" && \
  git clone git://github.com/soimort/google-translate-cli.git && \
  cd  ~/.pvsh/bin/google-translate-cli/ && \
  echo "Installing google-translate-cli" && \
  make install
}

install-terminal-fonts() {
  echo "Installing terminal fonts"
  wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
  wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
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

current_folder=$(pwd)
mkdir ~/.pvsh/dot-bash-temp
cd ~/.pvsh/dot-bash-temp && _install
cd $current_folder
