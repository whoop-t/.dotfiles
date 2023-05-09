#!/usr/bin/env bash

dir=$(find $HOME/dev -mindepth 1 -maxdepth 2 -type d -not -path "*/\.*" -not -path "*/\.git/*" -not -path "*/\node_modules/*" -print 2> /dev/null | fzf)

if [ -n "$dir" ]; then
  cd "$dir" || echo "Failed to change directory to: $dir"
else
  echo "No directory selected"
fi

