#!/bin/bash

echo "Installing CachyOS Repository and Kernel..."
curl -O https://mirror.cachyos.org/cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz
cd cachyos-repo
sudo ./cachyos-repo.sh

sudo pacman -S \
    linux-cachyos-bore \
    linux-cachyos-bore-headers

sudo pacman -S --noconfirm \
    bash \
    mkinitcpio \
    nodejs