#!/bin/bash
set -e

## ======================================================= ##
# SDDM & Sugar Candy Theme
## ======================================================= ##

echo "Installing SDDM and Qt5 dependencies..."
sudo pacman -S --needed --noconfirm \
    sddm \
    qt5-graphicaleffects \
    qt5-quickcontrols2 \
    qt5-svg

echo "Installing Sugar Candy theme via Paru..."
paru -S --needed --noconfirm sddm-sugar-candy-git

if [ -f "/usr/share/sddm/themes/sugar-candy/theme.conf" ]; then
    echo "Applying Custom Background to Sugar Candy..."
    sudo sed -i 's|^Background=.*|Background="/usr/share/backgrounds/Wallpapers/KQART.png"|' /usr/share/sddm/themes/sugar-candy/theme.conf
fi

echo "Applying SDDM theme configuration..."
sudo mkdir -p /etc/sddm.conf.d
if [ -f "$REPO_DIR/config/sddm/sddm.conf" ]; then
    sudo cp "$REPO_DIR/config/sddm/sddm.conf" /etc/sddm.conf.d/sddm.conf
fi

echo "Configuring Display Manager service..."
sudo systemctl disable gdm.service 2>/dev/null || true
sudo systemctl enable sddm.service

echo "SDDM Setup completed!"