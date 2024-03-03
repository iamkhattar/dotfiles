#!/usr/bin/env zsh

GREEN='\033[0;32m'
RED='\033[0;31m'
CLEAR='\033[0m'

script_exit_code=0
passed=0
failed=0

if [[ "$(uname)" == "Darwin" ]]; then
  HOMEBREW_PATH_DIR="/opt/homebrew/bin"
else
  HOMEBREW_PATH_DIR="/home/linuxbrew/.linuxbrew/bin"
fi

@verify_binary() {
  if [ -x "$(which "$1")" ]; then
      passed=$(( passed + 1 ))
      echo -e "${GREEN}PASS:${CLEAR} $1 exists and is on PATH"
  else
      failed=$(( failed + 1 ))
      echo -e "${RED}FAIL:${CLEAR} $1 does not exist or is not on PATH"
      script_exit_code=1
  fi
}

@verify_directory() {
  if [ -d "$1" ]; then
    passed=$(( passed + 1 ))
    echo -e "${GREEN}PASS:${CLEAR} $1 is a valid directory"
  else
    failed=$(( failed + 1 ))
    echo -e "${RED}FAIL:${CLEAR} $1 is not a valid directory"
    script_exit_code=1
  fi
}

@verify_file() {
  if [ -f "$1" ]; then
    passed=$(( passed + 1 ))
    echo -e "${GREEN}PASS:${CLEAR} $1 is a valid file"
  else
    failed=$(( failed + 1 ))
    echo -e "${RED}FAIL:${CLEAR} $1 is not a valid file"
    script_exit_code=1
  fi
}

@verify_environment_variable() {
  if [[ -v $1 ]]; then
    passed=$(( passed + 1 ))
    echo -e "${GREEN}PASS:${CLEAR} $1 is a valid environment variable"
  else
    failed=$(( failed + 1 ))
    echo -e "${RED}FAIL:${CLEAR} $1 is not an valid environment variable"
    script_exit_code=1
  fi
}

@verify_on_path() {
  if [[ ":$PATH:" == *":$1:"* ]]; then
    passed=$(( passed + 1 ))
    echo -e "${GREEN}PASS:${CLEAR} $1 is configured on path"
  else
    failed=$(( failed + 1 ))
    echo -e "${RED}FAIL:${CLEAR} $1 is not configured on path"
    script_exit_code=1
  fi
}

@verify_symlink() {
  if [ "$(readlink $1)" -ef "$2" ]; then
    passed=$(( passed + 1 ))
    echo -e "${GREEN}PASS:${CLEAR} $1 is a valid symlink"
  else
    failed=$(( failed + 1 ))
    echo -e "${RED}FAIL:${CLEAR} $1 is an invalid symlink"
    script_exit_code=1
  fi
}

@show_results() {
  local total=$((passed + failed))
  echo "Executed: ${total}, Passed: ${passed}, Failed: ${failed}"
  exit $script_exit_code
}

@verify_binary aws
@verify_binary python3
@verify_binary bat
@verify_binary az
@verify_binary fzf
@verify_binary git
@verify_binary go
@verify_binary task
@verify_binary gradle
@verify_binary gum
@verify_binary java
@verify_binary helm
@verify_binary jenv
@verify_binary jq
@verify_binary kubectl
@verify_binary mvn
@verify_binary openssl
@verify_binary sam
@verify_binary terraform
@verify_binary cert-details

@verify_directory $DOTFILES_DIR
@verify_directory ~/.config/zsh
@verify_directory ~/.config/zsh/bin

@verify_file ~/.zshrc
@verify_file ~/.zprofile
@verify_file ~/.hushlogin
@verify_file ~/.p10k.zsh
@verify_file ~/.config/zsh/aliases.zsh
@verify_file ~/.config/zsh/exports.zsh
@verify_file ~/.config/zsh/functions.zsh
@verify_file ~/.config/zsh/path.zsh

@verify_environment_variable LANG
@verify_environment_variable LC_ALL
@verify_environment_variable HOMEBREW_NO_ANALYTICS
@verify_environment_variable SAM_CLI_TELEMETRY
@verify_environment_variable DOTNET_CLI_TELEMETRY_OPTOUT
@verify_environment_variable PYTHONIOENCODIN
@verify_environment_variable HISTCONTROL
@verify_environment_variable FZF_DEFAULT_OPTS
@verify_environment_variable NVM_DIR
@verify_environment_variable HOME
@verify_environment_variable DOTFILES_DIR
@verify_environment_variable FZF_DEFAULT_COMMAND

@verify_on_path $HOMEBREW_PATH_DIR
@verify_on_path $HOME/.jenv/shims

@verify_symlink $HOME/.zshrc $DOTFILES_DIR/zshrc/.zshrc

@show_results