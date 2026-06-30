#!/bin/bash

AMD_PKGS="mesa lib32-mesa xf86-video-amdgpu xf86-video-ati"

if [ "$AMD_TYPE" == "2" ]; then
    echo "Info: Using AMDVLK driver."
    AMD_PKGS="$AMD_PKGS amdvlk lib32-amdvlk"
else
    echo "Info: Using RADV driver."
    AMD_PKGS="$AMD_PKGS vulkan-radeon lib32-vulkan-radeon"
fi

if [[ "$AMD_ROCM" =~ ^[Yy]$ ]]; then
    echo "Info: Adding AMD ROCm to installation list."
    AMD_PKGS="$AMD_PKGS rocm-hip-sdk rocm-opencl-runtime"
fi

echo "Installing AMD Drivers and Tools..."
sudo pacman -S --noconfirm --needed $AMD_PKGS