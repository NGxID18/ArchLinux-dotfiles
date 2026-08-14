#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    echo -e "\n ERROR: Do not run install.sh with sudo directly!"
    echo " The script will ask for sudo password when needed."
    exit 1
fi

echo "Input sudo password to start installation"
sudo -v

while true; do sudo -n -v; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

echo "Permission set to executable for all scripts."
find Scripts -type f -name "*.sh" -exec chmod +x {} +

# ======================================================= #
# --- User Input ---
# ======================================================= #

if [ -f "Scripts/setup.sh" ]; then
    source Scripts/setup.sh
else
    echo -e "\n ERROR: Scripts/setup.sh not found!"
    exit 1
fi

# ======================================================= #
# --- EXECUTE INSTALLATION ---
# ======================================================= #

run_script() {
    echo -e "\n==================================================="
    echo " Running  : $1"
    echo "==================================================="
    
    if ! ./"$1"; then
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

# Applications & Cockpit
if [[ "$INSTALL_APPS" =~ ^[Yy]$ ]]; then
    run_script "Scripts/apps/apps.sh"
fi

# User Configs
if [[ "$INSTALL_CLI" =~ ^[Yy]$ ]]; then
    run_script "Scripts/configs/cli.sh"
    if [[ "$INSTALL_ZRAM" =~ ^[Yy]$ ]]; then
        run_script "Scripts/configs/zram.sh"
    fi
fi

echo -e "\n All scripts executed successfully! "