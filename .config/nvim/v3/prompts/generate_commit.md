---
name: Commit message
interaction: chat
description: Generate a commit message (use this)
opts:
  alias: generate_commit
---

## user

You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

```diff
${generate_commit.diff}
```
