#!/bin/bash

echo "Installing Docker..."
pacman -S --noconfirm \
    docker \
    docker-compose

sudo systemctl enable --now docker.service

## ======================================================= ##

echo "Installing Cockpit Dependencies and Deployment"
pacman -S --noconfirm \
    cockpit \
    cockpit-storaged

paru -S --noconfirm \
    cockpit-dockermanager \
    cockpit-pacman

sudo systemctl enable --now cockpit.socket

### ======================================================= ##

echo "Installing BTRFS Dependencies"
pacman -S --noconfirm \
    udisk2 \
    udisk2-btrfs \
    btrfs-progs \
    snapper \
    cronie

sudo git clone https://github.com/NGxID18/btrfs-manager /usr/share/cockpit/btrfs-manager