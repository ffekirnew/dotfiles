#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cmd alacritty
link alacritty "$HOME/.config/alacritty"
clone_once https://github.com/alacritty/alacritty-theme "$DOTFILES/alacritty/themes"
