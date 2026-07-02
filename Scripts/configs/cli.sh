#!/bin/bash

## ======================================================= ##

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

if [ -f "$REPO_DIR/config/.zshrc" ]; then
    echo "Copying Shell configuration..."
    rm -f ~/.zshrc
    cp "$REPO_DIR/config/.zshrc" "$HOME/"
fi

## ======================================================= ##