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

echo "Changing default shell to Zsh for user: $USER..."
sudo chsh -s /usr/bin/zsh "$USER"

echo "Creating .zshrc configuration..."
cat << 'EOF' > ~/.zshrc
autoload -Uz compinit
compinit

PROMPT='%F{cyan}%~%f> '

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
EOF

echo "Zsh setup completed! Changes will take effect after restart or re-login."

echo "User configurations copied successfully!"
