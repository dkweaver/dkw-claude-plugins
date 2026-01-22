# Obsidian Claude Plugin

A Claude Code plugin for managing your Obsidian vault with daily notes, note creation, and integrated Obsidian knowledge.

## Installation

### From GitHub

```bash
# Clone the repository
git clone https://github.com/yourusername/obsidian-claude-plugin.git

# Load the plugin
claude --plugin-dir ./obsidian-claude-plugin
```

### First-Time Setup

On first use, the plugin will prompt you to configure your Obsidian vault path. Enter the full path to your vault directory (the folder containing your `.obsidian` folder).

## Commands

### Daily Note (`/obsidian-claude-plugin:daily-note` or `/obsidian-claude-plugin:dn`)

Add content to today's daily note. Creates the note if it doesn't exist.

```
/obsidian-claude-plugin:dn Review the quarterly report
/obsidian-claude-plugin:daily-note Finished meeting with design team
```

Daily notes are stored in the `daily/` subfolder with the format `YYYY-MM-DD.md`.

**Format:**
```markdown
---
tags:
  - daily-note
date: 2025-01-22
---

# 2025-01-22

## Log

- 14:32 - [ ] Review the quarterly report
- 15:00 - Finished meeting with design team
```

### Add Note (`/obsidian-claude-plugin:add-note`)

Create a new note with Claude-determined title and relevant tags.

```
/obsidian-claude-plugin:add-note Notes about the new API authentication flow
```

**Features:**
- Claude determines an appropriate title
- Automatically tagged with `from-claude`
- Scans vault for existing tags and adds relevant ones
- Only creates new tags when necessary

**Format:**
```markdown
---
tags:
  - from-claude
  - api
  - authentication
created: 2025-01-22
---

# API Authentication Flow

[Your content here]
```

## Automatic Detection

Claude can also detect when you're asking about daily notes or want to create a note, and will use these skills automatically:

- "Add a task to my daily note to review the PR"
- "Create a note about our discussion on microservices"
- "Log that I completed the deployment"

## Configuration

Configuration is stored in `~/.claude/plugins/obsidian-claude.config`:

```
VAULT_PATH=/path/to/your/obsidian/vault
```

To reconfigure, delete this file and restart Claude with the plugin loaded.

## Vault Agent

The plugin includes a specialized `vault-agent` subagent that has access to your Obsidian vault for searching, reading, and organizing notes.

## File Structure

```
obsidian-claude-plugin/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
├── skills/
│   ├── obsidian/            # Obsidian knowledge (background)
│   ├── daily-note/          # Daily note skill
│   └── add-note/            # Add note skill
├── agents/
│   └── vault-agent.md       # Vault subagent
├── hooks/
│   └── hooks.json           # Setup hook
├── scripts/
│   └── setup.sh             # Configuration script
└── README.md
```

## License

MIT
