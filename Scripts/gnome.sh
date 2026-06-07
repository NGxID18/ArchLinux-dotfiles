#!/bin/bash

echo "Installing GNOME Tweaks and Extension Manager..."
pacman -S --noconfirm \
    gnome-tweaks \
    extension-manager

echo "Installing GNOME Extensions via AUR/Pacman..."
paru -S --noconfirm \
    gnome-shell-extension-appindicator \
    gnome-shell-extension-blur-my-shell \
    gnome-shell-extension-vitals

echo "Enabling GNOME Extensions..."
gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
gnome-extensions enable blur-my-shell@aunetx
gnome-extensions enable Vitals@CoreCoding.com