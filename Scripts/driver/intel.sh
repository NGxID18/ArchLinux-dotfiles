#!/bin/bash

echo "Installing AMD Drivers and Tools..."
sudo pacman -S --noconfirm \
    mesa \
    vulkan-intel \
    lib32-mesa \
    lib32-vulkan-intel \
    libva-intel-driver \
    intel-media-driver