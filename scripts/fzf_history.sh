#!/usr/bin/env bash

selected=$(cat ~/.zsh_history | fzf)

if [ -n "$selected" ]; then
  echo "$selected"
fi

