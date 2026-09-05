# dotagents

This repository manages agent instructions and skills shared across multiple workspaces.

Place this repository at `.agents/` in a workspace, and keep project-specific instructions in the workspace-root `AGENTS.md`. Shared guidance lives in [myAGENTS.md](myAGENTS.md), while detailed workflows live in [skills/](skills/).

## File responsibilities

| File | Include | Exclude |
|---|---|---|
| `.agents/myAGENTS.md` | Judgment, working, verification, and Git guidance shared by every workspace | Technology choices, project paths, commands, and domain knowledge |
| Workspace `AGENTS.md` | Project-specific structure, boundaries, references, verification path, output language, and permissions | A copy of shared guidance, long procedures, and temporary requests |
| Workspace `README.md` | Setup, usage, testing, build, and data instructions for people and agents | Agent-only permissions and prohibitions |
| `.agents/skills/*/SKILL.md` | Detailed procedures needed only for a particular type of work | Project-specific structure and commands |

Do not duplicate guidance across files. Keep `AGENTS.md` focused on project invariants, the output language, the verification path an agent should choose, and links to supporting documentation. Put detailed commands in the workspace `README.md` and task-specific methods in skills.

## Workspace installation

Expected layout:

```text
workspace/
|-- AGENTS.md
|-- README.md
`-- .agents/
    |-- myAGENTS.md
    |-- skill-install.sh
    `-- skills/
```

To install third-party skills, run this command from the workspace root:

```bash
bash .agents/skill-install.sh
```

Start the workspace `AGENTS.md` with an explicit instruction to read the shared guidance:

```markdown
# Agent Instructions

Read `.agents/myAGENTS.md` first and follow its shared instructions.
When these instructions conflict with workspace-specific instructions in this file, follow this file.
```

The Codex documentation does not specify a file expansion syntax such as `@.agents/myAGENTS.md`. Codex automatically discovers `AGENTS.md`, `AGENTS.override.md`, and configured fallback filenames, so use a natural-language instruction to read the shared file. To use only the standard Codex hierarchy, place shared instructions in `~/.codex/AGENTS.md` and project-specific instructions in the workspace-root `AGENTS.md`. See the [official OpenAI AGENTS.md guide](https://developers.openai.com/codex/guides/agents-md) for details.

## Inspect before writing

Before writing `AGENTS.md`, inspect the items that exist in the workspace instead of guessing:

1. The root `README.md` and developer documentation
2. Package manifests, dependency files, and lock files
3. Test, lint, type-check, and build commands in CI configuration
4. Locations for source, tests, configuration, documentation, generated files, and externally maintained code
5. `.gitignore` and the artifacts that should or should not be committed
6. Tasks that require network access, external services, data, or specialized hardware
7. Existing `AGENTS.md`, `AGENTS.override.md`, architecture documents, and glossaries
8. The language expected for user-facing agent responses

Do not turn unverified information into a rule. If missing information is essential for safe changes or verification, ask the repository owner before considering the instructions complete. Omit optional items entirely.

## Creation workflow

1. Inspect the sources listed above and identify the relevant documentation and CI configuration.
2. Collect only project-specific information that materially affects agent decisions.
3. Copy the template below to `AGENTS.md` at the workspace root.
4. Fill in verified values and references, then remove unused lines and all placeholders.
5. Check that shared guidance and long procedures are not duplicated.
6. Use the completion checklist and verify instruction loading in a new Codex session.

## What to include in workspace AGENTS.md

Keep the workspace file concise and easy to review. Do not create a separate section for every possible concern; include only information needed to make decisions in that project.

### 1. Purpose and references

- Describe the project purpose and primary deliverables in one or two lines.
- Specify the language for user-facing agent responses.
- Link to `README.md` for setup and usage, manifests and lock files for dependencies, and existing documents for architecture or terminology.
- Do not repeat technology overviews or long procedures.

### 2. Change boundaries

- Summarize locations that may be changed, locations that are normally unchanged, and generated artifacts that must not be committed.
- Do not enumerate every directory. Include only paths where the rules affect whether or how an agent may change them.
- Treat read-only or prohibited locations separately from locations that are normally unchanged. A read-only or prohibited location requires explicit authorization for that exception. For a normally unchanged location, follow the exception conditions defined by the workspace.
- Recording a reason does not grant permission. Record the reason for an authorized exception in the work report and, when the change is committed, in the commit body.

### 3. Verification

- Briefly state the order for focused tests, related tests, the full suite, and static checks or builds.
- If commands are already documented in `README.md` or CI configuration, link to that section or file. Otherwise, provide runnable commands.
- Mention prerequisites only for checks that require a network, external data, specialized hardware, or a long runtime.

### 4. Project-specific constraints

- State operations that require confirmation and operations the agent must not perform.
- Record contracts that are difficult to infer from code, such as public APIs, configuration formats, labels, or units.
- Do not repeat shared guidance about dependencies, secrets, Git, work plans, or testing.

When only one subtree needs different instructions, place a short `AGENTS.md` or `AGENTS.override.md` in that directory instead of accumulating exceptions in the root file.

## Copyable template

This template is intentionally compact. Remove unused lines and do not leave bracketed placeholders in the finished file.

```markdown
# Agent Instructions

Read `.agents/myAGENTS.md` first and follow its shared instructions.
When these instructions conflict with workspace-specific instructions in this file, follow this file.

## This workspace

- Purpose: [What this project creates or verifies]
- Deliverables: [Library, service, CLI, model, documentation, or other output]
- Output language: [Language for user-facing agent responses]
- Setup and usage: `README.md`
- Dependencies: [Manifest and lock-file paths]
- Architecture and terminology: [Reference, or remove this line]

## Change boundaries

| Path | Role and change rule |
|---|---|
| `[path]` | [Normally editable, normally unchanged, read-only, prohibited, or generated] |

Do not modify a read-only or prohibited path without explicit exception authorization. For a normally unchanged path, follow the workspace's exception conditions. Recording a reason is not authorization. Record an authorized exception in the work report and, when committed, in the commit body.

## Verification

- Focused tests: [Reference or `command`]
- Related tests: [Reference or `command`]
- Full suite: [Reference or `command`]
- Static checks and build: [Reference or `command`]
- Excluded from routine verification: [Long-running or external task, or remove this line]

## Workspace-specific constraints

- Do not commit: [Generated artifacts, data, caches, or other files]
- Confirm first: [Areas or operations, or remove this line]
- Agent must not run: [Operations, or remove this line]
- Preserve this contract: [Public API, configuration, or domain definition, or remove this line]
```

## What the workspace README.md should contain

The project `README.md` should contain at least the following so `AGENTS.md` can link to it:

1. Project purpose and primary deliverables
2. Supported runtime environment and prerequisite software
3. Initial setup and dependency synchronization
4. A minimal usage example
5. Commands for focused tests, the full suite, linting, type checking, and builds
6. Required environment variable names and setup instructions without secret values
7. Locations and acquisition methods for data, generated artifacts, and caches
8. Responsibilities of major directories
9. Prerequisites such as external services or specialized hardware
10. Common failures and recovery steps

Update `README.md` when operational procedures change. Update `AGENTS.md` when the output language, agent permissions, prohibitions, or change boundaries that cannot be inferred from code change.

## Completion checklist

Review the workspace `AGENTS.md` against these conditions:

- The file starts with the shared-instruction reference.
- The required output language is explicit.
- The project-specific purpose, references, and boundaries are clear.
- The verification references and order are clear, and commands written in the file can be run as-is.
- Normally unchanged areas and their exception conditions are clear.
- Untracked artifacts and data are identified.
- Confirmation requirements for long-running, high-cost, or externally visible operations are clear.
- Shared instructions and skills are not duplicated.
- The file contains no nonexistent paths, unverified commands, secret values, or unused placeholders.
- Subdirectory-specific exceptions are not accumulated in the root file.

To verify with Codex, run this command from the workspace root:

```bash
codex --sandbox read-only --ask-for-approval never "Summarize the instruction files you loaded, the required output language, this workspace's change boundaries, and its verification commands."
```

If the shared guidance is missing from the summary, check the reference in the root `AGENTS.md`, the location of `.agents/myAGENTS.md`, and that the Codex session is new.
