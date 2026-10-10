#!/usr/bin/env zsh

if [ -z "$NOTES_DIR" ] || [ ! -d "$NOTES_DIR" ]; then
  echo "Error: NOTES_DIR is not set or does not exist (${NOTES_DIR:-unset})." >&2
  exit 1
fi

if [ -z "$1" ]; then
  echo "Error: please provide a title for the note."
  exit 1
fi

file_name=$(echo "$1" | tr ' ' '-')
formatted_file_name=$(date "+%Y-%m-%d")_${file_name}.md
cd "$NOTES_DIR" || exit
touch "inbox/${formatted_file_name}"
nvim "inbox/${formatted_file_name}"
