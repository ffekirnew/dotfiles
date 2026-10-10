# Shared helpers for the dotfiles bootstrap scripts. Meant to be `source`d,
# not executed. Does not set shell options or exit.

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STAMP="$(date +%Y%m%d%H%M%S)"

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33mwarn:\033[0m %s\n' "$*" >&2; }
has() { command -v "$1" >/dev/null 2>&1; }

# link SRC_REL DST: symlink $DOTFILES/SRC_REL at DST. Correct links are
# skipped; anything else at DST is moved to DST.bak.<timestamp>.
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

# require_cmd CMD [hint]: warn (never fail) when CMD is not installed.
require_cmd() {
  has "$1" || warn "$1 is not installed (see requirements.txt)${2:+: $2}"
  return 0
}

# clone_once URL DEST: shallow-clone URL into DEST unless DEST exists.
clone_once() {
  if [ -e "$2" ]; then
    echo "ok     $2"
    return 0
  fi
  git clone --depth 1 "$1" "$2"
}
