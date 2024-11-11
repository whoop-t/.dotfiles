#!/usr/bin/env bash
# Specify additional directories to search for
dirs=(
  "$HOME/.dotfiles"
  "$HOME/dev"
  "$HOME/Documents"
  "$HOME/Downloads"
  # Add more directories as needed
)

# Use fzf to select a directory
dir=$(find "${dirs[@]}" -maxdepth 4 -type d -not -path "*/\.git/*" -not -path "*/\node_modules/*" -print 2> /dev/null | fzf)

# If a directory was selected, open it in a new Kitty tab
if [ -n "$dir" ]; then
  kitty @ launch --type=tab --cwd "$dir" || echo "Failed to open new tab in: $dir"
else
  echo "No directory selected"
fi
