#!/bin/bash
set -e

## ======================================================= ##
# Repositories & System Update
## ======================================================= ##

# Enable multilib repository if not already enabled (required for 32-bit libs/drivers)
if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
    echo "Enabling multilib repository in /etc/pacman.conf..."
    sudo sed -i '/^#\[multilib\]/{s/^#//;n;s/^#//}' /etc/pacman.conf
fi

echo "Updating system package databases..."
sudo pacman -Syu --noconfirm

echo "Installing essential build packages..."
sudo pacman -S --needed --noconfirm base-devel git curl

## ======================================================= ##
# Paru AUR Helper
## ======================================================= ##

if ! command -v paru &>/dev/null; then
    echo "Installing Paru AUR helper..."
    PARU_BUILD_DIR="$(mktemp -d /tmp/paru-build.XXXXXX)"
    git clone https://aur.archlinux.org/paru.git "$PARU_BUILD_DIR"
    (
        cd "$PARU_BUILD_DIR"
        makepkg -si --noconfirm
    )
    rm -rf "$PARU_BUILD_DIR"
else
    echo "Paru AUR helper is already installed."
fi

echo "Updating AUR packages..."
paru -Sua --noconfirm

## ======================================================= ##
# Flatpak & Flathub
## ======================================================= ##

echo "Installing Flatpak and Flatseal..."
sudo pacman -S --needed --noconfirm flatpak flatseal

echo "Adding Flathub remote..."
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
