#!/bin/bash

echo "Removing unnecessary GNOME applications..."
sudo pacman -Rns --noconfirm \
    epiphany \
    gnome-characters \
    gnome-contacts \
    gnome-maps \
    gnome-weather \
    gnome-clocks \
    gnome-music \
    gnome-tour \
    gnome-user-docs \
    yelp \
    vim

echo "Installing GNOME Tweaks and Extension Manager..."
sudo pacman -S --noconfirm \
    gnome-tweaks \
    extension-manager