---
name: daily-note
description: Add tasks or content to today's daily note in Obsidian. Use when the user wants to log something, add a task, or update their daily note.
context: fork
agent: obsidian-claude-plugin:vault-agent
allowed-tools: Read, Write, Edit, Glob, Bash
argument-hint: [content to add]
---

# Daily Note Skill

Add content to the user's daily note in their Obsidian vault.

## Instructions

### Step 1: Read the config file

Use the **Read tool** to read `~/.claude/plugins/obsidian-claude.config`

If the file doesn't exist or VAULT_PATH is empty, tell the user:
"Please run `/obsidian-claude-plugin:setup` first to configure your vault path."
Then STOP.

Extract the VAULT_PATH value from the file content.

### Step 2: Get current date and time

Use **Bash** only for this:
```bash
date +%Y-%m-%d
date +%H:%M
```

### Step 3: Check if daily note exists

Use the **Read tool** to try reading: `{VAULT_PATH}/daily/{TODAY}.md`

Where `{TODAY}` is the date from Step 2 (e.g., `2026-01-22`).

### Step 4a: If note does NOT exist - Create it

Use the **Write tool** to create `{VAULT_PATH}/daily/{TODAY}.md` with:

```markdown
---
tags:
  - daily-note
date: {TODAY}
---

# {TODAY}

## Log

- {TIME} - {user's content}
```

### Step 4b: If note EXISTS - Append to it

Use the **Edit tool** to append to the end of the file:

```markdown

- {TIME} - {user's content}
```

Find the last line of the file and add the new entry after it.

## Content Formatting

- Each entry starts with `- HH:MM - ` (timestamp prefix)
- Keep entries concise but complete
- If the user provides a task, format it as: `- HH:MM - [ ] Task description`
- If multiple items, add each on its own line with timestamp

## Example

User says: "Add a task to review the quarterly report"

Result appended:
```
- 14:32 - [ ] Review the quarterly report
```
