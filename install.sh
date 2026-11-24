#!/bin/bash
# Hyprland Nighttime Theme Installer

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
NC='\033[0m'

echo -e "${PURPLE}╔════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║  Hyprland Nighttime Theme Installer    ║${NC}"
echo -e "${PURPLE}╚════════════════════════════════════════╝${NC}"
echo ""

# Detect distro
if [ -f /etc/redhat-release ]; then
    DISTRO="rhel"
    PKG_MGR="dnf"
elif [ -f /etc/fedora-release ]; then
    DISTRO="fedora"
    PKG_MGR="dnf"
else
    DISTRO="unknown"
    PKG_MGR="dnf"
fi

echo -e "${GREEN}[1/5]${NC} Detected: $DISTRO"

# Install packages
echo -e "${GREEN}[2/5]${NC} Installing packages..."
if [ "$DISTRO" = "rhel" ]; then
    echo "Note: RHEL may need EPEL enabled for some packages"
    echo "Run: sudo dnf install epel-release"
fi

read -p "Install packages via dnf? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo $PKG_MGR install -y \
        hyprland waybar wofi kitty mako swaybg swaylock \
        grim slurp wl-clipboard brightnessctl playerctl \
        btop neofetch network-manager-applet \
        2>/dev/null || echo "Some packages may not be available"
fi

# Install font
echo -e "${GREEN}[3/5]${NC} Installing JetBrainsMono Nerd Font..."
mkdir -p ~/.local/share/fonts
if [ ! -d ~/.local/share/fonts/JetBrainsMono ]; then
    cd ~/.local/share/fonts
    curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
    unzip -o JetBrainsMono.zip -d JetBrainsMono
    rm JetBrainsMono.zip
    fc-cache -fv
    echo "Font installed"
else
    echo "Font already installed"
fi

# Copy configs
echo -e "${GREEN}[4/5]${NC} Installing configs..."
mkdir -p ~/.config

cp -r "$SCRIPT_DIR/hypr" ~/.config/
cp -r "$SCRIPT_DIR/waybar" ~/.config/
cp -r "$SCRIPT_DIR/wofi" ~/.config/
cp -r "$SCRIPT_DIR/kitty" ~/.config/
cp -r "$SCRIPT_DIR/mako" ~/.config/
cp -r "$SCRIPT_DIR/swaylock" ~/.config/
cp -r "$SCRIPT_DIR/btop" ~/.config/
cp -r "$SCRIPT_DIR/ncspot" ~/.config/ 2>/dev/null || true
cp -r "$SCRIPT_DIR/neofetch" ~/.config/

chmod +x ~/.config/hypr/startup.sh

echo "Configs installed to ~/.config/"

# SDDM theme
echo -e "${GREEN}[5/5]${NC} Installing SDDM theme..."
read -p "Install SDDM login theme? (requires sudo) (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo mkdir -p /usr/share/sddm/themes/nighttime
    sudo cp -r "$SCRIPT_DIR/sddm-theme/"* /usr/share/sddm/themes/nighttime/
    sudo chmod -R 755 /usr/share/sddm/themes/nighttime
    sudo mkdir -p /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=nighttime" | sudo tee /etc/sddm.conf.d/theme.conf
    echo "SDDM theme installed"
fi

echo ""
echo -e "${PURPLE}════════════════════════════════════════${NC}"
echo -e "${GREEN}Installation complete!${NC}"
echo ""
echo "To start Hyprland:"
echo "  1. Log out"
echo "  2. Select 'Hyprland' from session menu"
echo "  3. Log in"
echo ""
echo "Or from TTY: Hyprland"
echo -e "${PURPLE}════════════════════════════════════════${NC}"
