#!/bin/bash

pvsh() {
  if  [[ -z "$1" ]]; then
    __pvsh-help
  else
    __pvsh_functions "$@"
  fi
}

__pvsh_functions() {
  if   [[ "$1" == "self-destruct" ]]; then
    __b_self_destruct
  elif [[ "$1" == "install" ]]; then
    if [[ "$2" == "postgresql" ]]; then
      __i_install_postgresql
    elif [[ "$2" == "mongodb" ]]; then
      __i_install_mongodb
    elif [[ "$2" == "redis" ]]; then
      __i_install_redis
    else
      __pvsh-help
    fi
  elif [[ "$1" == "update" ]]; then
    __b_update "$2"
  elif [[ "$1" == "setup" ]]; then
    __b_setup "$2"
  elif [[ "$1" == "list" ]];then
    if [[ "$2" == "alias" ]] || [[ "$2" == "aliases" ]]; then
      __b_list_aliases
    elif [[ "$2" == "function" ]] || [[ "$2" == "functions" ]]; then
      __b_list_functions
    else
      __b_list_aliases
      __b_list_functions
    fi
  else
    echo "Unknown command '$1'"
    __pvsh-help
  fi
}


###############
#        FUNCTIONS        #
###############
__pvsh-stat-help() {
  echo "available:"
  echo -e "'\t commands 2             prints 2 most popular commands (default: 12)"
}

__b_stat() {
  if [[ "$1" == "commands" ]]; then
    __b_popular_commands $2
  else
    echo "Unknown command '$1'"
    __pvsh-stat-help
  fi
}

__b_popular_commands() {
  cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -${1-12}
}

__b_list_functions() {
  grep -rh '()' ~/.pvsh/dot-bash
}

__b_list_aliases() {
  grep -rh 'alias ' ~/.pvsh/dot-bash
}

__b_self_destruct() {
  if [[ "$1" == "--help" || "$1" == "-help " ]]; then
    echo "usage:"
    echo -e "\t pvsh self-destruct"
    echo "removes the script entirely (rm -rf ~/.pvsh)"
  else
    while true; do
      read -p "Are you sure? (y\n)" yn
      case $yn in
        [Yy]* ) __b_self_destruct_execute "$1"; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
      esac
    done
  fi
}

__b_self_destruct_execute() {
  rm -rf ~/.pvsh
}

__b_update() {
  if   [[ "$1" == "--help" || "$1" == "-help" ]]; then
    echo "usage:"
    echo -e "\t pvsh update"
    echo "Will update dot-bash"
  else
    echo "Updating dot-bash"
    cd ~/.pvsh/dot-bash && git pull origin master
    cd $CURRENT_FOLDER
  fi
}

__b_setup() {
  sh ~/.pvsh/setup/install.sh
}

########################
#     Installations    #
########################

__i_install_postgresql() {
  sudo pacman -S postgresql
  sudo -u postgres initdb --locale $en_US.UTF-8 -E UTF8 -D '/var/lib/postgres/data'
  sudo systemctl start postgresql.service
  sudo systemctl enable postgresql.service
  createdb $(whoami)
}

###############
#             HELP            #
###############

__pvsh-help() {
  echo "usage: "
  echo -e "\t pvsh update <pkg>"
  echo -e "\t pvsh self-destruct"
  echo -e "\t pvsh list"
  echo -e "\t pvsh list alias"
  echo -e "\t pvsh list functions"
  echo -e "\t pvsh install"
  echo -e "\t\t postgresqlql"
  echo -e "\t\t redis"
  echo -e "\t\t mongodb"
  echo "help:"
  echo -e "\t pvsh <command> -help"
}
