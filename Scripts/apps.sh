#!/bin/bash

## ======================================================= ##

#Pacman Main Applications
echo "Installing main applications using Pacman..."
sudo pacman -S --needed --noconfirm \
    kitty \
    fastfetch \
    ttf-jetbrains-mono-nerd \
    zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    tuned \
    mission-center \
    wine \
    android-tools \
    scrcpy \
    tailscale \
    zerotier-one \
    discord \
    obs-studio \
    solaar \
    openrgb

sudo systemctl enable --now tuned
sudo systemctl enable --now zerotier-one

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

## ======================================================= ##

# Server Management Tools
echo "Installing Server Management Tools..."
sudo pacman -S --needed --noconfirm \
    docker \
    docker-compose \
    samba \
    dnsmasq \
    virt-install \
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
    cockpit-dockermanager \
    cockpit-machines \
    realmd \
    vmware-workstation

sudo systemctl enable --now docker.service
sudo systemctl enable --now cockpit.socket
sudo systemctl enable --now libvirtd.service
sudo systemctl enable --now vmware-networks.service

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

sudo chmod 700 /etc/pacman.d/gnupg
sudo git clone https://github.com/NGxID18/btrfs-manager /usr/share/cockpit/btrfs-manager

sudo systemctl enable --now smb nmb

## ======================================================= ##

echo "All applications installed successfully!"
