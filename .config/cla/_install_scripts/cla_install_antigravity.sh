#!/bin/bash
set -eu

install_antigravity() {
  curl -fsSL https://antigravity.google/cli/install.sh | bash
}

export -f install_antigravity
su -c 'bash -c install_antigravity' cla
