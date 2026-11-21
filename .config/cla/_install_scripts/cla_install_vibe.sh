#!/bin/bash
set -eu

# uv tool install puts the `vibe`/`vibe-acp` shims in ~/.local/bin and the
# tool environment in ~/.local/share/uv. Config and state live separately in
# ~/.vibe, which :cla bind-mounts per profile, so no relocation is needed.
#
# The installer exits non-zero unless the shim is already on PATH; the image
# sets ~/.local/bin on PATH only after the installer RUN steps.
install_vibe() {
  export PATH="/home/cla/.local/bin:${PATH}"
  curl -LsSf https://mistral.ai/vibe/install.sh | bash
}

export -f install_vibe
su -c 'bash -c install_vibe' cla
