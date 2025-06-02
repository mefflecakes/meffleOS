#!/usr/bin/env bash
set -euo pipefail

echo "▶ Installing required packages..."
dnf5 install -y \
  tmux \
  plymouth \
  plymouth-plugin-script

echo "▶ Enabling podman socket..."
systemctl enable podman.socket

echo "▶ Removing Bazzite Plymouth theme if installed..."
dnf5 remove -y bazzite-plymouth-theme || true

echo "▶ Installing custom Plymouth theme..."
mkdir -p /usr/share/plymouth/themes/steamos
cp /ctx/build_files/plymouth/steamos/* /usr/share/plymouth/themes/steamos/

echo "▶ Setting custom Plymouth theme as default..."
plymouth-set-default-theme steamos

echo "✅ build.sh completed successfully."
