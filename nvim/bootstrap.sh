#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cmd nvim
link nvim "$HOME/.config/nvim"
if has nvim; then
  nvim --headless "+Lazy! sync" +qa || warn "nvim plugin sync failed"
fi
