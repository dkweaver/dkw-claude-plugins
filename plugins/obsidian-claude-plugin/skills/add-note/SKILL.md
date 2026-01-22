---
name: add-note
description: Create a new note in the Obsidian vault with an appropriate title and tags. Use when the user wants to save information, ideas, or content as a new note.
subagent: obsidian-claude-plugin:vault-agent
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
argument-hint: [note content or topic]
---

# Add Note Skill

Create a new note in the user's Obsidian vault.

## Instructions

### Step 1: Read the config file

Use the **Read tool** to read `~/.claude/plugins/obsidian-claude.config`

If the file doesn't exist or VAULT_PATH is empty, tell the user:
"Please run `/obsidian-claude-plugin:setup` first to configure your vault path."
Then STOP.

Extract the VAULT_PATH value from the file content.

### Step 2: Get current date

Use **Bash** only for this:
```bash
date +%Y-%m-%d
```

### Step 3: Discover Existing Tags

Use the **Grep tool** to find existing tags in the vault:
- Search pattern `^  - ` in `{VAULT_PATH}` for frontmatter tags
- Search pattern `#[a-zA-Z][a-zA-Z0-9_-]*` for inline tags

### Step 4: Determine Title

Based on the content, create a descriptive title that:
- Is concise (2-6 words typically)
- Describes the main topic or purpose
- Uses title case
- Is suitable as a filename (no special characters except hyphens)

### Step 5: Select Tags

- ALWAYS include `from-claude` as the first tag
- Add 1-3 relevant tags from existing tags discovered in Step 3
- Only create a NEW tag if absolutely necessary
- Prefer broader existing tags over creating specific new ones

### Step 6: Check if file exists

Use the **Glob tool** to check if `{VAULT_PATH}/{filename}.md` already exists.

If it exists, append a number: `{filename}-2.md`, `{filename}-3.md`, etc.

### Step 7: Create the Note

Use the **Write tool** to create `{VAULT_PATH}/{filename}.md`:

```markdown
---
tags:
  - from-claude
  - {selected-tags}
created: {TODAY}
---

# {Title}

{User's content, formatted appropriately}
```

### Filename Rules

- Convert title to lowercase
- Replace spaces with hyphens
- Remove special characters
- Example: "Meeting Notes for Q1 Review" becomes `meeting-notes-for-q1-review.md`

## Content Formatting

- Preserve the user's content structure when possible
- Add appropriate Markdown formatting (headers, lists, code blocks)
- If the content is a list of items, format as a bulleted list
- If the content includes code, use fenced code blocks with language hints
- Keep the note focused on a single topic

## Example

User says: "Create a note about the new API authentication flow"

1. Scan tags, find existing: `api`, `authentication`, `architecture`
2. Title: "API Authentication Flow"
3. Tags: `from-claude`, `api`, `authentication`
4. Filename: `api-authentication-flow.md`

Result written to `{VAULT_PATH}/api-authentication-flow.md`:
```markdown
---
tags:
  - from-claude
  - api
  - authentication
created: 2026-01-22
---

# API Authentication Flow

[Content about the authentication flow]
```

Report back to the user with the note title and location.
