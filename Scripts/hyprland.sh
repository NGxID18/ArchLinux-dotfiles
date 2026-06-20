echo "Installing HYPRLAND Desktop Environment..."
sudo pacman -S --needed --noconfirm \
    hyprland \
    waybar \
    hyprpaper \
    wofi 

sudo pacman -S --needed --noconfirm \
    playerctl \
    ddcutil \
    i2c-tools