#!/bin/bash
set -eu

install_opencode() {
  curl -fsSL https://opencode.ai/install | bash
}

export -f install_opencode
su -c 'bash -c install_opencode' cla
