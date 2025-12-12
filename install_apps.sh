#!/bin/bash
# Application Installation Script
# Installs development tools and applications on Manjaro Linux

set -e  # Exit on error

echo "========================================="
echo "Application Installation Script"
echo "========================================="
echo ""

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if a package is installed
package_installed() {
    pacman -Q "$1" >/dev/null 2>&1
}

# Install yay if not already installed
if ! command_exists yay; then
    echo "Installing yay AUR helper..."
    sudo pacman -S --needed --noconfirm git base-devel
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
    echo "✓ yay installed"
else
    echo "✓ yay already installed"
fi

echo ""
echo "Updating system..."
sudo pacman -Syu --noconfirm

echo ""
echo "========================================="
echo "Installing Applications"
echo "========================================="

# VS Code (official repo)
echo ""
echo "Installing Visual Studio Code..."
if ! package_installed code; then
    yay -S --noconfirm visual-studio-code-bin
    echo "✓ VS Code installed"
else
    echo "✓ VS Code already installed"
fi

# Docker (official repo)
echo ""
echo "Installing Docker..."
if ! package_installed docker; then
    sudo pacman -S --needed --noconfirm docker docker-compose
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo usermod -aG docker $USER
    echo "✓ Docker installed"
    echo "  Note: You need to log out and back in for Docker group membership to take effect"
else
    echo "✓ Docker already installed"
fi

# MariaDB Client (official repo)
echo ""
echo "Installing MariaDB Client..."
if ! package_installed mariadb-clients; then
    sudo pacman -S --needed --noconfirm mariadb-clients
    echo "✓ MariaDB Client installed"
else
    echo "✓ MariaDB Client already installed"
fi

# PostgreSQL Client (official repo)
echo ""
echo "Installing PostgreSQL Client..."
if ! package_installed postgresql-libs; then
    sudo pacman -S --needed --noconfirm postgresql-libs
    echo "✓ PostgreSQL Client libraries installed"
else
    echo "✓ PostgreSQL Client already installed"
fi

# GIMP (official repo)
echo ""
echo "Installing GIMP..."
if ! package_installed gimp; then
    sudo pacman -S --needed --noconfirm gimp
    echo "✓ GIMP installed"
else
    echo "✓ GIMP already installed"
fi

# EasyEffects (official repo)
echo ""
echo "Installing EasyEffects..."
if ! package_installed easyeffects; then
    sudo pacman -S --needed --noconfirm easyeffects
    echo "✓ EasyEffects installed"
else
    echo "✓ EasyEffects already installed"
fi

# HTTPie (official repo)
echo ""
echo "Installing HTTPie..."
if ! package_installed httpie; then
    sudo pacman -S --needed --noconfirm httpie
    echo "✓ HTTPie installed"
else
    echo "✓ HTTPie already installed"
fi

# Slack Desktop (AUR)
echo ""
echo "Installing Slack Desktop..."
if ! package_installed slack-desktop; then
    yay -S --noconfirm slack-desktop
    echo "✓ Slack Desktop installed"
else
    echo "✓ Slack Desktop already installed"
fi

# Notion Desktop (AUR)
echo ""
echo "Installing Notion Desktop..."
if ! package_installed notion-app-electron; then
    yay -S --noconfirm notion-app-electron
    echo "✓ Notion Desktop installed"
else
    echo "✓ Notion Desktop already installed"
fi

# Vesktop (AUR)
echo ""
echo "Installing Vesktop..."
if ! package_installed vesktop-bin; then
    yay -S --noconfirm vesktop-bin
    echo "✓ Vesktop installed"
else
    echo "✓ Vesktop already installed"
fi

# Microsoft Edge (AUR)
echo ""
echo "Installing Microsoft Edge..."
if ! package_installed microsoft-edge-stable-bin; then
    yay -S --noconfirm microsoft-edge-stable-bin
    echo "✓ Microsoft Edge installed"
else
    echo "✓ Microsoft Edge already installed"
fi

# Steam (official repo)
echo ""
echo "Installing Steam..."
if ! package_installed steam; then
    sudo pacman -S --needed --noconfirm steam
    echo "✓ Steam installed"
else
    echo "✓ Steam already installed"
fi

# DataGrip (manual installation)
echo ""
echo "Installing DataGrip..."
APPS_DIR="$HOME/Apps"
DATAGRIP_DIR="$APPS_DIR/DataGrip"

if [ ! -d "$DATAGRIP_DIR" ]; then
    echo "Creating ~/Apps directory..."
    mkdir -p "$APPS_DIR"

    echo "Downloading DataGrip..."
    cd "$APPS_DIR"

    # Get the latest DataGrip download URL
    DATAGRIP_URL="https://download.jetbrains.com/datagrip/datagrip-2024.3.1.tar.gz"

    echo "Downloading from: $DATAGRIP_URL"
    wget -O datagrip.tar.gz "$DATAGRIP_URL"

    echo "Extracting DataGrip..."
    tar -xzf datagrip.tar.gz

    # Rename extracted directory to DataGrip
    EXTRACTED_DIR=$(tar -tzf datagrip.tar.gz | head -1 | cut -f1 -d"/")
    mv "$EXTRACTED_DIR" DataGrip

    # Clean up
    rm datagrip.tar.gz

    echo "✓ DataGrip installed to ~/Apps/DataGrip"
    echo "  Run: ~/Apps/DataGrip/bin/datagrip.sh"

    # Create desktop entry
    echo "Creating desktop entry..."
    mkdir -p ~/.local/share/applications
    cat > ~/.local/share/applications/jetbrains-datagrip.desktop <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=DataGrip
Icon=$DATAGRIP_DIR/bin/datagrip.svg
Exec=$DATAGRIP_DIR/bin/datagrip.sh %f
Comment=The Cross-Platform IDE for Databases & SQL by JetBrains
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-datagrip
EOF

    chmod +x ~/.local/share/applications/jetbrains-datagrip.desktop
    echo "✓ Desktop entry created"
else
    echo "✓ DataGrip already installed at $DATAGRIP_DIR"
fi

echo ""
echo "========================================="
echo "Installation Complete!"
echo "========================================="
echo ""
echo "Installed applications:"
echo "  ✓ yay (AUR helper)"
echo "  ✓ Visual Studio Code"
echo "  ✓ Docker & Docker Compose"
echo "  ✓ MariaDB Client"
echo "  ✓ PostgreSQL Client"
echo "  ✓ GIMP"
echo "  ✓ EasyEffects"
echo "  ✓ HTTPie"
echo "  ✓ Slack Desktop"
echo "  ✓ Notion Desktop"
echo "  ✓ Vesktop"
echo "  ✓ Microsoft Edge"
echo "  ✓ Steam"
echo "  ✓ DataGrip (~/Apps/DataGrip)"
echo ""
echo "Notes:"
echo "  - Log out and back in for Docker group membership to take effect"
echo "  - DataGrip can be launched from: ~/Apps/DataGrip/bin/datagrip.sh"
echo "  - DataGrip desktop entry has been created in application menu"
echo "  - Database clients installed without servers (MariaDB, PostgreSQL)"
echo ""
