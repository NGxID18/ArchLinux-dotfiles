#!/bin/bash
set -e

## ======================================================= ##
# GNOME Desktop Environment
## ======================================================= ##

echo "Installing GNOME Desktop Environment..."
sudo pacman -S --needed --noconfirm \
    gnome \
    gnome-tweaks \
    extension-manager \
    nano

echo "Removing unnecessary GNOME default applications..."
BLOATWARES=(
    epiphany
    gnome-characters
    gnome-contacts
    gnome-calendar
    gnome-maps
    gnome-weather
    gnome-clocks
    gnome-music
    gnome-tour
    gnome-console
    gnome-user-docs
    snapshot
    yelp
)

for pkg in "${BLOATWARES[@]}"; do
    if pacman -Qq "$pkg" >/dev/null 2>&1; then
        echo "Removing $pkg..."
        sudo pacman -Rns --noconfirm "$pkg" || true
    fi
done

echo "Installing GNOME Extensions..."
paru -S --needed --noconfirm \
    gnome-shell-extension-appindicator \
    gnome-shell-extension-blur-my-shell \
    gnome-shell-extension-vitals

echo "Enabling GNOME Extensions via gsettings..."
# Apply gsettings safely even if running without an active graphical session
gsettings set org.gnome.shell disable-user-extensions false 2>/dev/null || true
gsettings set org.gnome.shell enabled-extensions "['appindicatorsupport@rgcjonas.gmail.com', 'blur-my-shell@aunetx', 'Vitals@CoreCoding.com']" 2>/dev/null || true

echo "GNOME Setup completed!"
