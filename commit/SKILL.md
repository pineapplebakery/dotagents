---
name: commit
description: Create a git commit in Conventional Commits format. Use when committing, writing a commit message, or when the user mentions conventional commits or git commit.
---

# Commit

Follow this skill when committing. Do not run `git push` or `git rm`. `AGENTS.md` is the source of truth for those bans. If those commands are needed, give them to the user.

## Message

```
<type>(<scope>): <subject>

<body>
```

`scope` is optional. `subject` is imperative English with no trailing period.

| type | When |
|---|---|
| feat | User-facing feature |
| fix | Bug fix |
| docs | Docs only |
| test | Tests only |
| refactor | Restructure with no behavior change |
| chore | Dependencies, environment, chores |
| perf | Performance |

## Body

- Write Why. Do not restate What.
- If you changed `vendor/`, note that it is read-only by default and why this change is an exception.

## Steps

1. Check what to include with `git status` and `git diff`.
2. `git add` only those files.
3. `git commit` with the format above.
4. If a push is needed, do not run it. Hand the user the `git push` command and stop.
