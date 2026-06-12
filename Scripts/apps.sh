#!/bin/bash

## ======================================================= ##

#Pacman Main Applications
echo "Installing main applications using Pacman..."
sudo pacman -S \
    ghostty \
    fastfetch \
    mission-center \
    steam \
    discord \
    obs-studio \
    solaar \
    openrgb

## ======================================================= ##

# AUR Applications
echo "Installing applications from the AUR using Paru..."
paru -S \
    visual-studio-code-bin \
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
sudo pacman -S \
    docker \
    docker-compose \
    cockpit \
    cockpit-storaged \
    udisks2 \
    udisks2-btrfs \
    btrfs-progs \
    snapper \
    cronie \
    lvm2 \
    mdadm \
    ntfs-3g \
    ntfsprogs \
    xfsprogs \
    exfatprogs

paru -S \
    cockpit-pacman \
    cockpit-dockermanager

sudo git clone https://github.com/NGxID18/btrfs-manager /usr/share/cockpit/btrfs-manager

sudo systemctl enable --now docker.service
sudo systemctl enable --now cockpit.socket

## ======================================================= ##

echo "All applications installed successfully!"
