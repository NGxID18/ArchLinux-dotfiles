#!/bin/bash

echo -e "\nDetecting Installed Kernel..."
KERNEL_HEADERS="dkms"

if pacman -Qq linux &>/dev/null; then
    echo "-> Found basic kernel (linux)"
    KERNEL_HEADERS="$KERNEL_HEADERS linux-headers"
fi

if pacman -Qq linux-zen &>/dev/null; then
    echo "-> Found Zen kernel (linux-zen)"
    KERNEL_HEADERS="$KERNEL_HEADERS linux-zen-headers"
fi

if pacman -Qq linux-lts &>/dev/null; then
    echo "-> Found LTS kernel (linux-lts)"
    KERNEL_HEADERS="$KERNEL_HEADERS linux-lts-headers"
fi

if pacman -Qq linux-hardened &>/dev/null; then
    echo "-> Found Hardened kernel (linux-hardened)"
    KERNEL_HEADERS="$KERNEL_HEADERS linux-hardened-headers"
fi

NVD_PKGS="$KERNEL_HEADERS"

if [ "$NVD_TYPE" == "3" ]; then
    echo "Info: Using nouveau driver."
    NVD_PKGS="$NVD_PKGS mesa xf86-video-nouveau"
else
    NVD_SUPPORT="nvidia-utils lib32-nvidia-utils libva-nvidia-driver nvidia-settings"
    
    if [ "$NVD_TYPE" == "2" ]; then
        NVD_PKGS="$NVD_PKGS nvidia-open-dkms $NVD_SUPPORT"
    else
        NVD_PKGS="$NVD_PKGS nvidia-dkms $NVD_SUPPORT"
    fi

    if [[ "$NVD_CUDA" =~ ^[Yy]$ ]]; then
        echo "Info: Adding CUDA & cuDNN to installation list."
        NVD_PKGS="$NVD_PKGS cuda cudnn"
    fi
fi

echo -e "\nInstalling Drivers"
sudo pacman -S --noconfirm --needed $NVD_PKGS

if [ "$NVD_TYPE" != "3" ]; then
    echo "Enabling nvidia-persistenced service..."
    sudo systemctl enable nvidia-persistenced.service
fi