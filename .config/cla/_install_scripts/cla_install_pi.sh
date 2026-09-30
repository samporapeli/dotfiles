#!/bin/bash
set -eu

# Install pi using the official installer, then relocate its managed install
# out of $PI_CODING_AGENT_DIR (default /home/cla/.pi/agent).
#
# The managed install writes the package to $PI_CODING_AGENT_DIR/install and the
# launcher to $PI_CODING_AGENT_DIR/bin/pi. :cla bind-mounts that agent directory
# per profile, which would hide the installation and leave the PATH entrypoint
# dangling.
#
# The launcher is relocatable: at runtime it resolves its own path through
# symlinks and derives the install directory from its location, so the tree can
# be moved and relinked exactly like cla_install_grok.sh relocates grok. The
# installer also resolves symlinks when detecting an existing managed install,
# so a later installer run reuses the relocated one instead of recreating it
# inside the mounted agent directory.
install_pi() {
  curl -fsSL https://pi.dev/install.sh | sh

  # Relocate the managed install and launcher out of the agent dir.
  rm -rf /home/cla/.pi-image
  mkdir -p /home/cla/.pi-image
  mv /home/cla/.pi/agent/install /home/cla/.pi-image/install
  mv /home/cla/.pi/agent/bin /home/cla/.pi-image/bin

  # Point the PATH entrypoint at the relocated launcher.
  rm -f /home/cla/.local/bin/pi
  ln -sf /home/cla/.pi-image/bin/pi /home/cla/.local/bin/pi
}

export -f install_pi
su -c 'bash -c install_pi' cla
