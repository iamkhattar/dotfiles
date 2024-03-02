#!/bin/bash

CURRENT_OS=$(uname)

GREEN='\033[0;32m'
CLEAR='\033[0m'

function clone_dotfiles() {
  echo -e "${GREEN}INFO:${CLEAR} Cloning dotfiles to $HOME/.dotfiles"
  git clone https://github.com/iamkhattar/dotfiles.git $HOME/.dotfiles
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

function install_dependencies() {
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
  mkdir -p $HOME/projects
  mkdir -p $HOME/projects/personal
  mkdir -p $HOME/projects/work
  mkdir -p $HOME/projects/scratch
}

function verify_installation() {
  echo -e "${GREEN}INFO:${CLEAR} Verifying installation"
  chmod +x $HOME/.dotfiles/verify.sh
  $HOME/.dotfiles/verify.sh
}

function symlink() {
  echo -e "${GREEN}INFO:${CLEAR} Symlinking dotfiles"
  rm -rf ~/.zshrc
  rm -rf ~/.zprofile
  cd $HOME/.dotfiles && stow */
}

function main() {
  clone_dotfiles
  install_brew
  install_dependencies
  install_oh_my_zsh
  install_power10k
  install_zsh_plugins
  install_nvchad
  create_directories
  symlink
  verify_installation
}

main "$@"