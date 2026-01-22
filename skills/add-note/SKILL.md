---
name: add-note
description: Create a new note in the Obsidian vault with an appropriate title and tags. Use when the user wants to save information, ideas, or content as a new note.
context: fork
agent: vault-agent
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
argument-hint: [note content or topic]
---

# Add Note Skill

Create a new note in the user's Obsidian vault.

## Configuration

The vault path is stored in: `~/.claude/plugins/obsidian-claude.config`

Read the vault path:
```bash
VAULT_PATH=$(grep VAULT_PATH ~/.claude/plugins/obsidian-claude.config | cut -d= -f2)
```

## Workflow

1. **Read the vault path** from config
2. **Scan existing tags** in the vault to find relevant ones
3. **Determine an appropriate title** based on the content
4. **Create the note** with proper frontmatter and tags
5. **Always include** the `from-claude` tag

## Note Format

```markdown
---
tags:
  - from-claude
  - [relevant-existing-tag]
  - [another-relevant-tag]
created: YYYY-MM-DD
---

# Note Title

[User's content here]
```

## Instructions

When the user provides content via `$ARGUMENTS` or describes what they want to note:

### Step 1: Get Configuration
```bash
VAULT_PATH=$(grep VAULT_PATH ~/.claude/plugins/obsidian-claude.config | cut -d= -f2)
TODAY=$(date +%Y-%m-%d)
```

### Step 2: Discover Existing Tags
Scan the vault for existing tags to reuse:
```bash
# Find tags in frontmatter
grep -rh "^  - " "$VAULT_PATH" --include="*.md" | sort | uniq -c | sort -rn | head -20

# Find inline tags
grep -roh "#[a-zA-Z][a-zA-Z0-9_-]*" "$VAULT_PATH" --include="*.md" | sort | uniq -c | sort -rn | head -20
```

### Step 3: Determine Title
Based on the content, create a descriptive title that:
- Is concise (2-6 words typically)
- Describes the main topic or purpose
- Uses title case
- Is suitable as a filename (no special characters except hyphens)

### Step 4: Select Tags
- ALWAYS include `from-claude` as the first tag
- Add 1-3 relevant tags from the existing tags discovered in Step 2
- Only create a NEW tag if absolutely necessary and no existing tag fits
- Prefer broader existing tags over creating specific new ones

### Step 5: Create the Note
Write the file to `$VAULT_PATH/[title-as-filename].md`:

```markdown
---
tags:
  - from-claude
  - [selected-tags]
created: YYYY-MM-DD
---

# [Title]

[User's content, formatted appropriately]
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

## Example Usage

User says: "Create a note about the new API authentication flow we discussed"

1. Scan tags, find existing: `api`, `authentication`, `architecture`, `documentation`
2. Title: "API Authentication Flow"
3. Tags: `from-claude`, `api`, `authentication`
4. Filename: `api-authentication-flow.md`

Result:
```markdown
---
tags:
  - from-claude
  - api
  - authentication
created: 2025-01-22
---

# API Authentication Flow

[Content about the authentication flow as described by user]
```

## Important Notes

- NEVER overwrite an existing note - check if filename exists first
- If filename exists, append a number: `note-title-2.md`
- Report back to the user with the note title and location
