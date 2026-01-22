---
name: setup
description: Configure the Obsidian vault path for this plugin. Run this first before using other commands.
allowed-tools: Read, Write, Glob, Bash
argument-hint: [vault-path]
---

# Obsidian Plugin Setup

Configure the path to your Obsidian vault.

## Instructions

### Step 1: Check if already configured

Use the **Read tool** to read `~/.claude/plugins/obsidian-claude.config`

If file exists and has a VAULT_PATH, show the current path and ask if user wants to reconfigure.

### Step 2: Get the vault path

If user provided a path via `$ARGUMENTS`, use that directly.

Otherwise, ask the user for their Obsidian vault path. The vault is the folder containing the `.obsidian` directory.

### Step 3: Validate the path

Use the **Glob tool** to check:
1. The directory exists: `{path}/*`
2. It's an Obsidian vault: `{path}/.obsidian/*`

If `.obsidian` doesn't exist, warn the user but allow them to proceed.

### Step 4: Save the configuration

Use **Bash** to create the config directory:
```bash
mkdir -p ~/.claude/plugins
```

Then use the **Write tool** to create `~/.claude/plugins/obsidian-claude.config`:
```
VAULT_PATH={the-validated-path}
```

### Step 5: Create the daily notes directory

Use **Bash**:
```bash
mkdir -p "{VAULT_PATH}/daily"
```

### Step 6: Confirm success

Tell the user setup is complete and show available commands:
- `/obsidian-claude-plugin:daily-note` - Add to daily notes
- `/obsidian-claude-plugin:add-note` - Create new notes

## Example

User runs `/obsidian-claude-plugin:setup ~/Documents/MyVault`:

1. Validate `~/Documents/MyVault` exists
2. Check for `.obsidian` folder
3. Save config with `VAULT_PATH=/Users/dan/Documents/MyVault`
4. Create `~/Documents/MyVault/daily/` if needed
5. Confirm success
