#!/usr/bin/env bash
# bootstrap-vim.sh
# Purpose: install/build Vim + vim-plug + Node.js for coc.nvim, then link/install your vimrc.
# Usage:
#   bash bootstrap-vim.sh              # use distro vim if available
#   bash bootstrap-vim.sh --compile-vim # build Vim into ~/.local
#
# Put this script and your vimrc in the same dotfiles repo:
#   ~/.dotfiles/bootstrap-vim.sh
#   ~/.dotfiles/vimrc

set -Eeuo pipefail

COMPILE_VIM=0
INSTALL_COC_EXT=1
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
VIMRC_SRC="${SCRIPT_DIR}/vimrc"
VIMRC_DST="${HOME}/.vimrc"
NVM_VERSION="v0.40.4"
NODE_MIN_VERSION="20.19.0"
COC_EXTENSIONS=(
  coc-json
  coc-vimlsp
  coc-python
  coc-marketplace
  coc-tsserver
  coc-snippets
  coc-java
  coc-clangd
  coc-go
)

log()  { printf '\033[1;32m[OK]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[WARN]\033[0m %s\n' "$*"; }
die()  { printf '\033[1;31m[ERR]\033[0m %s\n' "$*" >&2; exit 1; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --compile-vim) COMPILE_VIM=1 ;;
    --no-coc-ext) INSTALL_COC_EXT=0 ;;
    -h|--help)
      sed -n '1,24p' "$0"
      exit 0
      ;;
    *) die "Unknown argument: $1" ;;
  esac
  shift
done

has_cmd() { command -v "$1" >/dev/null 2>&1; }

detect_pm() {
  if has_cmd dnf; then echo dnf; return; fi
  if has_cmd apt-get; then echo apt; return; fi
  die "Only dnf and apt-get are supported by this script."
}

install_packages() {
  local pm
  pm="$(detect_pm)"
  log "Detected package manager: ${pm}"

  if [[ "$pm" == "dnf" ]]; then
    sudo dnf install -y \
      git curl ca-certificates \
      gcc gcc-c++ make automake autoconf libtool \
      ncurses-devel python3-devel perl-devel ruby-devel lua-devel \
      gtk3-devel libXt-devel \
      xclip ripgrep \
      nodejs npm
  else
    sudo apt-get update
    sudo apt-get install -y \
      git curl ca-certificates \
      build-essential automake autoconf libtool-bin pkg-config \
      libncurses-dev python3-dev libperl-dev ruby-dev lua5.4 liblua5.4-dev \
      libgtk-3-dev libxt-dev \
      xclip ripgrep \
      nodejs npm
  fi
}

version_ge() {
  # usage: version_ge current minimum
  [[ "$(printf '%s\n%s\n' "$2" "$1" | sort -V | head -n1)" == "$2" ]]
}

install_node_with_nvm_if_needed() {
  local current=""
  if has_cmd node; then
    current="$(node -p 'process.versions.node' 2>/dev/null || true)"
  fi

  if [[ -n "$current" ]] && version_ge "$current" "$NODE_MIN_VERSION"; then
    log "Node.js ${current} is OK."
    return
  fi

  warn "Node.js is missing or too old. Installing Node LTS with nvm..."
  export NVM_DIR="${HOME}/.nvm"

  if [[ ! -s "${NVM_DIR}/nvm.sh" ]]; then
    curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
  fi

  # shellcheck disable=SC1091
  source "${NVM_DIR}/nvm.sh"

  nvm install --lts
  nvm alias default 'lts/*'
  nvm use default

  log "Node.js installed: $(node -v)"
}

install_or_build_vim() {
  if [[ "$COMPILE_VIM" -eq 0 ]]; then
    if has_cmd vim; then
      log "Using existing Vim: $(vim --version | head -n1)"
      return
    fi

    warn "Vim not found. Installing distro Vim..."
    local pm
    pm="$(detect_pm)"
    if [[ "$pm" == "dnf" ]]; then
      sudo dnf install -y vim-enhanced
    else
      sudo apt-get install -y vim-gtk3 || sudo apt-get install -y vim
    fi
    return
  fi

  log "Building Vim from source into ${HOME}/.local ..."
  mkdir -p "${HOME}/src" "${HOME}/.local"

  if [[ ! -d "${HOME}/src/vim/.git" ]]; then
    git clone https://github.com/vim/vim.git "${HOME}/src/vim"
  else
    git -C "${HOME}/src/vim" pull --ff-only
  fi

  cd "${HOME}/src/vim"
  make distclean >/dev/null 2>&1 || true

  ./configure \
    --prefix="${HOME}/.local" \
    --with-features=huge \
    --enable-multibyte \
    --enable-python3interp=dynamic \
    --enable-cscope \
    --enable-terminal \
    --with-x \
    --enable-gui=no \
    --enable-fail-if-missing

  make -j"$(nproc)"
  make install

  if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "${HOME}/.bashrc" 2>/dev/null; then
    printf '\n# User-local binaries\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "${HOME}/.bashrc"
  fi

  export PATH="${HOME}/.local/bin:${PATH}"
  log "Built Vim: $(vim --version | head -n1)"
}

install_vim_plug() {
  log "Installing vim-plug..."
  curl -fLo "${HOME}/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install_vimrc() {
  if [[ ! -f "$VIMRC_SRC" ]]; then
    warn "No vimrc found at ${VIMRC_SRC}. Put your vimrc next to this script and name it 'vimrc'."
    return
  fi

  if [[ -e "$VIMRC_DST" && ! -L "$VIMRC_DST" ]]; then
    local backup="${VIMRC_DST}.bak.$(date +%Y%m%d-%H%M%S)"
    cp "$VIMRC_DST" "$backup"
    warn "Existing ~/.vimrc backed up to ${backup}"
  fi

  ln -sfn "$VIMRC_SRC" "$VIMRC_DST"
  log "Linked ${VIMRC_DST} -> ${VIMRC_SRC}"
}

install_plugins() {
  if ! has_cmd vim; then
    warn "vim command not found; skip PlugInstall."
    return
  fi

  log "Installing Vim plugins with vim-plug..."
  vim +'PlugInstall --sync' +qa || {
    warn "PlugInstall failed. Check colorscheme/plugin errors in your vimrc."
    return
  }

  if [[ "$INSTALL_COC_EXT" -eq 1 ]]; then
    log "Installing coc.nvim extensions..."
    vim +"CocInstall -sync ${COC_EXTENSIONS[*]}" +qa || \
      warn "CocInstall failed. Open Vim and run :CocInfo / :messages to inspect."
  fi
}

print_report() {
  echo
  log "Bootstrap finished."
  echo "Check:"
  echo "  vim --version | head"
  echo "  vim +'PlugStatus' +qa"
  echo "  vim +'CocInfo' +qa"
  echo
  echo "If you built Vim into ~/.local, restart your shell or run:"
  echo '  source ~/.bashrc'
}

main() {
  install_packages
  install_node_with_nvm_if_needed
  install_or_build_vim
  install_vim_plug
  install_vimrc
  install_plugins
  print_report
}

main "$@"
