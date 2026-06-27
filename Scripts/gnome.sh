#!/bin/bash

echo "Installing GNOME Desktop Environment..."
sudo pacman -S --needed --noconfirm \
    gnome \
    gnome-tweaks \
    extension-manager \
    nano

echo "Removing unnecessary GNOME applications"
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
        sudo pacman -Rns --noconfirm "$pkg"
    fi
done

echo "Installing GNOME Extensions via Paru..."
paru -S --noconfirm \
    gnome-shell-extension-appindicator \
    gnome-shell-extension-blur-my-shell \
    gnome-shell-extension-vitals

echo "Enabling GNOME Extensions via gsettings..."
gsettings set org.gnome.shell disable-user-extensions false
gsettings set org.gnome.shell enabled-extensions "['appindicatorsupport@rgcjonas.gmail.com', 'blur-my-shell@aunetx', 'Vitals@CoreCoding.com']"

## ======================================================= ##

echo "Applying GNOME User Config and Extensions"

if [ -f "config/dconf/gnome-settings.dconf" ]; then
    echo "Loading GNOME dconf Settings"
    dconf load /org/gnome/ < "./config/dconf/gnome-settings.dconf"
fi

echo "GNOME Setup completed!"
