#!/bin/bash
set -eu

install_claude_code() {
  curl -fsSL https://claude.ai/install.sh | bash
}

export -f install_claude_code
su -c 'bash -c install_claude_code' cla
