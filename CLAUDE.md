# CLAUDE.md

Guidance for AI coding agents working in this personal dotfiles repo.

## What this is
- Personal dotfiles that must work on any Unix: macOS and Linux (apt, dnf, pacman).
- One directory per tool. Each has its config plus an executable `bootstrap.sh`.

## Layout
- `bootstrap.sh` (root): runs each tool's bootstrap. `TOOLS=(zsh git nvim tmux alacritty zellij bin)`.
  `./bootstrap.sh nvim tmux` runs a subset. Exits 1 and lists failures if any fail.
- `lib/common.sh`: sourced helpers, not executed.
  - `DOTFILES`: repo root, derived from the file's location.
  - `info`, `warn`, `has`: logging and `command -v`.
  - `link SRC_REL DST`: symlink `$DOTFILES/SRC_REL` to `DST`. Skips correct links. Moves anything else to `DST.bak.<timestamp>`. Creates parent dirs.
  - `require_cmd CMD [hint]`: warns if CMD is missing. Never fails.
  - `clone_once URL DEST`: shallow clone unless `DEST` exists.
- Tool dirs: `alacritty/`, `bin/`, `git/`, `nvim/`, `tmux/`, `zellij/`, `zsh/`.
- `requirements.txt`: CLI tools the user installs with their package manager.
- `.gitignore`: `/tmux/plugins/`, `/alacritty/themes/`. `nvim/.gitignore` is separate.

## Adding a tool
1. Create `<tool>/` with its config and an executable `bootstrap.sh`. Copy the template from `zellij/bootstrap.sh`:
   ```bash
   #!/usr/bin/env bash
   set -euo pipefail
   source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

   require_cmd zellij
   link zellij "$HOME/.config/zellij"
   ```
   For downloads, see `alacritty/bootstrap.sh`: `clone_once URL "$DOTFILES/alacritty/themes"`.
2. Add the name to `TOOLS` in root `bootstrap.sh`.
3. Add required binaries to `requirements.txt`, with a comment.
4. If the bootstrap downloads anything into the repo, add a `.gitignore` entry.
5. Add the tool to README "Contents".

## Conventions
- Bootstraps do setup only: link config, fetch plugin managers, plugins and themes.
  Never install binaries via package managers. Those go in `requirements.txt`.
- Every script is idempotent and runs standalone (`./<tool>/bootstrap.sh`).
- Portable paths: use `$HOME`. Never hardcode `/Users/...` or `/home/...`.
- Branch on OS only when unavoidable. Guard optional tools with `command -v` or `has`.
  Guard `source` and `eval` calls with existence checks.
- Debian/Ubuntu name collisions are handled in `zsh/.zshrc`: `BAT_CMD` falls back from `bat` to `batcat`,
  and `fd` falls back to `fdfind`. Follow the same pattern.
- Machine-specific settings go in untracked `~/.zshrc.local` and `~/.gitconfig.local`. Never put them in the repo.
  `zsh/.zshrc` and `git/gitconfig` source these.
- Notes vault: `NOTES_DIR` is set in `zsh/.zshrc` (iCloud Obsidian path on macOS if present, else `~/personal/notes`).
  It is used by `bin/on.sh`, `bin/og.sh`, `bin/orp.py` and `nvim/lua/ffekirnew/plugins/advanced/obsidian.lua`. Override it in `~/.zshrc.local`.
- Downloaded plugins and themes live in gitignored dirs (`tmux/plugins/`, `alacritty/themes/`). Never commit them.

## Verifying changes
- Syntax: `bash -n <script>` for bash scripts, `zsh -n zsh/.zshrc` and `zsh -n bin/*.sh` for zsh.
- Sandbox run, twice. The second run should print only `ok` and `skip` lines:
  ```bash
  SB=$(mktemp -d); HOME=$SB ./bootstrap.sh git bin zellij
  HOME=$SB ./bootstrap.sh git bin zellij
  ```
- Never run bootstrap against the real `$HOME` without the user's explicit OK. It replaces real files (backing them up).
- Avoid the `zsh` and `nvim` bootstraps in tests. They download oh-my-zsh and sync plugins.
  The `tmux` bootstrap clones TPM and installs plugins, so test it with a sandbox HOME only if needed.

## Workflow and gotchas
- Make changes as a PR from a branch. Do not push directly to `master`. Commit only when asked.
- The user's interactive shell aliases `cat` to bat (or batcat) and `ls` to eza. In commands you run, use `command cat`, `command ls`,
  `sed -n` or `grep` to read files.
- `gh pr edit` fails on this repo with a Projects (classic) GraphQL deprecation error. Update PR bodies with:
  `gh api -X PATCH repos/ffekirnew/dotfiles/pulls/<n> -F body=@file`
- When writing PR bodies with a quoted heredoc (`<<'EOF'`), do not backslash-escape backticks.
- tmux prefix is `C-n` (`tmux/tmux.conf`). Alacritty themes are imported from `~/.config/alacritty/themes/themes/<name>.toml`.
