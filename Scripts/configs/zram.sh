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