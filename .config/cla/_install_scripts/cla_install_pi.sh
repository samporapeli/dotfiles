#!/bin/bash
set -eu

install_pi() {
  curl -fsSL https://pi.dev/install.sh | sh
}

export -f install_pi
su -c 'bash -c install_pi' cla
