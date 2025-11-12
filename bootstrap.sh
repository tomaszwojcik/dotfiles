#!/usr/bin/env bash
set -euo pipefail

# -----------------------------
# Basic helpers
# -----------------------------
log() { printf "\033[1;32m[OK]\033[0m %s\n" "$*"; }
info() { printf "\033[1;34m[INFO]\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m[WARN]\033[0m %s\n" "$*"; }

ZSHRC="$HOME/.zshrc"
ZPROFILE="$HOME/.zprofile"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

backup_file() {
  [ -f "$1" ] && cp "$1" "${1}.bak-${TIMESTAMP}" && info "Backup created: ${1}.bak-${TIMESTAMP}"
}

append_once() {
  local line="$1"; local file="$2"
  grep -Fqx "$line" "$file" || echo "$line" >> "$file"
}

append_block_once() {
  local begin_tag="$1"; local end_tag="$2"; local content="$3"; local file="$4"
  if ! grep -Fq "$begin_tag" "$file"; then
    printf "\n%s\n%s\n%s\n" "$begin_tag" "$content" "$end_tag" >> "$file"
  fi
}

ensure_file() { [ -f "$1" ] || touch "$1"; }

# -----------------------------
# 0. Xcode Command Line Tools
# -----------------------------
if ! xcode-select -p >/dev/null 2>&1; then
  warn "Installing Xcode Command Line Tools..."
  xcode-select --install || true
fi

# -----------------------------
# 1. Homebrew setup
# -----------------------------
if ! command -v brew >/dev/null 2>&1; then
  info "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

ensure_file "$ZPROFILE"
if ! grep -Fq 'brew shellenv' "$ZPROFILE"; then
  if [ -x /opt/homebrew/bin/brew ]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$ZPROFILE"
  else
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "$ZPROFILE"
  fi
fi

# Load brew in current session
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"

# -----------------------------
# 2. Install base tools
# -----------------------------
brew update
brew install git autojump asdf

log "Installed: git, autojump, asdf"

# -----------------------------
# 3. oh-my-zsh
# -----------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  info "Installing oh-my-zsh..."
  export RUNZSH=no CHSH=no
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  unset RUNZSH CHSH
  log "oh-my-zsh installed."
fi

# -----------------------------
# 4. Configure .zshrc
# -----------------------------
ensure_file "$ZSHRC"
backup_file "$ZSHRC"

append_once 'eval "$(/opt/homebrew/bin/brew shellenv)"' "$ZSHRC"
append_once 'plugins=(git asdf direnv autojump)' "$ZSHRC"

append_block_once "# >>> autojump >>>" "# <<< autojump <<<" \
  '[[ -s "$(brew --prefix)/etc/profile.d/autojump.sh" ]] && . "$(brew --prefix)/etc/profile.d/autojump.sh"' "$ZSHRC"

append_block_once "# >>> asdf >>>" "# <<< asdf <<<" \
  'source "$(brew --prefix asdf)/libexec/asdf.sh"' "$ZSHRC"

# -----------------------------
# 5. asdf plugin setup
# -----------------------------
declare -a ASDF_PLUGINS=(checkov direnv nodejs packer ruby terraform tflint)

for p in "${ASDF_PLUGINS[@]}"; do
  if asdf plugin list | grep -Fxq "$p"; then
    info "Plugin already added: $p"
  else
    asdf plugin add "$p"
    log "Added plugin: $p"
  fi
done

# -----------------------------
# 6. asdf-direnv setup
# -----------------------------
asdf direnv setup --shell zsh --version latest

# -----------------------------
# 7. Node.js keys import
# -----------------------------
NODE_KEYRING="$(asdf plugin path nodejs)/bin/import-release-team-keyring"
[ -f "$NODE_KEYRING" ] && bash "$NODE_KEYRING" && log "Node.js keyring imported."

# -----------------------------
# 8. Install tools via asdf
# -----------------------------
declare -a ASDF_TO_INSTALL=(checkov nodejs packer ruby terraform tflint)

for t in "${ASDF_TO_INSTALL[@]}"; do
  info "Installing latest $t..."
  asdf install "$t" latest
  asdf global "$t" latest
done

asdf reshim

append_block_once "# >>> direnv >>>" "# <<< direnv <<<" \
  'command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"' "$ZSHRC"

# -----------------------------
# 9. Done
# -----------------------------
log "✅ Setup complete!"
echo "Open a new terminal session or run:"
echo "  source ~/.zprofile && source ~/.zshrc"
echo
echo "Check your setup:"
echo "  which git"
echo "  which ruby"
echo "  which node"
echo "  asdf current"

