#!/bin/bash
set -eu

install_opencode() {
  curl -fsSL https://opencode.ai/install | bash

  mkdir -p /home/cla/.config/opencode
  mkdir -p /home/cla/.local/share/opencode
  mkdir -p /home/cla/.local/state/opencode
}

export -f install_opencode
su -c 'bash -c install_opencode' cla
