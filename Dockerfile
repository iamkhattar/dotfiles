FROM homebrew/brew

COPY . /home/linuxbrew/.dotfiles
RUN brew bundle install --file=/home/linuxbrew/.dotfiles/Brewfile