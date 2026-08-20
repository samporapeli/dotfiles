#!/bin/bash
set -eu

install_copilot_cli() {
  curl -fsSL https://gh.io/copilot-install | bash
}

export -f install_copilot_cli
su -c 'bash -c install_copilot_cli' cla
