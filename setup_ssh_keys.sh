#!/bin/bash
# SSH Keys Setup Script
# Copies SSH private keys to ~/.ssh and sets up aliases for switching keys

set -e  # Exit on error

echo "========================================="
echo "SSH Keys Setup Script"
echo "========================================="
echo ""

# Define source directory (adjust if needed)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR"

# Check if key files exist
if [ ! -f "$SOURCE_DIR/pwdless" ]; then
    echo "Error: pwdless key file not found at $SOURCE_DIR/pwdless"
    echo "Please place the key files in the setup directory"
    exit 1
fi

if [ ! -f "$SOURCE_DIR/dotkey" ]; then
    echo "Error: dotkey key file not found at $SOURCE_DIR/dotkey"
    echo "Please place the key files in the setup directory"
    exit 1
fi

# Create ~/.ssh directory if it doesn't exist
echo "Setting up ~/.ssh directory..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh
echo "✓ ~/.ssh directory ready"

# Copy SSH keys
echo ""
echo "Copying SSH private keys..."
cp "$SOURCE_DIR/pwdless" ~/.ssh/pwdless
cp "$SOURCE_DIR/dotkey" ~/.ssh/dotkey
echo "✓ Keys copied to ~/.ssh/"

# Set correct permissions on private keys
echo ""
echo "Setting permissions on private keys..."
chmod 600 ~/.ssh/pwdless
chmod 600 ~/.ssh/dotkey
echo "✓ Permissions set (600)"

# Add aliases to .zshrc
echo ""
echo "Adding aliases to ~/.zshrc..."

# Create backup of .zshrc
if [ -f ~/.zshrc ]; then
    cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
    echo "✓ Backup created: ~/.zshrc.backup.*"
fi

# Check if aliases already exist
if grep -q "# SSH Key Switching Aliases" ~/.zshrc 2>/dev/null; then
    echo "✓ Aliases already exist in ~/.zshrc"
else
    # Add aliases to .zshrc
    cat >> ~/.zshrc <<'EOF'

# SSH Key Switching Aliases
alias pwdless='ssh-add -D && ssh-add ~/.ssh/pwdless'
alias dotkey='ssh-add -D && ssh-add ~/.ssh/dotkey'
EOF
    echo "✓ Aliases added to ~/.zshrc"
fi

echo ""
echo "========================================="
echo "Setup Complete!"
echo "========================================="
echo ""
echo "SSH keys installed:"
echo "  ✓ ~/.ssh/pwdless (600)"
echo "  ✓ ~/.ssh/dotkey (600)"
echo ""
echo "Aliases added to ~/.zshrc:"
echo "  ✓ pwdless - Clear ssh-agent and add pwdless key"
echo "  ✓ dotkey   - Clear ssh-agent and add dotkey key"
echo ""
echo "To use the aliases, either:"
echo "  1. Restart your terminal, or"
echo "  2. Run: source ~/.zshrc"
echo ""
echo "Then you can switch keys with:"
echo "  pwdless  # Use pwdless key"
echo "  dotkey   # Use dotkey key"
echo ""
