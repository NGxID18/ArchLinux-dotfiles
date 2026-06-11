#!/bin/bash

echo "Starting configuration setup..."

mkdir -p ~/.config/fastfetch
mkdir -p ~/.config/ghostty

echo "Linking Fastfetch configuration ..."
ln -sf "~/Archlinux-dotfiles/config/fastfetch/config.jsonc" ~/.config/fastfetch/config.jsonc

echo "Linking Ghostty configuration..."
ln -sf "~/Archlinux-dotfiles/config/ghostty/config.ghostty" ~/.config/ghostty/config

echo "Applying GNOME Extensions configuration using dconf..."
dconf load /org/gnome/shell/extensions/ < "Archlinux-dotfiles/config/dconf/gnome-extensions.dconf"

echo "Configuration applied successfully!"