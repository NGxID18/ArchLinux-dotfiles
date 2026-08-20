#!/bin/bash

echo -e "\n==================================================="
echo "       ARCH LINUX DOTFILES INSTALLATION MENU       "
echo "==================================================="

# --- 1. DRIVER GPU ---
echo -e "\n[1/5] Select Your GPU :"
echo " 1) NVIDIA"
echo " 2) AMD"
echo " 3) Intel"
echo " 4) Skip GPU Driver Installation"
read -p "[1-4] : " GPU_CHOICE

if [ "$GPU_CHOICE" == "1" ]; then
    echo -e "\n Choose NVIDIA Driver:"
    echo " 1) Proprietary (nvidia-dkms) - For Pascal GPU (GTX 10xx) and older"
    echo " 2) Open Kernel Module (nvidia-open-dkms) - Recommended for Turing GPU (GTX 16xx) and newer"
    echo " 3) Nouveau (Open Source Linux Kernel) - Community Based"
    read -p "[1-3] : " NVD_TYPE

    if [ "$NVD_TYPE" != "3" ]; then
        echo -e "\nDo you want to install CUDA & cuDNN? (y/N)"
        read -p ": " NVD_CUDA

        echo -e "\nApply limit maximum clock at 2400MHz? (~100W full load on RTX 5060) (y/N)"
        read -p ": " NVD_TUNE
    fi
elif [ "$GPU_CHOICE" == "2" ]; then
    echo -e "\nDo you want to install AMD ROCm? (y/N)"
    read -p ": " AMD_ROCM
elif [ "$GPU_CHOICE" == "3" ]; then
    echo -e "\nDo you want to install Intel Compute Runtime? (y/N)"
    read -p ": " INTEL_COMPUTE
fi

# --- 2. GUI: DE ---
echo -e "\n[2/5] Do you want to install GNOME Desktop Environment? (Y/n)"
read -p ": " INSTALL_GUI
INSTALL_GUI=${INSTALL_GUI:-Y}

# --- 3. SESSION MANAGER ---
echo -e "\n[3/5] Do you want to install SDDM & Sugar Candy Theme? (Y/n)"
read -p ": " INSTALL_DM
INSTALL_DM=${INSTALL_DM:-Y}

# --- 4. APPLICATIONS ---
echo -e "\n[4/5] Do you want to install Applications (Kitty, Zsh, Librewolf, Antigravity, Discord, Cockpit, etc)? (Y/n)"
read -p ": " INSTALL_APPS
INSTALL_APPS=${INSTALL_APPS:-Y}

if [[ "$INSTALL_APPS" =~ ^[Yy]$ ]]; then
    echo -e "\n   Do you also want to install Additional Apps (Android Tools, Scrcpy, OBS, ProtonUp-Qt)? (y/N)"
    read -p "   : " INSTALL_ADDONS
    INSTALL_ADDONS=${INSTALL_ADDONS:-N}

    echo -e "\n   Do you also want to install Cockpit & Btrfs Manager? (y/N)"
    read -p "   : " INSTALL_COCKPIT
    INSTALL_COCKPIT=${INSTALL_COCKPIT:-N}
fi

# --- 5. USER CONFIGS ---
echo -e "\n[5/5] Do you want to apply CLI Configurations (Zsh, Kitty, Fastfetch)? (Y/n)"
read -p ": " INSTALL_CLI
INSTALL_CLI=${INSTALL_CLI:-Y}

if [[ "$INSTALL_CLI" =~ ^[Yy]$ ]]; then
    echo -e "\n   Do you also want to apply zRAM configuration? (y/N)"
    read -p "   : " INSTALL_ZRAM
    INSTALL_ZRAM=${INSTALL_ZRAM:-N}
fi

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
USER_CONFIG_DIR="$HOME/.config"

mkdir -p "$USER_CONFIG_DIR"

echo -e "\n==================================================="
echo " All inputs recorded. Starting automated installation..."
echo "==================================================="
sleep 2

export GPU_CHOICE NVD_TYPE NVD_CUDA NVD_TUNE AMD_ROCM INTEL_COMPUTE
export INSTALL_GUI INSTALL_DM INSTALL_APPS INSTALL_ADDONS INSTALL_COCKPIT
export REPO_DIR USER_CONFIG_DIR INSTALL_CLI INSTALL_ZRAM


