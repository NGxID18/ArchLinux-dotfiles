#!/bin/bash

# Pacman
echo "Updating the system and installing essential packages..."
sudo pacman -Syy --noconfirm
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm --needed \
    base-devel \
    git \
    curl \
    wget \
    cmake \
    make \
    unzip

sudo pacman -S --noconfirm \
    ghostty \
    fastfetch \
    mission-center \
    steam \
    discord \
    obs-studio \
    solaar \
    openrgb

## ======================================================= ##

# Flatpak
echo "Installing Flatpak and the GNOME Software plugin for Flatpak..."
sudo pacman -S flatpak --noconfirm \
    flatseal

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Installing applications from Flathub using Flatpak..."
flatpak install -y \
    com.rtosta.zapzap \
    org.onlyoffice.desktopeditors \
    sh.ppy.osu