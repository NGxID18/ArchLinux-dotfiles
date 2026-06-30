#!/bin/bash

echo "Input sudo password to start installation"
sudo -v

while true; do sudo -n -v; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

cd "$(dirname "$0")"

echo "Permission set to executable for all scripts."
chmod +x Scripts/*.sh
chmod +x Scripts/driver/*.sh

# ======================================================= #
# --- USER INPUT --- #
# ======================================================= #

echo -e "\n==================================================="
echo " Select Your GPU :"
echo " 1) NVIDIA"
echo " 2) AMD"
echo " 3) Intel"
echo " 4) Skip GPU Driver Installation"
echo "==================================================="
read -p "[1-4] : " GPU_CHOICE

if [ "$GPU_CHOICE" == "1" ]; then
    echo -e "\n==================================================="
    echo " Choose NVIDIA Driver:"
    echo " 1) Proprietary (nvidia-dkms) - For Pascal GPU (GTX 10xx) and older"
    echo " 2) Open Kernel Module (nvidia-open-dkms) - Recommended for Turing GPU (GTX 16xx) and newer"
    echo " 3) Nouveau (Open Source Linux Kernel) - Community Based"
    echo "==================================================="
    read -p "[1-3] : " NVD_TYPE

    if [ "$NVD_TYPE" != "3" ]; then
        echo -e "\nDo you want to install CUDA & cuDNN? (y/N)"
        read -p ": " NVD_CUDA

        echo -e "\nApply limit maximum clock at 2400MHz? (~100W full load on RTX 5060) (y/N)"
        read -p ": " NVD_TUNE
    fi
elif [ "$GPU_CHOICE" == "2" ]; then
    echo -e "\n==================================================="
    echo " Choose AMD Vulkan Driver:"
    echo " 1) RADV / Mesa (vulkan-radeon) - Recommended for Gaming"
    echo " 2) AMDVLK (amdvlk) - Official AMD Vulkan driver"
    echo "==================================================="
    read -p "[1-2] : " AMD_TYPE

    echo -e "\nDo you want to install AMD ROCm? (y/N)"
    read -p ": " AMD_ROCM
elif [ "$GPU_CHOICE" == "3" ]; then
    echo -e "\nDo you want to install Intel Compute Runtime? (y/N)"
    read -p ": " INTEL_COMPUTE
fi

export GPU_CHOICE NVD_TYPE NVD_CUDA NVD_TUNE AMD_TYPE AMD_ROCM INTEL_COMPUTE

# ======================================================= #
# --- EXECUTE INSTALLATION --- #
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

sudo mkdir -p /usr/share/backgrounds/
sudo cp -r "Wallpapers" /usr/share/backgrounds/
sudo chmod -R 755 /usr/share/backgrounds/Wallpapers/

run_script "Scripts/repo.sh"

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
    *)
        echo -e "\n Invalid input, GPU Driver Installation Skipped."
        ;;
esac

run_script "Scripts/gnome.sh"
run_script "Scripts/sddm.sh"
run_script "Scripts/apps.sh"
run_script "Scripts/configs.sh"

rm -rf ~/ArchLinux-dotfiles

echo -e "\n All scripts executed successfully! "