#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

link bin/on.sh "$HOME/bin/on"
link bin/og.sh "$HOME/bin/og"
link bin/orp.py "$HOME/bin/orp"
