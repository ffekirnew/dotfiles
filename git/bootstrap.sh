#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cmd git
link git/gitconfig "$HOME/.gitconfig"
link git/ignore "$HOME/.config/git/ignore"
