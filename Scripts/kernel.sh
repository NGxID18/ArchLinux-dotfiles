#!/bin/bash

echo "Installing CachyOS Repository and Kernel..."
curl -O https://mirror.cachyos.org/cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz
cd cachyos-repo
sudo ./cachyos-repo.sh

sudo pacman -S \
    linux-cachyos-bore \
    linux-cachyos-bore-headers

sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo pacman -Syyu
sudo pacman -S --noconfirm \
    bash \
    mkinitcpio \
    nodejs

sudo pacman -Scc
sudo rm -rf /etc/pacman.d/gnupg
sudo pacman-key --init
sudo pacman-key --populate archlinux cachyos
sudo pacman -Sy archlinux-keyring cachyos-keyring
sudo pacman -Syyu
paru -Syyu