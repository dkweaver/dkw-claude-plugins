# Setup

Configure the Obsidian vault path for this plugin.

## Instructions

1. Check if `~/.claude/plugins/obsidian-claude.config` already exists
2. If user provided path via $ARGUMENTS, use that
3. Otherwise ask user for their vault path
4. Validate the path exists (check with Glob)
5. Optionally check for `.obsidian` folder to confirm it's a vault
6. Create config directory: `mkdir -p ~/.claude/plugins`
7. Write config file `~/.claude/plugins/obsidian-claude.config`:
   ```
   VAULT_PATH={validated-path}
   ```
8. Create daily notes directory: `mkdir -p {VAULT_PATH}/daily`
9. Confirm success and show available commands:
   - `/obsidian-claude-plugin:dn` - Add to daily notes
   - `/obsidian-claude-plugin:add-note` - Create new notes

User's path (if provided): $ARGUMENTS
