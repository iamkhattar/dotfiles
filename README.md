# iamkhattar's dotfiles

## Overview

Welcome to my dotfiles repository! This repository contains personal configuration files (often referred to as dotfiles
because they typically start with a dot, like `.zshrc` or `.vimrc`) that I use to personalize and customize my development
environment. These dotfiles are managed using GNU Stow which is downloaded as part of the `install.sh` script.

## Prerequisites

This repository uses `zsh` plugins and themes requiring you to set zsh as your login shell:

```bash
chsh -s $(which zsh)
```

## Generating SSH Keys

You can [Generate a new public and private SSH key](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) by running:

```bash
curl https://raw.githubusercontent.com/iamkhattar/dotfiles/HEAD/ssh.sh | sh -s "<your-email-address>"
```

## Installation using Script

You can bootstrap a new machine by using the `install.sh` script. This script downloads the dotfiles, stows them in correct
locations, installs brew along with required dependencies, Oh My Zsh and Powerlevel10k.

```bash
bash -c "`curl -fsSL https://raw.githubusercontent.com/iamkhattar/dotfiles/main/install.sh`"
```

## Manual Installation

1. Clone this repository to the `~/.dotfiles` directory.

      ```bash
      git clone https://github.com/iamkhattar/dotfiles.git ~/.dotfiles
      ```

2. Install Brew using the Brew install script:

      ```bash
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      ```
   
3. Configure Brew for the current shell session:

      On Mac:
   
      ```bash
      eval "$(/opt/homebrew/bin/brew shellenv)"
      ```
   
      On Linux:
   
      ```bash
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      ```

4. Install dependencies using the `Brewfile`:

      ```bash
      brew analytics off
      brew update
      brew tap homebrew/bundle
      brew bundle install --file=$HOME/.dotfiles/brew/Brewfile
      brew cleanup
      ```

5. Install `Oh My Zsh`:

      ```bash
      /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
      ```
   
6. Install `Powerlevel10K`:

      ```bash
      git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
      ```
   
7. Install Zsh Plugins:

      ```bash
      git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
      git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
      git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
      ```

8. Install `Nvchad`:

      ```bash
      git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
      ```
   
9. Configure `jenv`:

      ```bash
      jenv enable-plugin export
      ```

10. Create project directories:

      ```bash
      mkdir -p $HOME/projects
      mkdir -p $HOME/projects/personal
      mkdir -p $HOME/projects/work
      mkdir -p $HOME/projects/scratch
      ```
   
11. Stow Dotfiles:

      ```bash
      rm -rf ~/.zshrc
      rm -rf ~/.zprofile
      cd $HOME/.dotfiles && stow */
      ```
   
## Local Dotfiles

1. Clone the local dotfiles into the local directory:

    ```bash
    git clone <git_repostitory> ~/.dotfiles/local
    ```

2. Stow the dotfiles:

    ```bash
    cd $HOME/.dotfiles && stow local
    ```

## Verification

```bash
zsh -c "`source $HOME/.zshrc && curl -fsSL https://raw.githubusercontent.com/iamkhattar/dotfiles/main/verify.zsh`"
```

### Contribution

Contributions are welcome! If you have any improvements or suggestions, feel free to open an issue or create a pull request.

### Feedback

If you find these dotfiles helpful or have any feedback, feel free to reach out!

Enjoy customizing your development environment with these dotfiles! 🚀
