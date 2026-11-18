#!/bin/bash
# Browser test kit: system libraries, fonts and a distro Chromium, so any
# headless-Chromium tool (Playwright, Puppeteer, Cypress, Selenium,
# chromium --headless) can start. Framework browser builds (e.g. Playwright's
# chromium-headless-shell) are downloaded per project.
# Expects the base layer to have run `zypper dup` (Tumbleweed is rolling).
set -euo pipefail

# 107: packages installed, but some %post scripts failed (they expect
# systemd/udev, absent in a container); the start check below verifies.
zypper --non-interactive install \
  chromium \
  dejavu-fonts \
  google-noto-sans-fonts \
  libX11-6 \
  libXcomposite1 \
  libXdamage1 \
  libXext6 \
  libXfixes3 \
  libXrandr2 \
  libasound2 \
  libatk-1_0-0 \
  libatk-bridge-2_0-0 \
  libatspi0 \
  libdbus-1-3 \
  libgbm1 \
  libgio-2_0-0 \
  libgobject-2_0-0 \
  libxcb1 \
  libxkbcommon0 \
  mozilla-nspr \
  mozilla-nss \
  || [ $? -eq 107 ]
zypper clean -a

chromium --headless --no-sandbox --disable-gpu --dump-dom about:blank > /dev/null
chromium --version
