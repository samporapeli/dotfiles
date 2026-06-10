#!/bin/bash
set -eu

install_samporapeli_dotfiles() {
  USER_HOME='/home/cla'
  cd "$USER_HOME" || exit
  export SAMPORAPELI_DOTFILES_UNATTENDED_INSTALL=true
  bash <(curl -sL sampo.website/install-dotfiles.sh)
}

export -f install_samporapeli_dotfiles
su -c 'bash -c install_samporapeli_dotfiles' cla
