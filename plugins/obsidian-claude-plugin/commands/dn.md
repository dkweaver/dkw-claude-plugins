# Daily Note

Add content to today's daily note in the Obsidian vault.

Use the Task tool to delegate this to the vault-agent:

```
Task tool with:
- subagent_type: "obsidian-claude-plugin:vault-agent"
- prompt: The instructions below
```

## Instructions for vault-agent

1. Read config from `~/.claude/plugins/obsidian-claude.config` to get VAULT_PATH
2. If config doesn't exist, tell user to run `/obsidian-claude-plugin:setup` first
3. Get today's date (YYYY-MM-DD) and current time (HH:MM)
4. Check if `{VAULT_PATH}/daily/{TODAY}.md` exists
5. If NOT exists, create it with:
   ```markdown
   ---
   tags:
     - daily-note
   date: {TODAY}
   ---

   # {TODAY}

   ## Log

   - {TIME} - {user's content from $ARGUMENTS}
   ```
6. If EXISTS, append to end:
   ```markdown
   - {TIME} - {user's content from $ARGUMENTS}
   ```

User's content: $ARGUMENTS
