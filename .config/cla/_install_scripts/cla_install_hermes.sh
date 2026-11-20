#!/bin/bash
set -eu

# Installs Hermes into the image's default root (~/.hermes): program,
# toolchain and dependency environment. Per-profile data is mounted by :cla
# at ~/.hermes/profiles/cla with HERMES_HOME pointing there.
install_hermes() {
  set -euo pipefail

  curl -fsSL https://hermes-agent.nousresearch.com/install.sh |
    bash -s -- \
      --non-interactive \
      --skip-browser \
      --skip-computer-use
}

export -f install_hermes
su -c 'bash -c install_hermes' cla
