## ======================================================= ##

# Cockpit Server Management Tools
if [[ "$INSTALL_COCKPIT" =~ ^[Yy]$ ]]; then
    echo "Installing Cockpit Server Management Tools..."
    sudo pacman -S --needed --noconfirm \
        cockpit \
        cockpit-storaged \
        packagekit

    paru -S --noconfirm \
        cockpit-pacman \
        cockpit-machines \
        realmd

    sudo systemctl enable --now cockpit.socket

    sudo chmod 700 /etc/pacman.d/gnupg
    sudo git clone https://github.com/NGxID18/btrfs-manager /usr/share/cockpit/btrfs-manager
else
    echo "Skipping Cockpit Server Management Tools installation based on user config."
fi

## ======================================================= ##

# Server Tools
if [[ "$INSTALL_SERVER_TOOLS" =~ ^[Yy]$ ]]; then
    echo "Installing Server Tools..."
    sudo pacman -S --needed --noconfirm \
        docker docker-compose \
        dnsmasq virt-install virt-viewer virt-manager \
        qemu-full qemu-desktop \
        tuned

    paru -S --noconfirm \
        cockpit-dockermanager cockpit-machines \
        vmware-workstation

    sudo systemctl enable --now docker.service
    sudo systemctl enable --now libvirtd.service
    sudo systemctl enable --now vmware-networks.service

    sudo usermod -aG docker $USER

else
    echo "Skipping Server Tools installation based on user config."
fi

## ======================================================= ##