#!/bin/bash

echo "Applying application configurations..."

REPO_DIR=~/ArchLinux-dotfiles
USER_CONFIG_DIR=~/.config

mkdir -p "$USER_CONFIG_DIR"

if [ -d "$REPO_DIR/config/ghostty" ]; then
    echo "Copying Ghostty configuration..."
    rm -rf "$USER_CONFIG_DIR/ghostty"
    cp -r "$REPO_DIR/config/ghostty" "$USER_CONFIG_DIR/"
fi

if [ -d "$REPO_DIR/config/fastfetch" ]; then
    echo "Copying Fastfetch configuration..."
    rm -rf "$USER_CONFIG_DIR/fastfetch"
    cp -r "$REPO_DIR/config/fastfetch" "$USER_CONFIG_DIR/"
fi

if [ -f "$REPO_DIR/config/dconf/gnome-extensions.dconf" ]; then
    echo "Loading GNOME dconf settings..."
    dconf load / < "$REPO_DIR/config/dconf/gnome-extensions.dconf"
fi

echo "User configurations copied successfully!"
