---
name: my-git-commit
description: Create a Git commit or draft a commit message in Conventional Commits format, preserving useful reasoning in optional typed context lines. Use when the user asks to commit changes or prepare or review a Conventional Commits message.
---

# My Git Commit

Follow this skill when committing or drafting a commit message, and obey the applicable `AGENTS.md` instructions. Do not run `git push` or `git rm`. If those commands are needed, give them to the user.

## Modes

- For an explanation, review, or message draft, return the proposed message without staging files or creating a commit.
- Stage and commit only when the user explicitly requests a commit or an existing approval clearly includes those operations.

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
- When the body has multiple paragraphs or context lines, pass each one with a separate `-m` option. Do not write newline escape sequences such as `\n` or `¥n`.
- Do not change a read-only or prohibited location without explicit authorization for that exception. For a normally unchanged location, follow the workspace's exception conditions. Recording a reason does not grant permission.
- Record the reason for an authorized exception in the work report and, when committing the change, in the commit body.

## Context lines

When the session contains reasoning that the diff cannot show, add only the applicable typed lines to the body:

| Type | Capture |
|---|---|
| `intent(scope)` | What the user wanted and why |
| `decision(scope)` | A chosen approach and the reason it won |
| `rejected(scope)` | A considered alternative and why it was rejected |
| `constraint(scope)` | A non-obvious boundary that shaped the change |
| `learned(scope)` | A discovered fact that will prevent future rework |

- Format each entry as one line: `type(scope): description`. Use lowercase letters, digits, and internal hyphens for a non-empty scope from the project's vocabulary, consistently across commits. It may differ from the subject scope.
- Context lines are optional. Omit them for trivial changes or when they would only restate the diff.
- Use evidence from the request, discussion, and observed work. Reflect the user's purpose in `intent`, always give a reason in `rejected`, and do not fabricate unavailable context. Without conversation context, use `decision` only when the technical choice and useful reasoning are clearly evidenced without speculation; do not infer the other types from the diff.
- The subject and body must accurately cover every change included in the commit. Keep unrelated changes out, and leave unknown reasoning unstated rather than guessing.

## Steps

1. Check what belongs to the request with `git status`, `git diff`, and `git diff --cached`. Existing staged content is a candidate scope, not permission to include changes outside the request.
2. In draft mode, return the proposed subject and body without Git writes.
3. In commit mode, `git add` only the related files, then run `git commit` with the subject and each body paragraph or context line passed as a separate `-m` option.
4. If a push is needed, do not run it. Give the user the `git push` command, then continue any independent work still in scope.
