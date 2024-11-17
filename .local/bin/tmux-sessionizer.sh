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

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    # Start a new TMUX session and attach
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    # Create a new detached session
    tmux new-session -ds $selected_name -c $selected
fi

if [[ -z $TMUX ]]; then
    # If not already in TMUX, attach to the session
    tmux attach-session -t $selected_name
else
    # Switch to the session
    tmux switch-client -t $selected_name
fi
