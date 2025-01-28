#!/usr/bin/env bash

# Specify additional directories to search for
dirs=(
  "$HOME/.dotfiles"
  "$HOME/dev"
  "$HOME/Documents"
  "$HOME/Downloads"
  # Add more directories as needed
)

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find "${dirs[@]}" -maxdepth 4 -type d -not -path "*/\.git/*" -not -path "*/\node_modules/*" -print 2> /dev/null | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)

if [[ -z $ZELLIJ ]]; then
	cd $selected
  
  # -c will make zellij to either create a new session or to attach into an existing one
	zellij attach $selected_name -c
	exit 0
else
  # Below works, but will only create in background
  # better to just get used to detachting and then running
	# cd $selected
	# zellij attach $selected_name -c -b
  # echo "session created" && exit 0

  echo "detach from session first" && exit 0
fi
