FROM homebrew/brew:latest

COPY . .

RUN brew update && brew install zsh && brew cleanup