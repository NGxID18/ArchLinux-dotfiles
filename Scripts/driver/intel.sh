#!/bin/bash

INTEL_PKGS="mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver libva-intel-driver"

if [[ "$INTEL_COMPUTE" =~ ^[Yy]$ ]]; then
    echo "Info: Adding Intel Compute Runtime to installation list."
    INTEL_PKGS="$INTEL_PKGS intel-compute-runtime clinfo"
fi

echo "Installing Intel Drivers and Tools..."
sudo pacman -S --noconfirm --needed $INTEL_PKGS