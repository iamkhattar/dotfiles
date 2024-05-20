#!/bin/bash

CURRENT_OS=$(uname)

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'

CLEAR='\033[0m'

function clone_dotfiles() {
  echo -e "${GREEN}INFO:${CLEAR} Cloning dotfiles to $HOME/.dotfiles"
  git clone https://github.com/pmgledhill102/dotfiles.git $HOME/.dotfiles
}

function install_brew() {
  if test ! $(which brew); then
    echo -e "${GREEN}INFO:${CLEAR} Brew not found, installing using install script"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ "${CURRENT_OS}" == "Darwin" ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
  fi
}

function install_dependencies_using_brew() {
  echo -e "${GREEN}INFO:${CLEAR} Installing dependencies from $HOME/.dotfiles/brew/Brewfile"
  brew analytics off
  brew update
  brew tap homebrew/bundle
  brew bundle install --file=$HOME/.dotfiles/brew/Brewfile
  brew cleanup
}

function install_oh_my_zsh() {
  if test ! $(which omz); then
    echo -e "${GREEN}INFO:${CLEAR} Oh My Zsh not found, installing using install script"
    /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi
}

function install_power10k() {
  echo -e "${GREEN}INFO:${CLEAR} Installing powerlevel10k to ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}

function install_zsh_plugins() {
  echo -e "${GREEN}INFO:${CLEAR} Installing ZSH plugins to ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

function install_nvchad() {
  echo -e "${GREEN}INFO:${CLEAR} Installing NvChad to ~/.config/nvim"
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
}

function create_directories() {
  echo -e "${GREEN}INFO:${CLEAR} Creating git directories in $HOME/projects"
  mkdir -p $HOME/dev
  mkdir -p $HOME/dev/personal
  mkdir -p $HOME/dev/work
  mkdir -p $HOME/dev/scratch
}

function stow_dotfiles() {
  echo -e "${GREEN}INFO:${CLEAR} Stowing dotfiles"
  rm -rf ~/.zshrc
  rm -rf ~/.zprofile
  cd $HOME/.dotfiles && stow */
}

function setup_jenv() {
  jenv enable-plugin export
}

function update_apt() {
  sudo apt-get update
  sudo apt-get upgrade -y
}

function install_dependencies_using_apt() {
  for i in $(cat $HOME/.dotfiles/apt/pkglist); do echo -e "$GREEN - Installing $i $CLEAR" && sudo apt-get install $i; done
}

function display_banner() {
  echo -e "${CLEAR}";
  echo -e "$RED ____        _    __ _ _           ";
  echo -e "$RED|  _ \  ___ | |_ / _(_) | ___  ___ ";
  echo -e "$RED| | | |/ _ \| __| |_| | |/ _ \/ __|";
  echo -e "$RED| |_| | (_) | |_|  _| | |  __/\__ \\";
  echo -e "$RED|____/ \\___/ \__|_| |_|_|\\___||___/";
  echo -e "$RED ";
  echo -e "$BLUE     ----- $1 -----";
  echo -e "${CLEAR}";
}

function sudo_check() {
  if [[ $EUID -ne 0 ]]; then
    echo -e "$RED (this script must be run as root on Ubuntu) $CLEAR"
    sudo "$0" "$@"
    exit 1
  fi
}

function main_macos() {
  display_banner "MacOS Edition"
  clone_dotfiles

  ### DISABLED UNTIL I TEST ON MAC

  #install_brew
  #install_dependencies_using_brew
  #install_oh_my_zsh
  #install_power10k
  #install_zsh_plugins
  #install_nvchad
  #setup_jenv
  #create_directories
  #stow_dotfiles
}

function main_ubuntu() {
  sudo_check
  display_banner "Ubuntu Edition"
  clone_dotfiles
  update_apt
  install_dependencies_using_apt
  install_oh_my_zsh
  install_power10k
  install_zsh_plugins
  install_nvchad
  setup_jenv
  create_directories
  stow_dotfiles
}

if [ "${CURRENT_OS}" == "Darwin" ]; then
  main_macos "$@"
else
  main_ubuntu "$@"
fi
