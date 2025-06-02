#!/bin/bash

set -ouex pipefail

### Install packages

dnf5 install -y tmux plymouth

# Enable podman socket
systemctl enable podman.socket

### Custom: De-Bazzite + SteamOS Plymouth

# Remove Bazzite theme if present
dnf5 remove -y bazzite-plymouth-theme || true

# Copy SteamOS Plymouth theme into the image
mkdir -p /usr/share/plymouth/themes/steamos
cp /ctx/build_files/plymouth/steamos/* /usr/share/plymouth/themes/steamos/

# Set SteamOS theme as default
plymouth-set-default-theme -R steamos
