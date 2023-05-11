#!/usr/bin/env bash

selected=$(cat ~/.zsh_history | sed 's/.*;//' | fzf)

if [ -n "$selected" ]; then
  echo "$selected"
fi

