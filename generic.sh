#!/bin/bash
# KDE Plasma General Settings Configuration
# Sets up dark mode and keyboard repeat settings

echo "Configuring KDE Plasma settings..."

# Dark Mode - Apply Breeze Dark color scheme
echo "Applying dark mode..."
plasma-apply-colorscheme BreezeDark
kwriteconfig5 --file kdeglobals --group General --key ColorScheme BreezeDark

# Keyboard Repeat Settings
echo "Configuring keyboard repeat settings..."
kwriteconfig5 --file kcminputrc --group Keyboard --key KeyRepeat repeat
kwriteconfig5 --file kcminputrc --group Keyboard --key RepeatDelay 200
kwriteconfig5 --file kcminputrc --group Keyboard --key RepeatRate 35

# Touchpad Settings - Natural Scroll
echo "Configuring touchpad settings..."
kwriteconfig5 --file kcminputrc --group Libinput --key NaturalScroll true

# Desktop Configuration - 3 desktops
echo "Configuring virtual desktops..."
kwriteconfig5 --file kwinrc --group Desktops --key Number 3
kwriteconfig5 --file kwinrc --group Desktops --key Rows 1

# Touchpad Gestures - 4-finger swipe for desktop switching
echo "Configuring touchpad gestures..."
kwriteconfig5 --file kwinrc --group TouchpadGestures --key SwipeLeft4 "SwitchToNextDesktop"
kwriteconfig5 --file kwinrc --group TouchpadGestures --key SwipeRight4 "SwitchToPreviousDesktop"

# Keyboard Shortcuts - Meta+1/2/3 for desktop switching
echo "Configuring desktop keyboard shortcuts..."
kwriteconfig5 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop 1" "Meta+1,Ctrl+F1,Switch to Desktop 1"
kwriteconfig5 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop 2" "Meta+2,Ctrl+F2,Switch to Desktop 2"
kwriteconfig5 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop 3" "Meta+3,Ctrl+F3,Switch to Desktop 3"

# Reconfigure KWin to apply changes
echo "Applying changes..."
qdbus6 org.kde.KWin /KWin reconfigure

# Zsh Configuration - Disable autocorrect
echo "Configuring zsh settings..."
if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "unsetopt correct" "$HOME/.zshrc"; then
        echo "" >> "$HOME/.zshrc"
        echo "# Disable autocorrect prompts" >> "$HOME/.zshrc"
        echo "unsetopt correct_all" >> "$HOME/.zshrc"
        echo "unsetopt correct" >> "$HOME/.zshrc"
        echo "Zsh autocorrect disabled"
    else
        echo "Zsh autocorrect already configured"
    fi
fi

echo ""
echo "Configuration complete!"
echo "- Dark mode: Enabled (BreezeDark)"
echo "- Keyboard repeat delay: 200ms"
echo "- Keyboard repeat rate: 35 repeats/sec"
echo "- Touchpad: Natural scroll enabled"
echo "- Virtual desktops: 3 desktops (horizontal layout)"
echo "- Desktop shortcuts: Meta+1/2/3"
echo "- Touchpad gestures: 4-finger swipe left/right for desktop switching"
echo "- Zsh autocorrect: Disabled"
