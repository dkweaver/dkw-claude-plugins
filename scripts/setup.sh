#!/bin/bash

# Obsidian Claude Plugin Setup Script
# This script runs on plugin initialization to configure the vault path

CONFIG_DIR="${HOME}/.claude/plugins"
CONFIG_FILE="${CONFIG_DIR}/obsidian-claude.config"

# Create config directory if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Check if already configured
if [ -f "$CONFIG_FILE" ]; then
    EXISTING_PATH=$(grep VAULT_PATH "$CONFIG_FILE" | cut -d= -f2)
    if [ -n "$EXISTING_PATH" ] && [ -d "$EXISTING_PATH" ]; then
        echo "Obsidian vault already configured: $EXISTING_PATH"
        exit 0
    fi
fi

# Prompt for vault path
echo ""
echo "=== Obsidian Claude Plugin Setup ==="
echo ""
echo "Please enter the full path to your Obsidian vault:"
echo "(This is the folder that contains your .obsidian directory)"
echo ""
read -r -p "Vault path: " VAULT_PATH

# Expand tilde if present
VAULT_PATH="${VAULT_PATH/#\~/$HOME}"

# Validate the path exists
if [ ! -d "$VAULT_PATH" ]; then
    echo ""
    echo "Error: Directory does not exist: $VAULT_PATH"
    echo "Please run setup again with a valid path."
    exit 2
fi

# Check for .obsidian folder (optional but recommended)
if [ ! -d "$VAULT_PATH/.obsidian" ]; then
    echo ""
    echo "Warning: No .obsidian folder found in $VAULT_PATH"
    echo "This may not be an Obsidian vault. Continue anyway? (y/n)"
    read -r -p "> " CONFIRM
    if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
        echo "Setup cancelled."
        exit 2
    fi
fi

# Ensure daily notes directory exists
DAILY_DIR="$VAULT_PATH/daily"
if [ ! -d "$DAILY_DIR" ]; then
    echo ""
    echo "Creating daily notes directory: $DAILY_DIR"
    mkdir -p "$DAILY_DIR"
fi

# Save configuration
echo "VAULT_PATH=$VAULT_PATH" > "$CONFIG_FILE"

echo ""
echo "Configuration saved successfully!"
echo "Vault path: $VAULT_PATH"
echo ""
echo "You can now use:"
echo "  /obsidian-claude-plugin:daily-note - Add to daily notes"
echo "  /obsidian-claude-plugin:dn         - Shortcut for daily-note"
echo "  /obsidian-claude-plugin:add-note   - Create new notes"
echo ""

exit 0
