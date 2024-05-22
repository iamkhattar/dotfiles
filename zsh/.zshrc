# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/pmg102/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Load all global dotfiles
for DOTFILE in $(ls ~/.config/zsh/*.zsh | sort); do
	[ -r "~/.config/zsh/$DOTFILE" ] && [ -f "~/.config/zsh/$DOTFILE" ] && source "~/.config/zsh/$DOTFILE";
done;
unset DOTFILE;
