#!/bin/bash

echo "Starting configuration setup..."

mkdir -p "$HOME/.config/fastfetch"
mkdir -p "$HOME/.config/ghostty"

echo "Linking Fastfetch configuration ..."
ln -sf "$HOME/ArchLinux-dotfiles/config/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"

echo "Linking Ghostty configuration..."
ln -sf "$HOME/ArchLinux-dotfiles/config/ghostty/config" "$HOME/.config/ghostty/config"

# Meload settingan gnome extension dari file dconf yang kamu miliki
if [ -f "$HOME/ArchLinux-dotfiles/config/dconf/gnome-extensions.dconf" ]; then
    echo "Applying GNOME Extensions configuration from dconf..."
    dconf load /org/gnome/shell/extensions/ < "$HOME/ArchLinux-dotfiles/config/dconf/gnome-extensions.dconf"
fi

echo "Configuration applied successfully!"