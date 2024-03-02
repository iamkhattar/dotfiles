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

# Load all global dotfiles
for DOTFILE in ~/.config/zsh/*.zsh; do
	[ -r "$DOTFILE" ] && [ -f "$DOTFILE" ] && source "$DOTFILE";
done;
unset DOTFILE;

# Load local configuration
[ -f ~/.config/local/.zshrc ] && source ~/.config/local/.zshrc

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
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"