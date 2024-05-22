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
for DOTFILE in ~/.config/zsh/*.zsh; do
	[ -r "$DOTFILE" ] && [ -f "$DOTFILE" ] && source "$DOTFILE";
done;
unset DOTFILE;
