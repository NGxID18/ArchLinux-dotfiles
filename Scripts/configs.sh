#!/bin/bash

echo "Applying application configurations..."

REPO_DIR=~/ArchLinux-dotfiles
USER_CONFIG_DIR=~/.config

mkdir -p "$USER_CONFIG_DIR"

if [ -d "$REPO_DIR/config/kitty" ]; then
    echo "Copying Kitty configuration..."
    rm -rf "$USER_CONFIG_DIR/kitty"
    cp -r "$REPO_DIR/config/kitty" "$USER_CONFIG_DIR/"
fi

if [ -d "$REPO_DIR/config/fastfetch" ]; then
    echo "Copying Fastfetch configuration..."
    rm -rf "$USER_CONFIG_DIR/fastfetch"
    cp -r "$REPO_DIR/config/fastfetch" "$USER_CONFIG_DIR/"
fi

if [ -d "$REPO_DIR/config/autostart" ]; then
    echo "Copying autostart configuration..."
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

export CUDA_HOME=/usr/local/cuda
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

bindkey "^[[3~" delete-char

EOF

echo "Zsh setup completed! Changes will take effect after restart or re-login."

echo "Configuring zRAM size to 16384 MB..."
sudo tee /etc/systemd/zram-generator.conf > /dev/null <<EOF
[zram0]
zram-size = 16384
compression-algorithm = zstd
swap-priority = 100
EOF

echo "Applying zRAM configuration..."
sudo systemctl daemon-reload
sudo systemctl restart systemd-zram-setup@zram0.service

echo "zRAM setup completed!"

echo "User configurations copied successfully!"
