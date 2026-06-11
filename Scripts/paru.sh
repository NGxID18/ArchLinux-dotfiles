# Paru
echo "Installing Paru AUR helper..."
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd ..
rm -rf paru

echo "Installing applications from the AUR using Paru..."
paru -S --noconfirm \
    visual-studio-code-bin \
    google-chrome \
    zoom