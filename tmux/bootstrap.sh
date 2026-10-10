#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cmd tmux
link tmux "$HOME/.config/tmux"
clone_once https://github.com/tmux-plugins/tpm "$DOTFILES/tmux/plugins/tpm"
if has tmux; then
  "$DOTFILES/tmux/plugins/tpm/bin/install_plugins" || warn "tmux plugin install failed"
fi
