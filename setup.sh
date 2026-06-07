#!/bin/bash

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

run_script "Scripts/dependencies.sh"
run_script "Scripts/configs.sh"
run_script "Scripts/gnome.sh"
run_script "Scripts/nvidia.sh"
run_script "Scripts/cockpit.sh"

echo -e "\n All scripts executed successfully! "