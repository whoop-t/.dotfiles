#!/usr/bin/env bash

os=$(uname)

if [[ "$os" == "Darwin" ]]; then
  selected=$(history | tail -r | fzf)
  if [ -n "$selected" ]; then
    echo "$selected" | awk '{$1=""; print $0}' | tr -d '\n' | pbcopy
    echo "Command copied to macOS clipboard."
  fi
elif [[ "$os" == "Linux" ]]; then
  selected=$(history | tac | fzf)
  if [ -n "$selected" ]; then
    echo "$selected" | awk '{$1=""; print $0}' | tr -d '\n' | xclip -selection clipboard
    echo "Command copied to Linux clipboard."
  fi
else
  echo "Unsupported operating system."
fi

