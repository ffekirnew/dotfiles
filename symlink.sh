#!/usr/bin/env bash
# Link the dotfiles into place. Safe to re-run: correct links are skipped,
# and any real file/dir already at a target is moved to <target>.bak.<timestamp>.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d%H%M%S)"

link() {
  local src="$DOTFILES/$1" dst="$2"

  if [ ! -e "$src" ]; then
    echo "skip   $dst (missing $src)"
    return
  fi
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "ok     $dst"
    return
  fi
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mv "$dst" "$dst.bak.$STAMP"
    echo "backup $dst -> $dst.bak.$STAMP"
  fi

  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "link   $dst -> $src"
}

link nvim             "$HOME/.config/nvim"
link tmux             "$HOME/.config/tmux"
link alacritty        "$HOME/.config/alacritty"
link zellij           "$HOME/.config/zellij"
link git/gitconfig    "$HOME/.gitconfig"
link git/ignore       "$HOME/.config/git/ignore"
link zshrc/.zshrc     "$HOME/.zshrc"
link bin/on.sh        "$HOME/bin/on"
link bin/og.sh        "$HOME/bin/og"
link bin/orp.py       "$HOME/bin/orp"
