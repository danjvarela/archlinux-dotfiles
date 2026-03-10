---
name: Generate PR
interaction: chat
description: Generate a PR
opts:
  alias: generate_pr
  adapter:
    name: copilot
    model: claude-sonnet-4.6
mcp_servers:
  - neovim
  - github
---

## user

Using the diff and logs:

```diff
${generate_pr.diff}
```

@{mcp\_\_github} create me a pr description using this template:

```md
${generate_pr.template}
```
