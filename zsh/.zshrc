# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh Directory.
export ZSH="$HOME/.oh-my-zsh"

# Zsh Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git fzf fzf-tab zsh-autosuggestions zsh-syntax-highlighting)

# Oh My Zsh Installation.
source $ZSH/oh-my-zsh.sh

# User configuration
function prepend-path() {
  [ -d "$1" ] && export PATH="$1:$PATH"
}

function append-path() {
  [ -d "$1" ] && export PATH="$PATH:$1"
}

# Load all global dotfiles
for DOTFILE in ~/.config/zsh/*.zsh; do
	[ -r "$DOTFILE" ] && [ -f "$DOTFILE" ] && source "$DOTFILE";
done;
unset DOTFILE;

# Load local configuration
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Load shell completions
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit && compinit

# Load powerlevel10k settings
[ -f ~/.p10k.zsh ] && source ~/.p10k.zsh

# Load fzf settings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load jenv
eval "$(jenv init -)"

# Load nvm
if [[ "$(uname)" == "Darwin" ]]; then
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
else
  [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi
