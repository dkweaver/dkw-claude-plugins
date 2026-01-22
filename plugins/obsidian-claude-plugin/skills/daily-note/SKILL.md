---
name: daily-note
description: Add tasks or content to today's daily note in Obsidian. Use when the user wants to log something, add a task, or update their daily note.
aliases:
  - dn
context: fork
agent: vault-agent
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
argument-hint: [content to add]
---

# Daily Note Skill

Add content to the user's daily note in their Obsidian vault.

## Configuration

The vault path is stored in: `~/.claude/plugins/obsidian-claude.config`

**IMPORTANT**: First check if config exists:
```bash
cat ~/.claude/plugins/obsidian-claude.config
```

If the file doesn't exist or VAULT_PATH is empty, tell the user:
"Please run `/obsidian-claude-plugin:setup` first to configure your vault path."
Then STOP - do not proceed without a valid config.

Read the vault path:
```bash
VAULT_PATH=$(grep VAULT_PATH ~/.claude/plugins/obsidian-claude.config | cut -d= -f2)
```

Daily notes are stored in the `daily/` subfolder of the vault.

## Workflow

1. **Get today's date** in YYYY-MM-DD format
2. **Check if daily note exists**: Look for `$VAULT_PATH/daily/YYYY-MM-DD.md`
3. **If note exists**: Append the new content with a timestamp
4. **If note doesn't exist**: Create it with proper frontmatter, then add content

## Daily Note Format

```markdown
---
tags:
  - daily-note
date: YYYY-MM-DD
---

# YYYY-MM-DD

## Log

- HH:MM - First entry
- HH:MM - Second entry
```

## Instructions

When the user provides content via `$ARGUMENTS` or describes what they want to add:

1. Read the vault path from config:
   ```bash
   VAULT_PATH=$(grep VAULT_PATH ~/.claude/plugins/obsidian-claude.config | cut -d= -f2)
   ```

2. Get today's date:
   ```bash
   TODAY=$(date +%Y-%m-%d)
   CURRENT_TIME=$(date +%H:%M)
   ```

3. Check if the daily note exists:
   ```bash
   DAILY_NOTE="$VAULT_PATH/daily/$TODAY.md"
   ```

4. If the file does NOT exist, create it with this template:
   ```markdown
   ---
   tags:
     - daily-note
   date: YYYY-MM-DD
   ---

   # YYYY-MM-DD

   ## Log

   - HH:MM - [user's content]
   ```

5. If the file DOES exist, append to it:
   ```markdown

   - HH:MM - [user's content]
   ```

6. Ensure the `daily/` directory exists before writing:
   ```bash
   mkdir -p "$VAULT_PATH/daily"
   ```

## Content Formatting

- Each entry starts with `- HH:MM - ` (timestamp prefix)
- Keep entries concise but complete
- If the user provides a task, format it as a task: `- HH:MM - [ ] Task description`
- If multiple items, add each on its own line with timestamp

## Example Usage

User says: "Add a task to review the quarterly report"

Result appended to daily note:
```
- 14:32 - [ ] Review the quarterly report
```

User says: "Log that I finished the meeting with the design team"

Result appended to daily note:
```
- 14:35 - Finished meeting with the design team
```
