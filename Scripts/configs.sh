#!/bin/bash

echo "Starting configuration setup..."

mkdir -p ~/.config/fastfetch
mkdir -p ~/.config/ghostty

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Linking Fastfetch configuration ..."
ln -sf "$DOTFILES_DIR/.config/fastfetch/config.jsonc" ~/.config/fastfetch/config.jsonc

echo "Linking Ghostty configuration..."
ln -sf "$DOTFILES_DIR/.config/ghostty/config.ghostty" ~/.config/ghostty/config

echo "Applying GNOME Extensions configuration using dconf..."
dconf load /org/gnome/shell/extensions/ < "$DOTFILES_DIR/.config/dconf/gnome-extensions.dconf"

echo "Applying SDDM configuration..."
sudo mkdir -p /usr/share/sddm/themes
sudo mkdir -p /etc/sddm.conf.d

sudo cp -r "$DOTFILES_DIR/System/sddm/themes/Sugar-Candy" /usr/share/sddm/themes/
sudo cp "$DOTFILES_DIR/System/sddm/sddm.conf" /etc/sddm.conf.d/custom.conf

echo "Configuration applied successfully!"