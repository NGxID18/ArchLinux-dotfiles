#!/bin/bash
set -e

## ======================================================= ##
# User CLI Configurations (Zsh, Kitty, Fastfetch)
## ======================================================= ##

echo "Configuring Shell, Terminal & Fastfetch..."

TARGET_USER="${SUDO_USER:-${USER:-$(id -un)}}"
USER_CONFIG_DIR="${USER_CONFIG_DIR:-$HOME/.config}"
mkdir -p "$USER_CONFIG_DIR"

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

if [ -f "$REPO_DIR/config/.zshrc" ]; then
    echo "Copying Shell configuration..."
    rm -f "$HOME/.zshrc"
    cp "$REPO_DIR/config/.zshrc" "$HOME/.zshrc"
fi

if command -v zsh >/dev/null 2>&1; then
    echo "Setting default shell to Zsh for user $TARGET_USER..."
    sudo chsh -s /usr/bin/zsh "$TARGET_USER"
fi