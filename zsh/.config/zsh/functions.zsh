function drun() {
  docker run -w /workspace -e PS1="🐳 \[\033[1;36m\]\h \[\033[1;34m\]\W\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]" --rm -it $1 /bin/sh
}

function dvrun() {
  docker run -v .:/workspace -w /workspace -e PS1="🐳 \[\033[1;36m\]\h \[\033[1;34m\]\W\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]" --rm -it $1 /bin/sh
}

function digga() {
  dig +nocmd "$1" any +multiline +noall +answer;
}

function server() {
	local port="${1:-8000}"
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

function load-env() {
  local filePath="${1:-.env}"

  if [ ! -f "$filePath" ]; then
    echo "missing ${filePath}"
    exit 1
  fi

  source $filePath
  echo "Loaded $filePath to Shell"
}

function __scratches_help() {
  echo "USAGE: scratches <subcommand>"
  echo ""
  echo "Commands:"
  echo "  help      Show help."
  echo "  create    Create a scratch."
  echo "  purge     Purge current scratch."
}

function scratches() {
  if [ "$#" -ne 1 ]; then
    __scratches_help
    return 1
  fi
  if [[ "$1" == "help" ]]; then
    __scratches_help
    return 0
  fi
  if [[ "$1" == "create" ]]; then
    scratch_name=$(awk "NR==$RANDOM {print}" /usr/share/dict/words | awk '{print tolower($0)}')
    mkdir -p "$HOME/projects/scratch/${scratch_name}"
    cd $HOME/projects/scratch/${scratch_name}
    return 0
  fi
  if [[ "$1" == "purge" ]]; then
    current_directory=$(pwd)
    if [[ ${current_directory} == $HOME/projects/scratch/* ]]; then
      cd $HOME/projects/scratch
      rm -rf ${current_directory}
    fi
    return 0
  fi
  __scratches_help
  return 1
}
