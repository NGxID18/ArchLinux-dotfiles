#!/bin/bash

echo "Input sudo password to start installation"
sudo -v

while true; do sudo -n -v; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

cd "$(dirname "$0")"

echo "Permission set to executable for all scripts."
find Scripts -type f -name "*.sh" -exec chmod +x {} +

# ======================================================= #
# --- MEMUAT INPUT USER (INTERAKTIF) ---
# ======================================================= #

if [ -f "Scripts/setup.sh" ]; then
    source Scripts/setup.sh
else
    echo -e "\n ERROR: Scripts/setup.sh tidak ditemukan!"
    exit 1
fi

# ======================================================= #
# --- EXECUTE INSTALLATION ---
# ======================================================= #

run_script() {
    echo -e "\n==================================================="
    echo " Running  : $1"
    echo "==================================================="
    
    ./"$1"
    
    if [ $? -ne 0 ]; then
        echo -e "\n ERROR   : Failed to execute $1."
        echo "Process installation stopped to prevent system damage."
        exit 1
    else
        echo " $1 Succeeded."
    fi
}

# Setup Backgrounds
sudo mkdir -p /usr/share/backgrounds/
sudo cp -r "Wallpapers" /usr/share/backgrounds/
sudo chmod -R 755 /usr/share/backgrounds/Wallpapers/

# Repository & AUR Helper
run_script "Scripts/repo.sh"

# Install GPU Driver
case $GPU_CHOICE in
    1)
        run_script "Scripts/driver/nvidia.sh"
        if [[ "$NVD_TUNE" =~ ^[Yy]$ ]]; then
            run_script "Scripts/driver/5060tune.sh"
        fi
        ;;
    2)
        run_script "Scripts/driver/amd.sh"
        ;;
    3)
        run_script "Scripts/driver/intel.sh"
        ;;
    4)
        echo -e "\n Info : GPU Driver Installation Skipped."
        ;;
esac

# Desktop Environment
if [[ "$INSTALL_GUI" =~ ^[Yy]$ ]]; then
    run_script "Scripts/GUI/DE/gnome.sh"
fi

# Session / Login Manager
if [[ "$INSTALL_DM" =~ ^[Yy]$ ]]; then
    run_script "Scripts/session/sddm.sh"
fi

# Applications
if [[ "$INSTALL_APPS" =~ ^[Yy]$ ]]; then
    run_script "Scripts/apps/apps.sh"
    if [[ "$INSTALL_SERVER_TOOLS" =~ ^[Yy]$ ]]; then
        run_script "Scripts/apps/server.sh"
    fi
fi

# User Configs
if [[ "$INSTALL_CLI" =~ ^[Yy]$ ]]; then
    run_script "Scripts/configs/cli.sh"
    if [[ "$INSTALL_ZRAM" =~ ^[Yy]$ ]]; then
        run_script "Scripts/configs/zram.sh"
    fi
    if [[ "$INSTALL_PERIPHERAL" =~ ^[Yy]$ ]]; then
        run_script "Scripts/configs/peripheral.sh"
    fi
fi

# Cleanup Repo
rm -rf ~/ArchLinux-dotfiles

echo -e "\n All scripts executed successfully! "