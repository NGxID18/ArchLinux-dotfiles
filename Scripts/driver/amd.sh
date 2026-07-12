#!/bin/bash

AMD_PKGS="mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon xf86-video-amdgpu xf86-video-ati"

if [[ "$AMD_ROCM" =~ ^[Yy]$ ]]; then
    echo "Info: Adding AMD ROCm to installation list."
    AMD_PKGS="$AMD_PKGS rocm-hip-sdk rocm-opencl-runtime"
fi

echo "Installing AMD Drivers and Tools..."
sudo pacman -S --noconfirm --needed $AMD_PKGS