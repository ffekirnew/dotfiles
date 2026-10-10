#!/usr/bin/env bash
# Set up the dotfiles: runs each tool's bootstrap.sh.
# Usage: ./bootstrap.sh [tool ...]   (no args = all tools)
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"

# To add a tool: create <tool>/bootstrap.sh and add its name here.
TOOLS=(zsh git nvim tmux alacritty zellij bin)

if [ "$#" -gt 0 ]; then
  for tool in "$@"; do
    [ -f "$DOTFILES/$tool/bootstrap.sh" ] || { echo "error: no such tool '$tool' (missing $tool/bootstrap.sh)" >&2; exit 1; }
  done
  TOOLS=("$@")
fi

failed=()
for tool in "${TOOLS[@]}"; do
  info "$tool"
  bash "$DOTFILES/$tool/bootstrap.sh" || failed+=("$tool")
done

if [ "${#failed[@]}" -gt 0 ]; then
  warn "failed: ${failed[*]}"
  exit 1
fi

cat <<MSG

Done. Remaining manual steps:
  1. chsh -s "\$(command -v zsh)"    # make zsh your login shell
  2. p10k configure                  # set up the prompt
  3. put machine-only settings in ~/.zshrc.local and ~/.gitconfig.local
MSG
