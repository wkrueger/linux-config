#!/bin/bash
# Rodar esse script se seu teclado for PT-BR e estiver com comportamento
# estranho após a instalação

# KDE Plasma Wayland - Brazilian ABNT2 Keyboard Layout Fix
# This script configures the keyboard layout to Portuguese Brazil ABNT2
# so that Shift+2 produces @ instead of "

echo "Configuring Brazilian ABNT2 keyboard layout for KDE..."

# Configure KDE keyboard layout settings
kwriteconfig5 --file kxkbrc --group Layout --key LayoutList br
kwriteconfig5 --file kxkbrc --group Layout --key VariantList abnt2
kwriteconfig5 --file kxkbrc --group Layout --key Model abnt2
kwriteconfig5 --file kxkbrc --group Layout --key DisplayNames ","
kwriteconfig5 --file kxkbrc --group Layout --key ResetOldOptions true
kwriteconfig5 --file kxkbrc --group Layout --key Use true

echo "KDE configuration updated."

# Apply the layout change immediately (for current session)
if command -v qdbus6 &> /dev/null; then
    qdbus6 org.kde.keyboard /Layouts setLayout 0
    echo "Layout applied using qdbus6."
elif command -v qdbus &> /dev/null; then
    qdbus org.kde.keyboard /Layouts setLayout 0
    echo "Layout applied using qdbus."
else
    echo "Warning: qdbus not found. Layout will apply after logout/login."
fi

# Set system-wide keyboard layout
echo ""
echo "Setting system-wide keyboard layout (requires sudo)..."
sudo localectl set-keymap br-abnt2
sudo localectl set-x11-keymap br abnt2

echo ""
echo "Configuration complete!"
echo "If the keyboard layout doesn't work immediately, log out and log back in."
