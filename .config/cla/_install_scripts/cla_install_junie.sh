#!/bin/bash
set -eu

install_junie() {
  curl -fsSL https://junie.jetbrains.com/install.sh | bash
}

export -f install_junie
su -c 'bash -c install_junie' cla
