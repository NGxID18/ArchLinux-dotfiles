#!/bin/bash

echo "Starting configuration setup..."

mkdir -p "$HOME/.config/fastfetch"
mkdir -p "$HOME/.config/ghostty"

echo "Linking Fastfetch configuration ..."
ln -sf "$HOME/ArchLinux-dotfiles/config/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"

echo "Linking Ghostty configuration..."
ln -sf "$HOME/ArchLinux-dotfiles/config/ghostty/config" "$HOME/.config/ghostty/config"

echo "Applying GNOME Extensions configuration from dconf..."
if [ -f "$HOME/ArchLinux-dotfiles/config/dconf/gnome-extensions.dconf" ]; then
    echo "Applying GNOME Extensions configuration from dconf..."
    dconf load /org/gnome/shell/extensions/ < "$HOME/ArchLinux-dotfiles/config/dconf/gnome-extensions.dconf"
fi

echo "Applying SDDM theme configuration..."
sudo mkdir -p /etc/sddm.conf.d
sudo cp "$HOME/ArchLinux-dotfiles/config/sddm/sddm.conf" /etc/sddm.conf.d/theme.conf

echo "Configuration applied successfully!"