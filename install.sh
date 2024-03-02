#!/bin/bash

# Clone dotfiles
git clone https://github.com/iamkhattar/dotfiles.git $HOME/.dotfiles

# Symlink dotfiles

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Disable Homebrew analytics
brew analytics off

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file $HOME/.dotfiles/Brewfile

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install nvchad
rm -rf ~/.config/nvim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# Create Projects directory
mkdir -p $HOME/projects
mkdir -p $HOME/projects/personal
mkdir -p $HOME/projects/work

# Clone key repositories

# Verify installation
chmod +x $HOME/.dotfiles/verify.sh
$HOME/.dotfiles/verify.sh