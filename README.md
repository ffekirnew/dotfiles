# dotfiles
My dotfiles. Works on macOS and Linux (apt, dnf or pacman).

## Contents
- [X] [Alacritty](./alacritty)
- [X] [Bin](./bin)
- [X] [Git](./git)
- [X] [Neovim](./nvim)
- [X] [Tmux](./tmux)
- [X] [Zellij](./zellij)
- [X] [Zsh](./zsh)
- [X] [Shared helpers](./lib)

## Usage
1. Clone the repository to your home directory.
```bash
cd ~
git clone https://github.com/ffekirnew/dotfiles.git
cd dotfiles
```

2. Install the tools listed in `requirements.txt` yourself (the bootstrap scripts do not install binaries).

3. Set up the configs: links them into place (existing files are moved to `<file>.bak.<timestamp>`)
   and fetches plugin managers, plugins and themes. Safe to re-run.
```bash
./bootstrap.sh              # everything
./bootstrap.sh nvim tmux    # only some tools
```

4. Finish up: `chsh -s "$(command -v zsh)"`, then run `p10k configure`. The tmux prefix is `C-n`.

## Adding a tool
Create `<tool>/bootstrap.sh` (source `lib/common.sh` for `link`, `require_cmd`, `clone_once`;
see any existing one) and add the tool's name to the `TOOLS` array in `bootstrap.sh`.

## Machine-specific config
These files are sourced if present and are not tracked:
- `~/.zshrc.local` for extra PATHs, SDKs and aliases. Set `NOTES_DIR` here if your notes vault
  is not at the default (`~/Library/Mobile Documents/iCloud~md~obsidian/Documents/ffekirnew`
  on macOS if present, otherwise `~/personal/notes`).
- `~/.gitconfig.local` for git overrides such as a work email.

## Alacritty theme
Themes are cloned into `alacritty/themes` by `alacritty/bootstrap.sh`. To use one, add to `alacritty.toml`:
```toml
[general]
import = ["~/.config/alacritty/themes/themes/<name>.toml"]
```
