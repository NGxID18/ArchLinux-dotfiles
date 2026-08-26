#!/bin/bash
set -e

## ======================================================= ##
# Main Applications (Pacman)
## ======================================================= ##

echo "Installing Essential Apps via Pacman..."
sudo pacman -S --needed --noconfirm \
    kitty \
    fastfetch \
    ttf-jetbrains-mono-nerd \
    zsh zsh-autosuggestions zsh-syntax-highlighting \
    mission-center \
    librewolf \
    discord \
    tailscale \
    cronie \
    snapper \
    util-linux \
    udisks2 lvm2 udisks2-lvm2 \
    btrfs-progs udisks2-btrfs \
    ntfs-3g ntfsprogs \
    xfsprogs exfatprogs

echo "Enabling core background services..."
sudo systemctl enable --now tailscaled
sudo systemctl enable --now cronie

## ======================================================= ##
# Cockpit & Btrfs Manager
## ======================================================= ##

if [[ "$INSTALL_COCKPIT" =~ ^[Yy]$ ]]; then
    echo "Installing Cockpit Server Management Tools..."
    sudo pacman -S --needed --noconfirm \
        cockpit \
        cockpit-storaged \
        pcp inetutils mdadm nfs-utils \
        wireguard-tools \
        packagekit

    echo "Installing Cockpit AUR Plugins..."
    paru -S --needed --noconfirm \
        cockpit-pacman \
        realmd

    echo "Enabling Cockpit service..."
    sudo systemctl enable --now cockpit.socket

    # Fix pacman gpg permissions for PackageKit / Cockpit
    sudo chmod 700 /etc/pacman.d/gnupg 2>/dev/null || true

    echo "Setting up Btrfs Manager Cockpit Module..."
    sudo mkdir -p /usr/share/cockpit
    if [ -d "/usr/share/cockpit/btrfs-manager" ]; then
        sudo rm -rf /usr/share/cockpit/btrfs-manager
    fi
    sudo git clone https://github.com/NGxID18/btrfs-manager /usr/share/cockpit/btrfs-manager
else
    echo "Skipping Cockpit installation based on user config."
fi

echo "All applications installed successfully!"
