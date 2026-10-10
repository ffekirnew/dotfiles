# dotfiles
My dotfiles. Works on macOS and Linux (apt, dnf or pacman).

## Contents
- [X] [Alacritty](./alacritty)
- [X] [Bin](./bin)
- [X] [Git](./git)
- [X] [Neovim](./nvim)
- [X] [Tmux](./tmux)
- [X] [Zellij](./zellij)
- [X] [Zsh](./zshrc)

## Usage
1. Clone the repository to your home directory.
```bash
cd ~
git clone https://github.com/ffekirnew/dotfiles.git
cd dotfiles
```

2. Install dependencies: zsh + oh-my-zsh + powerlevel10k, Neovim >= 0.11, tmux + TPM,
   fzf, ripgrep, fd, bat, eza, lazygit, nvm/node, alacritty themes and FiraCode Nerd Font.
   Safe to re-run.
```bash
./install.sh
```

3. Link the configs into place. Safe to re-run; existing files are moved to `<file>.bak.<timestamp>`.
```bash
./symlink.sh
```

4. Finish up: `chsh -s "$(command -v zsh)"`, open tmux and press `prefix + I` (prefix is `C-n`),
   then run `p10k configure`.

## Machine-specific config
These files are sourced if present and are not tracked:
- `~/.zshrc.local` for extra PATHs, SDKs and aliases. Set `NOTES_DIR` here if your notes vault
  is not at the default (`~/Library/Mobile Documents/iCloud~md~obsidian/Documents/ffekirnew`
  on macOS if present, otherwise `~/personal/notes`).
- `~/.gitconfig.local` for git overrides such as a work email.

## Alacritty theme
Themes are cloned into `alacritty/themes` by `install.sh`. To use one, add to `alacritty.toml`:
```toml
[general]
import = ["~/.config/alacritty/themes/themes/<name>.toml"]
```
