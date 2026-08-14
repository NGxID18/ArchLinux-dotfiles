#!/bin/bash

## ======================================================= ##

# Pacman Main Applications
echo "Installing Essential Apps via Pacman..."
sudo pacman -S --needed --noconfirm \
    kitty \
    fastfetch \
    ttf-jetbrains-mono-nerd \
    zsh zsh-autosuggestions zsh-syntax-highlighting \
    mission-center \
    librewolf \
    tailscale \
    zerotier-one \
    discord \
    udisks2 lvm2 udisks2-lvm2 \
    btrfs-progs udisks2-btrfs \
    ntfs-3g ntfsprogs \
    xfsprogs exfatprogs \
    util-linux mdadm \
    snapper \
    cronie

# AUR Main Applications via Paru
echo "Installing Essential Apps via Paru (AUR)..."
paru -S --noconfirm --needed \
    antigravity-bin \
    zoom \
    onlyoffice-bin \
    zapzap-bin

sudo systemctl enable --now tailscaled
sudo systemctl enable --now zerotier-one.service

## ======================================================= ##

# Additional Apps
if [[ "$INSTALL_ADDONS" =~ ^[Yy]$ ]]; then
    echo "Installing Additional Apps..."
    sudo pacman -S --needed --noconfirm \
        android-tools \
        scrcpy \
        wine \
        obs-studio \
        solaar \
        openrgb

    paru -S --noconfirm --needed protonup-qt-bin
else
    echo "Skipping Additional Apps installation based on user config."
fi

## ======================================================= ##

# Cockpit & Btrfs Manager
if [[ "$INSTALL_COCKPIT" =~ ^[Yy]$ ]]; then
    echo "Installing Cockpit Server Management Tools..."
    sudo pacman -S --needed --noconfirm \
        cockpit \
        cockpit-storaged \
        packagekit

    paru -S --noconfirm --needed \
        cockpit-pacman \
        realmd

    sudo systemctl enable --now cockpit.socket

    sudo chmod 700 /etc/pacman.d/gnupg 2>/dev/null || true
    if [ -d "/usr/share/cockpit/btrfs-manager" ]; then
        sudo rm -rf /usr/share/cockpit/btrfs-manager
    fi
    sudo git clone https://github.com/NGxID18/btrfs-manager /usr/share/cockpit/btrfs-manager
else
    echo "Skipping Cockpit installation based on user config."
fi

echo "All applications installed successfully!"

