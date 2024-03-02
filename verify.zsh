#!/bin/zsh

GREEN='\033[0;32m'
RED='\033[0;31m'
CLEAR='\033[0m'

script_exit_code=0
passed=0
failed=0

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

@verify_directory $HOME
@verify_directory $HOME/.dotfiles

@verify_file /Users/iamkhattar/projects/personal/dotfiles/verify.sh
@verify_environment_variable HOME
@verify_on_path /opt/homebrew/bin
@verify_symlink /Users/iamkhattar/projects/personal/dotfiles/test.txt /Users/iamkhattar/projects/personal/dotfiles/intellij/test.txt

@show_results