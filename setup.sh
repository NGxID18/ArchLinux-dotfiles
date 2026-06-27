#!/bin/bash

echo "Input sudo password to start installation"
sudo -v

while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

cd "$(dirname "$0")"

echo "Permission set to executable for all scripts."
chmod +x Scripts/*.sh
chmod +x Scripts/driver/*.sh

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

sudo mkdir -p /usr/share/backgrounds/
sudo cp -r "Wallpapers" /usr/share/backgrounds/
sudo chmod -R 755 /usr/share/backgrounds/Wallpapers/

# ======================================================= #

run_script "Scripts/repo.sh"

echo -e "\n==================================================="
echo " Select Your GPU :"
echo " 1) NVIDIA"
echo " 2) AMD"
echo " 3) Intel"
echo " 4) Skip GPU Driver Installation"
echo "==================================================="
read -p "[1-4] : " gpu_choice

case $gpu_choice in
    1)
        run_script "Scripts/driver/nvidia.sh"
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
    *)
        echo -e "\n Invalid input, GPU Driver Installation Skipped."
        ;;
esac

# ======================================================= #

run_script "Scripts/gnome.sh"
run_script "Scripts/sddm.sh"
run_script "Scripts/apps.sh"
run_script "Scripts/configs.sh"

sudo rm -r ~/ArchLinux-dotfiles

echo -e "\n All scripts executed successfully! "