#!/bin/bash
set -eu

install_flutter() {
  USER_HOME='/home/claude'
  cd "$USER_HOME" || exit
  mkdir -p "$USER_HOME/develop"
  FLUTTER_SDK="flutter_linux_3.41.6-stable.tar.xz"
  curl -O "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/$FLUTTER_SDK"
  tar -xf "$FLUTTER_SDK" -C ~/develop/ && rm "$FLUTTER_SDK"
  echo 'export PATH="$HOME/develop/flutter/bin:$PATH"' >> "$USER_HOME/.device.profile"
  source "$USER_HOME/.device.profile"
  flutter --version
  flutter --disable-analytics
  dart --disable-analytics
}

export -f install_flutter
su -c 'bash -c install_flutter' claude
