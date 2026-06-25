#!/bin/bash

echo "Installing AMD Drivers and Tools..."
sudo pacman -S --noconfirm \
    linux-zen-headers \
    dkms \
    mesa \
    vulkan-radeon \
    lib32-mesa \
    lib32-vulkan-radeon \
    xf86-video-amdgpu \
    xf86-video-ati