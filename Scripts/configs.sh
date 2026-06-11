#!/bin/bash

echo "Starting configuration setup..."

mkdir -p ~/.config/fastfetch
mkdir -p ~/.config/ghostty
fastfetch --gen-config

echo "Linking Fastfetch configuration ..."
ln -sf "~/Archlinux-dotfiles/config/fastfetch/config.jsonc" ~/.config/fastfetch/config.jsonc

echo "Linking Ghostty configuration..."
ln -sf "~/Archlinux-dotfiles/config/ghostty/config" ~/.config/ghostty/config

echo "Configuration applied successfully!"