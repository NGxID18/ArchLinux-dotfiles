#!/bin/bash

## Gnome Installation, Customization & Extensions ##

echo "Installing GNOME Desktop Environment..."
sudo pacman -S --needed --noconfirm \
    gnome \
    gnome-tweaks \
    xdg-utils \
    nano

echo "Removing unnecessary GNOME applications (if they exist)..."
sudo pacman -Rns --noconfirm \
    epiphany \
    gnome-characters \
    gnome-contacts \
    gnome-maps \
    gnome-weather \
    gnome-clocks \
    gnome-music \
    gnome-tour \
    gnome-console \
    gnome-user-docs \
    yelp \
    htop \
    vim || true

echo "Installing GNOME Tweaks and Extension Manager..."
sudo pacman -S --noconfirm \
    gnome-tweaks \
    extension-manager

echo "Installing GNOME Extensions via Paru..."
paru -S --noconfirm \
    gnome-shell-extension-appindicator \
    gnome-shell-extension-blur-my-shell \
    gnome-shell-extension-vitals

echo "Enabling GNOME Extensions via gsettings..."
gsettings set org.gnome.shell disable-user-extensions false
gsettings set org.gnome.shell enabled-extensions "['appindicatorsupport@rgcjonas.gmail.com', 'blur-my-shell@aunetx', 'Vitals@CoreCoding.com']"

echo "GNOME Setup completed!"