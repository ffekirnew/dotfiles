#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cmd nvim
require_cmd tree-sitter "tree-sitter-cli, needed to build treesitter parsers"
link nvim "$HOME/.config/nvim"
if has nvim; then
  # installs plugins from nvim-pack-lock.json, runs build hooks and installs treesitter parsers
  nvim --headless +qa || warn "nvim plugin install failed"
fi
