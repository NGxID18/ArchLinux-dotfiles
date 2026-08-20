#!/bin/bash

## ======================================================= ##

echo "Installing zram-generator..."
sudo pacman -S --needed --noconfirm zram-generator

echo "Configuring zRAM size to 32768 MB..."
sudo tee /etc/systemd/zram-generator.conf > /dev/null <<EOF
[zram0]
zram-size = 32768
compression-algorithm = zstd
swap-priority = 100
EOF

sudo systemctl daemon-reload
sudo systemctl restart systemd-zram-setup@zram0.service

## ======================================================= ##