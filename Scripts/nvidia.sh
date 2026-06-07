#!/bin/bash

echo "Installing NVIDIA Drivers and Tools..."
pacman -S --noconfirm \
    nvidia-utils \
    nvidia-settings \
    cuda \