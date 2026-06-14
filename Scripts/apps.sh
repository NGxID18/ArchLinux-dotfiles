#!/bin/bash

## ======================================================= ##

#Pacman Main Applications
echo "Installing main applications using Pacman..."
sudo pacman -S --needed --noconfirm \
    ghostty \
    fastfetch \
    ttf-jetbrains-mono-nerd \
    zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    mission-center \
    zram-generator \
    tailscale \
    zerotier-one \
    discord \
    obs-studio \
    solaar \
    openrgb

echo "Installing Steam (Please select the correct GPU library)..."
sudo pacman -S --needed steam

## ======================================================= ##

# AUR Applications
echo "Installing applications from the AUR using Paru..."
paru -S --noconfirm \
    visual-studio-code-bin \
    protonup-qt-bin \
    google-chrome \
    zoom

## ======================================================= ##

# Flatpak Applications
echo "Installing applications from Flathub..."
flatpak install -y \
    com.rtosta.zapzap \
    org.onlyoffice.desktopeditors \
    io.github.shiftey.Desktop \
    sh.ppy.osu

## ======================================================= ##

# Server Management Tools
echo "Installing Server Management Tools..."
sudo pacman -S --needed --noconfirm \
    docker \
    docker-compose \
    cockpit \
    cockpit-storaged \
    packagekit \
    udisks2 \
    btrfs-progs \
    udisks2-btrfs \
    lvm2 \
    udisks2-lvm2 \
    ntfs-3g \
    ntfsprogs \
    xfsprogs \
    exfatprogs \
    util-linux \
    mdadm \
    snapper \
    cronie

paru -S --noconfirm \
    cockpit-pacman \
    cockpit-dockermanager

sudo git clone https://github.com/NGxID18/btrfs-manager /usr/share/cockpit/btrfs-manager

sudo systemctl enable --now docker.service
sudo systemctl enable --now cockpit.socket

## ======================================================= ##

echo "All applications installed successfully!"
