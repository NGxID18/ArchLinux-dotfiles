#!/bin/bash

## Gnome Debloat, Customization & Extensions ##

echo "Removing unnecessary GNOME applications..."
sudo pacman -Rns \
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
    vim

echo "Installing GNOME Tweaks and Extension Manager..."
sudo pacman -S \
    gnome-tweaks \
    extension-manager

echo "Installing GNOME Extensions via Paru..."
paru -S \
    gnome-shell-extension-appindicator \
    gnome-shell-extension-blur-my-shell \
    gnome-shell-extension-vitals

echo "Enabling GNOME Extensions via gsettings..."
gsettings set org.gnome.shell disable-user-extensions false
gsettings set org.gnome.shell enabled-extensions "['appindicatorsupport@rgcjonas.gmail.com', 'blur-my-shell@aunetx', 'Vitals@CoreCoding.com']"

echo "GNOME Setup completed!"