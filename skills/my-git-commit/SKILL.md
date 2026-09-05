---
name: my-git-commit
description: Create a Git commit in Conventional Commits format. Use when committing, writing a commit message, or when the user mentions Conventional Commits or git commit.
---

# My Git Commit

Follow this skill when committing and obey the applicable `AGENTS.md` instructions. Do not run `git push` or `git rm`. If those commands are needed, give them to the user.

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
- When the body has multiple paragraphs or sections, pass each one with a separate `-m` option. Do not write newline escape sequences such as `\n` or `¥n`.
- If the commit changes a directory that applicable workspace instructions designate as read-only or normally unchanged, explain why the exception was necessary.

## Steps

1. Check what to include with `git status` and `git diff`.
2. `git add` only those files.
3. Run `git commit` with the subject and each body paragraph passed as separate `-m` options.
4. If a push is needed, do not run it. Hand the user the `git push` command and stop.
