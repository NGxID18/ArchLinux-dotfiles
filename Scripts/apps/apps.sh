#!/bin/bash

## ======================================================= ##

#Pacman Main Applications
echo "Installing Essential Apps..."
sudo pacman -S --needed --noconfirm \
    kitty \
    fastfetch \
    ttf-jetbrains-mono-nerd \
    zsh zsh-autosuggestions zsh-syntax-highlighting \
    mission-center \
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

paru -S --noconfirm \
    visual-studio-code-bin \
    google-chrome \
    zoom

flatpak install -y \
    com.rtosta.zapzap \
    org.onlyoffice.desktopeditors

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

    paru -S --noconfirm protonup-qt-bin

else
    echo "Skipping Additional Apps installation based on user config."
fi

echo "All applications installed successfully!"
