#!/bin/bash

# Pacman
// Update the system and install essential packages
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

## ======================================================= ##

# Paru
// Install Paru AUR helper
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd ..
rm -rf paru

// Install applications from the AUR using Paru
paru -S --noconfirm --needed \
    visual-studio-code-bin \
    google-chrome \
    discord \
    zoom \

## ======================================================= ##

# Flatpak
// Install Flatpak and the GNOME Software plugin for Flatpak
pacman -S flatpak --noconfirm --needed \
    gnome-software-plugin-flatpak \

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub -y \

// Install applications from Flathub using Flatpak
flatpak install -y \
    com.rtosta.zapzap \
    org.onlyoffice.desktopeditors \
    sh.ppy.osu \