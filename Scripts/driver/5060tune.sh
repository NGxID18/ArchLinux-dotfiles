#!/bin/bash
set -e

echo "Creating 5060tune service for NVIDIA Power & Clock Limit..."
sudo tee /etc/systemd/system/5060tune.service > /dev/null <<EOF
[Unit]
Description=5060tune NVIDIA GPU Power and Clock Limit
After=nvidia-persistenced.service
Requires=nvidia-persistenced.service

[Service]
Type=oneshot
ExecStart=/usr/bin/nvidia-smi -pl 123
ExecStart=/usr/bin/nvidia-smi -lgc 210,2400
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

echo "Enabling 5060tune service..."
sudo systemctl enable 5060tune.service
echo "5060tune service applied successfully."