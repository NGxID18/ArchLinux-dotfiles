#!/bin/bash

echo "Installing SDDM and Qt5 dependencies..."
sudo pacman -S --noconfirm \
    sddm \
    qt5-graphicaleffects \
    qt5-quickcontrols2 \
    qt5-svg

echo "Installing Sugar Candy theme via Paru..."
paru -S --noconfirm sddm-sugar-candy-git

echo "Applying Custom Background to Sugar Candy..."
sudo sed -i 's|^Background=.*|Background="/usr/share/backgrounds/Wallpapers/KQART.png"|' /usr/share/sddm/themes/sugar-candy/theme.conf
sudo mkdir -p /etc/sddm.conf.d
sudo cp -r ~/ArchLinux-dotfiles/config/sddm/sddm.conf /etc/sddm.conf.d/

echo "Configuring Display Manager..."
sudo systemctl disable gdm.service 2>/dev/null || true
sudo systemctl enable sddm.service

echo "SDDM Setup completed!"