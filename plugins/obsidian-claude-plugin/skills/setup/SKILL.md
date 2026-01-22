---
name: setup
description: Configure the Obsidian vault path for this plugin. Run this first before using other commands.
allowed-tools: Bash, AskUserQuestion
argument-hint: [vault-path]
---

# Obsidian Plugin Setup

Configure the path to your Obsidian vault.

## Instructions

1. **Check if already configured**:
   ```bash
   cat ~/.claude/plugins/obsidian-claude.config 2>/dev/null
   ```

2. **If not configured or user wants to reconfigure**:
   - Ask the user for their Obsidian vault path using AskUserQuestion
   - The vault is the folder containing the `.obsidian` directory

3. **If user provides path via $ARGUMENTS**, use that directly

4. **Validate the path**:
   - Check the directory exists
   - Optionally check for `.obsidian` folder

5. **Save the configuration**:
   ```bash
   mkdir -p ~/.claude/plugins
   echo "VAULT_PATH=/path/to/vault" > ~/.claude/plugins/obsidian-claude.config
   ```

6. **Create the daily notes directory**:
   ```bash
   mkdir -p "$VAULT_PATH/daily"
   ```

7. **Confirm to the user** that setup is complete and show them available commands:
   - `/obsidian-claude-plugin:daily-note` - Add to daily notes
   - `/obsidian-claude-plugin:add-note` - Create new notes

## Example

If user runs `/obsidian-claude-plugin:setup ~/Documents/MyVault`:
1. Validate `~/Documents/MyVault` exists
2. Save to config
3. Create `~/Documents/MyVault/daily/` if needed
4. Confirm success
