---
name: obsidian
description: Background knowledge about Obsidian note-taking app features and conventions
user-invocable: false
---

# Obsidian Knowledge

You have access to the user's Obsidian vault. Obsidian is a Markdown-based knowledge management application that stores notes as local `.md` files.

## Core Concepts

### Markdown Files
- All notes are plain text Markdown files (`.md`)
- Notes are stored locally, giving users full data ownership
- The vault is simply a folder containing these Markdown files

### Frontmatter (YAML)
Notes can have YAML frontmatter at the top for metadata:

```markdown
---
tags:
  - project
  - important
date: 2025-01-22
author: Claude
---

# Note Title

Content here...
```

Common frontmatter fields: `tags`, `date`, `created`, `modified`, `aliases`, `cssclass`

### Tags
- Inline tags: Use `#tag-name` anywhere in the note body
- Frontmatter tags: Listed in the `tags:` array in frontmatter
- Nested tags: `#parent/child` creates hierarchical organization
- Tags are used for categorization and filtering

### Internal Links
- Wiki-style links: `[[Note Name]]` links to another note
- Links with aliases: `[[Note Name|Display Text]]`
- Heading links: `[[Note Name#Heading]]`
- Block links: `[[Note Name^block-id]]`

### Daily Notes
- Time-based notes for journaling, tasks, and logging
- Typically named by date (e.g., `2025-01-22.md`)
- Often stored in a dedicated folder like `daily/`
- Great for append-only logging and task tracking

### Folder Structure
- Vaults can use folders for organization
- Many users prefer flat structure with tags and links instead
- The `.obsidian/` folder contains app settings and plugins

### Graph View
- Visual representation of note connections
- Nodes = files, Edges = links between notes
- Helps discover relationships between ideas

### Templates
- Reusable note structures
- Can include dynamic variables like dates
- Typically stored in a `templates/` folder

## Best Practices When Working with Vault

1. **Preserve existing structure**: Don't reorganize without permission
2. **Use existing tags**: Prefer existing tags over creating new ones
3. **Maintain frontmatter format**: Keep consistent YAML structure
4. **Respect link integrity**: Don't break existing internal links
5. **Daily notes are append-only**: Add to the end, don't modify earlier entries
6. **Use descriptive filenames**: Note titles become filenames
