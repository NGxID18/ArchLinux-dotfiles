#!/bin/bash

echo "Mengatur konfigurasi Fastfetch dan Ghostty..."

mkdir -p ~/.config/fastfetch
mkdir -p ~/.config/ghostty

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Menautkan konfigurasi Fastfetch..."
ln -sf "$DOTFILES_DIR/.config/fastfetch/config.jsonc" ~/.config/fastfetch/config.jsonc

echo "Menautkan konfigurasi Ghostty..."
ln -sf "$DOTFILES_DIR/.config/ghostty/config.ghostty" ~/.config/ghostty/config

echo "Menerapkan konfigurasi GNOME Extensions (dconf)..."
dconf load /org/gnome/shell/extensions/ < "$DOTFILES_DIR/.config/dconf/gnome-extensions.dconf"

echo "Konfigurasi berhasil diterapkan!"