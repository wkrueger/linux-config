#!/bin/bash
# Plasma Configuration Backup Script
# Backs up KDE Plasma panel, widget, and layout configurations

BACKUP_DIR="/home/willian/setup/plasma_config_backup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "Creating Plasma configuration backup..."
mkdir -p "$BACKUP_DIR"

# Backup main Plasma configuration files
echo "Backing up Plasma applets configuration..."
cp ~/.config/plasma-org.kde.plasma.desktop-appletsrc "$BACKUP_DIR/plasma-org.kde.plasma.desktop-appletsrc"

echo "Backing up Plasma shell configuration..."
cp ~/.config/plasmashellrc "$BACKUP_DIR/plasmashellrc"

# Backup other relevant Plasma files
if [ -f ~/.config/plasmarc ]; then
    echo "Backing up Plasma settings..."
    cp ~/.config/plasmarc "$BACKUP_DIR/plasmarc"
fi

if [ -f ~/.config/plasma-localerc ]; then
    echo "Backing up Plasma locale settings..."
    cp ~/.config/plasma-localerc "$BACKUP_DIR/plasma-localerc"
fi

if [ -f ~/.config/plasmanotifyrc ]; then
    echo "Backing up Plasma notification settings..."
    cp ~/.config/plasmanotifyrc "$BACKUP_DIR/plasmanotifyrc"
fi

# Create a timestamped archive
echo "Creating timestamped archive..."
cd "$BACKUP_DIR/.."
tar -czf "plasma_config_${TIMESTAMP}.tar.gz" "plasma_config_backup/"

echo ""
echo "Backup complete!"
echo "Files backed up to: $BACKUP_DIR"
echo "Archive created: plasma_config_${TIMESTAMP}.tar.gz"
echo ""
echo "To restore, run: ./plasma_restore.sh"
