#!/bin/bash
# Plasma Configuration Restore Script
# Restores KDE Plasma panel, widget, and layout configurations

BACKUP_DIR="/home/willian/setup/plasma_config_backup"

if [ ! -d "$BACKUP_DIR" ]; then
    echo "Error: Backup directory not found: $BACKUP_DIR"
    echo "Please run plasma_backup.sh first to create a backup."
    exit 1
fi

echo "Restoring Plasma configuration from backup..."
echo "Warning: This will overwrite your current Plasma configuration!"
read -p "Continue? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Restore cancelled."
    exit 0
fi

# Kill plasmashell to prevent conflicts
echo "Stopping Plasma Shell..."
kquitapp6 plasmashell 2>/dev/null || killall plasmashell 2>/dev/null

# Restore configuration files
echo "Restoring Plasma applets configuration..."
cp "$BACKUP_DIR/plasma-org.kde.plasma.desktop-appletsrc" ~/.config/plasma-org.kde.plasma.desktop-appletsrc

echo "Restoring Plasma shell configuration..."
cp "$BACKUP_DIR/plasmashellrc" ~/.config/plasmashellrc

if [ -f "$BACKUP_DIR/plasmarc" ]; then
    echo "Restoring Plasma settings..."
    cp "$BACKUP_DIR/plasmarc" ~/.config/plasmarc
fi

if [ -f "$BACKUP_DIR/plasma-localerc" ]; then
    echo "Restoring Plasma locale settings..."
    cp "$BACKUP_DIR/plasma-localerc" ~/.config/plasma-localerc
fi

if [ -f "$BACKUP_DIR/plasmanotifyrc" ]; then
    echo "Restoring Plasma notification settings..."
    cp "$BACKUP_DIR/plasmanotifyrc" ~/.config/plasmanotifyrc
fi

# Restart Plasma Shell
echo "Restarting Plasma Shell..."
kstart6 plasmashell &

echo ""
echo "Restore complete!"
echo "Plasma Shell has been restarted with the restored configuration."
