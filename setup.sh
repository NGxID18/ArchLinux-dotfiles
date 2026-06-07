#!/bin/bash

cd "$(dirname "$0")"

echo "Permission set to executable for all scripts."
chmod +x Scripts/*.sh

run_script() {
    echo -e "\n==================================================="
    echo " 🚀 Menjalankan: $1"
    echo "==================================================="
    
    ./"$1"
    
    if [ $? -ne 0 ]; then
        echo -e "\n❌ ERROR: Gagal saat mengeksekusi $1."
        echo "Proses instalasi dihentikan untuk mencegah kerusakan sistem."
        exit 1
    else
        echo "✅ $1 selesai dijalankan."
    fi
}

run_script "dependencies.sh"
run_script "nvidia.sh"
run_script "gnome.sh"
run_script "cockpit.sh"

echo -e "\n🎉 SEMUA PROSES SELESAI DENGAN SUKSES! 🎉"