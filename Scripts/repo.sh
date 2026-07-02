#!/bin/bash

echo "Updating the system..."
sudo pacman -Syyu --noconfirm

echo "Installing essential build packages..."
sudo pacman -S --noconfirm --needed base-devel git curl

## ======================================================= ##

echo "Installing Paru AUR helper..."
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd ..
rm -rf paru

echo "Updating the system with Paru..."
paru -Syyu --noconfirm

## ======================================================= ##

echo "Installing Flatpak and Flatseal..."
sudo pacman -S --noconfirm flatpak flatseal

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
