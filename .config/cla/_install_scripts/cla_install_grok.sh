#!/bin/bash
set -eu

install_grok() {
  curl -fsSL https://x.ai/cli/install.sh | bash

  mv /home/cla/.grok /home/cla/.grok-image
  mkdir -p /home/cla/.grok
  ln -sf /home/cla/.grok-image/bin/grok /home/cla/.local/bin/grok
}

export -f install_grok
su -c 'bash -c install_grok' cla