#!/usr/bin/env bash
# Bootstrap the tools these dotfiles depend on, on macOS or Linux.
# Safe to re-run: every step is skipped when already done.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_BIN="$HOME/.local/bin"
mkdir -p "$LOCAL_BIN"
export PATH="$LOCAL_BIN:$PATH"

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33mwarn:\033[0m %s\n' "$*" >&2; }
has() { command -v "$1" >/dev/null 2>&1; }

SUDO=""
if [ "$(id -u)" -ne 0 ] && has sudo; then SUDO="sudo"; fi

OS="$(uname -s)"
ARCH="$(uname -m)"

# ---------------------------------------------------------------------------
# Package manager
# ---------------------------------------------------------------------------
if [ "$OS" = "Darwin" ]; then
  if ! has brew; then
    info "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [ -x "$brew_bin" ] && eval "$("$brew_bin" shellenv)" && break
  done
  PM=brew
elif has apt-get; then
  PM=apt
elif has dnf; then
  PM=dnf
elif has pacman; then
  PM=pacman
elif has brew; then
  PM=brew
else
  echo "No supported package manager found (brew, apt, dnf, pacman)." >&2
  exit 1
fi
info "Using package manager: $PM"

# Install packages that must exist.
pkg_install() {
  case "$PM" in
    brew) brew install "$@" ;;
    apt) $SUDO apt-get install -y "$@" ;;
    dnf) $SUDO dnf install -y "$@" ;;
    pacman) $SUDO pacman -S --needed --noconfirm "$@" ;;
  esac
}

# Install packages one by one, warning instead of failing when unavailable.
pkg_try() {
  local pkg
  for pkg in "$@"; do
    pkg_install "$pkg" >/dev/null 2>&1 || warn "could not install '$pkg' with $PM, install it manually"
  done
}

case "$PM" in
  brew)
    has clang || xcode-select --install || true
    pkg_install git curl zsh tmux fzf ripgrep fd bat eza lazygit make unzip python
    pkg_try zellij
    brew install --cask alacritty || warn "could not install alacritty"
    ;;
  apt)
    $SUDO apt-get update
    pkg_install git curl zsh tmux fzf ripgrep fd-find bat make gcc unzip \
      python3 python3-venv python3-pip xclip wl-clipboard fontconfig
    pkg_try eza lazygit zellij alacritty
    ;;
  dnf)
    pkg_install git curl zsh tmux fzf ripgrep fd-find bat make gcc unzip \
      python3 python3-pip xclip wl-clipboard fontconfig
    pkg_try eza lazygit zellij alacritty
    ;;
  pacman)
    pkg_install git curl zsh tmux fzf ripgrep fd bat eza lazygit make gcc unzip \
      python python-pip xclip wl-clipboard fontconfig
    pkg_try zellij alacritty
    ;;
esac

# Debian/Ubuntu ship bat and fd as batcat and fdfind
has bat || { has batcat && ln -sf "$(command -v batcat)" "$LOCAL_BIN/bat"; }
has fd || { has fdfind && ln -sf "$(command -v fdfind)" "$LOCAL_BIN/fd"; }

# ---------------------------------------------------------------------------
# fzf >= 0.48 (needed for `fzf --zsh`; distro packages are often older)
# ---------------------------------------------------------------------------
if ! fzf --zsh >/dev/null 2>&1; then
  info "Installing a recent fzf into ~/.fzf"
  [ -d "$HOME/.fzf" ] || git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  "$HOME/.fzf/install" --bin
  ln -sf "$HOME/.fzf/bin/fzf" "$LOCAL_BIN/fzf"
fi

# ---------------------------------------------------------------------------
# Neovim >= 0.11 (needed for vim.lsp.enable / vim.lsp.config)
# ---------------------------------------------------------------------------
nvim_ok() { has nvim && nvim --headless -c 'if has("nvim-0.11") | qa | else | cq | endif' >/dev/null 2>&1; }
if ! nvim_ok; then
  if [ "$PM" = "brew" ] || [ "$PM" = "pacman" ]; then
    pkg_install neovim
  else
    case "$ARCH" in
      x86_64) nvim_pkg=nvim-linux-x86_64 ;;
      aarch64 | arm64) nvim_pkg=nvim-linux-arm64 ;;
      *) echo "Unsupported architecture for the Neovim tarball: $ARCH" >&2; exit 1 ;;
    esac
    info "Installing Neovim ($nvim_pkg) into ~/.local/opt"
    mkdir -p "$HOME/.local/opt"
    curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/$nvim_pkg.tar.gz" |
      tar -xz -C "$HOME/.local/opt"
    ln -sf "$HOME/.local/opt/$nvim_pkg/bin/nvim" "$LOCAL_BIN/nvim"
  fi
fi

# ---------------------------------------------------------------------------
# Zsh: oh-my-zsh, powerlevel10k, zsh-autosuggestions
# ---------------------------------------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  info "Installing oh-my-zsh"
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ -d "$ZSH_CUSTOM/themes/powerlevel10k" ] ||
  git clone --depth 1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] ||
  git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

# ---------------------------------------------------------------------------
# Node via nvm (mason needs node/npm for vtsls, pyright, prettierd, eslint)
# ---------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
if [ ! -s "$NVM_DIR/nvm.sh" ]; then
  info "Installing nvm"
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | PROFILE=/dev/null bash
fi
# shellcheck source=/dev/null
. "$NVM_DIR/nvm.sh"
nvm ls --no-colors default >/dev/null 2>&1 || { nvm install --lts && nvm alias default 'lts/*'; }

# ---------------------------------------------------------------------------
# tmux plugin manager (lives inside the repo's tmux/ dir, which is gitignored)
# ---------------------------------------------------------------------------
[ -d "$DOTFILES/tmux/plugins/tpm" ] ||
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$DOTFILES/tmux/plugins/tpm"

# ---------------------------------------------------------------------------
# Alacritty themes (gitignored; import one from alacritty.toml)
# ---------------------------------------------------------------------------
[ -d "$DOTFILES/alacritty/themes/.git" ] ||
  git clone --depth 1 https://github.com/alacritty/alacritty-theme "$DOTFILES/alacritty/themes"

# ---------------------------------------------------------------------------
# FiraCode Nerd Font (used by alacritty and nvim icons)
# ---------------------------------------------------------------------------
if [ "$PM" = "brew" ]; then
  brew list --cask font-fira-code-nerd-font >/dev/null 2>&1 ||
    brew install --cask font-fira-code-nerd-font || warn "could not install FiraCode Nerd Font"
elif ! fc-list 2>/dev/null | grep -qi "FiraCode Nerd Font"; then
  info "Installing FiraCode Nerd Font"
  font_dir="$HOME/.local/share/fonts/FiraCode"
  tmp_zip="$(mktemp)"
  mkdir -p "$font_dir"
  curl -fsSL -o "$tmp_zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
  unzip -oq "$tmp_zip" -d "$font_dir"
  rm -f "$tmp_zip"
  fc-cache -f "$font_dir" >/dev/null
fi

cat <<EOF

Done. Next steps:
  1. ./symlink.sh                       # link configs into place
  2. chsh -s "\$(command -v zsh)"         # make zsh your login shell
  3. open tmux and press prefix + I      # install tmux plugins (prefix is C-n)
  4. p10k configure                      # set up the prompt
  5. put machine-only settings in ~/.zshrc.local and ~/.gitconfig.local
EOF
