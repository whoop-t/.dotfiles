#!/usr/bin/env bash
# Specify additional directories to search for
dirs=(
  "$HOME/.dotfiles"
  "$HOME/dev"
  "$HOME/Documents"
  # Add more directories as needed
)

dir=$(find "${dirs[@]}" -maxdepth 4 -type d -not -path "*/\.git/*" -not -path "*/\node_modules/*" -print 2> /dev/null | fzf)

if [ -n "$dir" ]; then
  cd "$dir" || echo "Failed to change directory to: $dir"
else
  echo "No directory selected"
fi