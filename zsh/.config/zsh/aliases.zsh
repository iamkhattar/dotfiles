# Update Software from brew and npm
alias update='brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g;'

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Volume related aliases
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume output volume 100'"

# Docker aliases
alias dpa='docker ps -a'
alias drm='docker rm -f $(docker ps -aq)'
alias dip='docker image prune -f'
alias lzd='lazydocker'

# Utility aliases
alias chrome="open -a /Applications/Google\ Chrome.app"
alias projects="cd $PROJECT_DIR"

# System information
alias displays="system_profiler SPDisplaysDataType"
alias cpu="sysctl -n machdep.cpu.brand_string"
alias ram="top -l 1 -s 0 | grep PhysMem"