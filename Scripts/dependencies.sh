#!/bin/bash

# Pacman
echo "Updating the system and installing essential packages..."
pacman -Syy --noconfirm
pacman -Syu --noconfirm
pacman -S --noconfirm --needed \
    base-devel \
    git \
    curl \
    wget \
    cmake \
    make \
    unzip \

pacman -S --noconfirm \
    ghostty \
    fastfetch \
    mission-center \
    steam \
    discord \
    obs-studio \
    solaar \
    openrgb \
    
## ======================================================= ##

# Paru
echo "Installing Paru AUR helper..."
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd ..
rm -rf paru

echo "Installing applications from the AUR using Paru..."
paru -S --noconfirm \
    visual-studio-code-bin \
    google-chrome \
    zoom \

## ======================================================= ##

# Flatpak
echo "Installing Flatpak and the GNOME Software plugin for Flatpak..."
pacman -S flatpak --noconfirm \
    gnome-software-plugin-flatpak \
    flatseal \

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub -y \

echo "Installing applications from Flathub using Flatpak..."
flatpak install -y \
    com.rtosta.zapzap \
    org.onlyoffice.desktopeditors \
    sh.ppy.osu \