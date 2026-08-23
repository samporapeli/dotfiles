#!/bin/bash
set -eu

install_codex() {
  export CODEX_HOME=/home/cla/.codex-packages
  curl -fsSL https://chatgpt.com/codex/install.sh | bash
}

export -f install_codex
su -c 'bash -c install_codex' cla
