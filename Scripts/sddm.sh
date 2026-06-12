#!/bin/bash

echo "Installing SDDM and Qt5 dependencies..."
sudo pacman -S \
    sddm \
    qt5-graphicaleffects \
    qt5-quickcontrols2 \
    qt5-svg

echo "Installing Sugar Candy theme via Paru..."
paru -S sddm-sugar-candy-git

echo "Configuring Display Manager..."
sudo systemctl disable gdm.service 2>/dev/null || true
sudo systemctl enable sddm.service

echo "SDDM Setup completed!"