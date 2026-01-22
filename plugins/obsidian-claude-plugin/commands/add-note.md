# Add Note

Create a new note in the Obsidian vault with an appropriate title and tags.

Use the Task tool to delegate this to the vault-agent:

```
Task tool with:
- subagent_type: "obsidian-claude-plugin:vault-agent"
- prompt: The instructions below
```

## Instructions for vault-agent

1. Read config from `~/.claude/plugins/obsidian-claude.config` to get VAULT_PATH
2. If config doesn't exist, tell user to run `/obsidian-claude-plugin:setup` first
3. Get today's date (YYYY-MM-DD)
4. Scan vault for existing tags using Grep
5. Determine an appropriate title based on the content (2-6 words, title case)
6. Convert title to filename (lowercase, hyphens, no special chars)
7. Check if file exists, if so append number (-2, -3, etc.)
8. Create note at `{VAULT_PATH}/{filename}.md`:
   ```markdown
   ---
   tags:
     - from-claude
     - {relevant-existing-tags}
   created: {TODAY}
   ---

   # {Title}

   {user's content from $ARGUMENTS}
   ```
9. Report back with note title and location

User's content: $ARGUMENTS
