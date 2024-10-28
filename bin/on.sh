#!/bin/zsh

if [ -z "$1" ]; then
  echo "Error: please provide a title for the note."
  exit 1
fi

file_name=$(echo "$1" | tr ' ' '-')
formatted_file_name=$(date "+%Y-%m-%d")_${file_name}.md
cd "/Users/ffekirnew/Documents/personal" || exit
touch "inbox/${formatted_file_name}"
nvim "inbox/${formatted_file_name}"
