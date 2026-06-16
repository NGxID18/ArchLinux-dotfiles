#!/bin/bash

echo "Input sudo password to start installation"
sudo -v

while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

cd "$(dirname "$0")"

echo "Permission set to executable for all scripts."
chmod +x Scripts/*.sh

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

# ======================================================= #

# Global Wallpapers Setup
sudo mkdir -p /usr/share/backgrounds/
sudo cp -r "Wallpapers" /usr/share/backgrounds/
sudo chmod -R 755 /usr/share/backgrounds/Wallpapers/

# ======================================================= #

run_script "Scripts/repo.sh"
run_script "Scripts/driver.sh"
run_script "Scripts/kernel.sh"
run_script "Scripts/gnome.sh"
run_script "Scripts/sddm.sh"
run_script "Scripts/apps.sh"
run_script "Scripts/configs.sh"

sudo rm -r ~/ArchLinux-dotfiles
sudo rm -r ~/cachyos-repo
sudo rm -r ~/cachyos-repo.tar.xz

echo -e "\n All scripts executed successfully! "
