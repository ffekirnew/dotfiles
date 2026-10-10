# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Homebrew (macOS: Apple Silicon or Intel)
for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  [[ -x "$brew_bin" ]] && eval "$("$brew_bin" shellenv)" && break
done
unset brew_bin

# Personal paths, prepended only if they exist
for dir in "$HOME/.cargo/bin" "$HOME/.local/bin" "$HOME/bin"; do
  [[ -d "$dir" ]] && export PATH="$dir:$PATH"
done
unset dir

# Oh My Zsh (theme and plugins are installed into $ZSH_CUSTOM by zsh/bootstrap.sh)
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)
[[ -d "${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-autosuggestions" ]] && plugins+=(zsh-autosuggestions)
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Debian/Ubuntu ship bat and fd as batcat and fdfind
if command -v bat >/dev/null; then
  BAT_CMD=bat
elif command -v batcat >/dev/null; then
  BAT_CMD=batcat
fi

# Set up fzf key bindings and fuzzy completion
if command -v fzf >/dev/null; then
  eval "$(fzf --zsh)"
  export FZF_COMPLETION_TRIGGER='**'
  [[ -n "$BAT_CMD" ]] && export FZF_CTRL_T_OPTS="--preview '$BAT_CMD -n --color=always --line-range :500 {}'"
  export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

  # Advanced customization of fzf options via _fzf_comprun function
  # - The first argument to the function is the name of the command.
  # - You should make sure to pass the rest of the arguments to fzf.
  _fzf_comprun() {
    local command=$1
    shift

    case "$command" in
      cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
      export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
      ssh)          fzf --preview 'dig {}'                   "$@" ;;
      *)            fzf --preview "${BAT_CMD:-cat} -n --color=always --line-range :500 {}" "$@" ;;
    esac
  }
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Aliases for default apps (only when the replacement is installed)
[[ -n "$BAT_CMD" ]] && alias cat="$BAT_CMD"
command -v eza >/dev/null && alias ls='eza --color=always --long --git --no-filesize --no-permissions --no-user --no-time'
command -v fd >/dev/null || { command -v fdfind >/dev/null && alias fd='fdfind'; }

# Notes (Obsidian vault). Used by the aliases below, bin/ scripts and nvim.
# Override in ~/.zshrc.local if your vault lives elsewhere.
if [[ -z "$NOTES_DIR" ]]; then
  icloud_vault="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/ffekirnew"
  if [[ -d "$icloud_vault" ]]; then
    export NOTES_DIR="$icloud_vault"
  else
    export NOTES_DIR="$HOME/personal/notes"
  fi
  unset icloud_vault
fi
alias oo='cd "$NOTES_DIR"'
alias or='nvim -p "$NOTES_DIR"/inbox/*.md'
alias start='nvim -c ":ObsidianToday"'

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Machine-specific config (not tracked): extra PATHs, SDKs, aliases, etc.
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
