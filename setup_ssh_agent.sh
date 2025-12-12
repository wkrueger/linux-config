#!/bin/bash
# SSH Agent Startup Configuration Script
# Sets up ssh-agent to start automatically on login

set -e  # Exit on error

echo "========================================="
echo "SSH Agent Startup Configuration"
echo "========================================="
echo ""

# Method 1: Using systemd user service (preferred for modern systems)
echo "Setting up ssh-agent systemd service..."

# Enable and start ssh-agent socket (on-demand activation)
systemctl --user enable ssh-agent.service
echo "✓ ssh-agent service enabled"

# Set SSH_AUTH_SOCK environment variable for all sessions
echo ""
echo "Adding SSH_AUTH_SOCK configuration to ~/.zshrc..."

# Create backup of .zshrc
if [ -f ~/.zshrc ]; then
    if [ ! -f ~/.zshrc.backup.ssh_agent ]; then
        cp ~/.zshrc ~/.zshrc.backup.ssh_agent
        echo "✓ Backup created: ~/.zshrc.backup.ssh_agent"
    fi
fi

# Check if SSH_AUTH_SOCK config already exists
if grep -q "# SSH Agent Configuration" ~/.zshrc 2>/dev/null; then
    echo "✓ SSH agent configuration already exists in ~/.zshrc"
else
    # Add SSH_AUTH_SOCK configuration to .zshrc
    cat >> ~/.zshrc <<'EOF'

# SSH Agent Configuration
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
EOF
    echo "✓ SSH agent configuration added to ~/.zshrc"
fi

# Start ssh-agent service now
echo ""
echo "Starting ssh-agent service..."
systemctl --user start ssh-agent.service
echo "✓ ssh-agent service started"

echo ""
echo "========================================="
echo "Setup Complete!"
echo "========================================="
echo ""
echo "SSH agent is now configured to start automatically on login."
echo ""
echo "To use it in your current session:"
echo "  source ~/.zshrc"
echo ""
echo "The ssh-agent will automatically start on future logins."
echo "You can verify it's running with:"
echo "  systemctl --user status ssh-agent"
echo ""
