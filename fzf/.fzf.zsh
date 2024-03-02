if [ "$(uname)" == "Darwin" ]; then
  if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
    PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
  fi
  source "/opt/homebrew/opt/fzf/shell/completion.zsh"
  source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
else
  if [[ ! "$PATH" == */home/linuxbrew/.linuxbrew/bin/fzf* ]]; then
    PATH="${PATH:+${PATH}:}/home/linuxbrew/.linuxbrew/bin/fzf"
  fi
  SHELL_SCRIPT_LOCATION="$(brew --cellar fzf)/$(brew list --versions fzf | tr ' ' '\n' | tail -1)/shell"
  source "$SHELL_SCRIPT_LOCATION/completion.zsh"
  source "$SHELL_SCRIPT_LOCATION/key-bindings.zsh"
fi