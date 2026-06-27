#!/bin/bash

## ======================================================= ##

echo "Configuring zRAM size to 16384 MB..."
sudo tee /etc/systemd/zram-generator.conf > /dev/null <<EOF
[zram0]
zram-size = 16384
compression-algorithm = zstd
swap-priority = 100
EOF

sudo systemctl daemon-reload
sudo systemctl restart systemd-zram-setup@zram0.service

## ======================================================= ##

REPO_DIR=~/ArchLinux-dotfiles
USER_CONFIG_DIR=~/.config

mkdir -p "$USER_CONFIG_DIR"

echo "Applying application configurations..."

if [ -d "$REPO_DIR/config/autostart" ]; then
    echo "Copying Autostart configuration..."
    rm -rf "$USER_CONFIG_DIR/autostart"
    cp -r "$REPO_DIR/config/autostart" "$USER_CONFIG_DIR/"
fi

if [ -d "$REPO_DIR/config/OpenRGB" ]; then
    echo "Copying OpenRGB configuration..."
    rm -rf "$USER_CONFIG_DIR/OpenRGB"
    cp -r "$REPO_DIR/config/OpenRGB" "$USER_CONFIG_DIR/"
fi

if [ -d "$REPO_DIR/config/solaar" ]; then
    echo "Copying Solaar configuration..."
    rm -rf "$USER_CONFIG_DIR/solaar"
    cp -r "$REPO_DIR/config/solaar" "$USER_CONFIG_DIR/"
fi

echo "Configuring Shell, Terminal & Fastfetch"

if [ -d "$REPO_DIR/config/fastfetch" ]; then
    echo "Copying Fastfetch configuration..."
    rm -rf "$USER_CONFIG_DIR/fastfetch"
    cp -r "$REPO_DIR/config/fastfetch" "$USER_CONFIG_DIR/"
fi

if [ -d "$REPO_DIR/config/kitty" ]; then
    echo "Copying Kitty configuration..."
    rm -rf "$USER_CONFIG_DIR/kitty"
    cp -r "$REPO_DIR/config/kitty" "$USER_CONFIG_DIR/"
fi

sudo chsh -s /usr/bin/zsh "$USER"

if [ -d "$REPO_DIR/config/.zshrc" ]; then
    echo "Copying Shell configuration..."
    rm -f "~/.zshrc"
    cp "$REPO_DIR/config/.zshrc" "~/"
fi

source ~/.zshrc

## ======================================================= ##

echo "Configuration applied successfully!"
