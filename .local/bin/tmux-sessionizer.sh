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
tmux_running=$(pgrep tmux)

## If we arent in tmux and no tmux sessions are running
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    # Start a new TMUX session and attach
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

## Create detached tmux, its less error prone to create then switch
if ! tmux has-session -t=$selected_name 2> /dev/null; then
    # Create a new detached session
    tmux new-session -ds $selected_name -c $selected
fi

## Switch the the selected session, if it was created or not
tmux switch-client -t $selected_name
