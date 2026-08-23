---
name: my-work-plan
description: Create and update multi-step work plans as dated Markdown files under docs/plans/. Use for implementation, investigation, training/eval, debugging, or refactoring when you need to record steps, progress, completion, and remaining work.
---

# My Work Plan

Pin the request, goal, steps, and progress in Markdown and save it under `docs/plans/`. After a conversation break, the same file alone should be enough to resume.

## When to use

- Work with **two or more** steps
- Work that mixes investigation and implementation
- Training, evaluation, data prep, or other work that takes time or waits on confirmation
- When the user asks to make the plan, progress, or remaining work explicit

Skip when:

- A one-command or one-file fix where a completion report is enough
- The user says a plan is not needed

## Location and filename

| Item | Rule |
|---|---|
| Directory | `docs/plans/` (create it if missing) |
| Filename | `YYYY-MM-DD-<short-slug>.md` |
| Date | The **day the plan was created** (local date). Do not change the date in the filename on later updates |
| Slug | Lowercase letters, digits, hyphens. A short identifier for the work (example: `cache-debugging`) |
| Collision on the same day | Change the slug, or append `-2` and so on |

Examples:

- `docs/plans/2026-08-22-api-refactor.md`
- `docs/plans/2026-08-22-cache-debugging.md`

Create the file when you start. Later progress updates **overwrite the same file**. Chat may summarize, but `docs/plans/` is the source of truth.

## Required sections

Do not use vague "later" or "mostly done". Include all of the following every time.

| Section | What to write |
|---|---|
| Request | The gist of the instruction that created this plan. What, how far, and constraints. Do not paste the full prompt |
| Goal | What the work is for (1–2 sentences) |
| Done when | What must be observable to finish. Include how to verify (test names, commands) |
| Design choices | Decisions taken in this work and why. Write "none" if there are none. Binding decisions go to an ADR |
| Steps | **Numbered**. What to do, in what order, against which artifact or boundary |
| Current | Which step number you are on. If in progress, what you are doing |
| Completed | Finished steps. Each item needs evidence (paths, test results, command-result gist) |
| Remaining | Steps not started or not finished. Note dependencies or blockers |
| Next action | One concrete next action. Note waits or dangerous operations if any |

## Writing rules

- Write for a reader with no prior context. Do not rely on pronouns alone (avoid "that", "the previous one").
- Summarize the user's instruction in Request. Do not substitute the agent's own restatement of goal or done-when. Do not paste the prompt or system text.
- If the request changes mid-work, update Request and leave one sentence on what changed.
- Design choices record what you picked and why (evidence, rejected options). Keep work-local choices in the plan. If they bind later work, write an ADR and link it from the plan.
- Make steps executable units (example: "Add a regression test for cache invalidation in `tests/test_cache.py`").
- Use these status words: `pending` / `in progress` / `done` / `blocked` / `skipped` (give a reason when skipped).
- Separate guess from confirmed fact. Mark unconfirmed items as "unconfirmed: …".
- On update, make the whole file current. Do not leave the file stale after reporting a diff in chat.
- This skill is the source of truth for format, location, and when to update. `AGENTS.md` only records the invariant of where plans live.

## When to update

1. **Before starting**: create `docs/plans/YYYY-MM-DD-<slug>.md` and write request, goal, done-when, design choices, and steps before implementation.
2. **After each step**: move it to Completed and update Current, Remaining, and Next action.
3. **When blocked**: write what is missing and whose or what decision you are waiting on in Remaining and Next action.
4. **When finished**: record every step's status and the evidence that done-when is met, then close the plan.

## Template

New file skeleton:

```markdown
# Work plan: <title>

- Created: YYYY-MM-DD
- Status: in progress | done | blocked

## Request

- (What, how far, constraints. Do not paste the full prompt.)

## Goal

(1–2 sentences)

## Done when

- [ ] (Observable condition and how to verify)

## Design choices

- (or "none")

## Steps

1. [pending] …
2. [pending] …
3. [pending] …

## Current

- Step N: (what is in progress / if none: "pending. Next is step 1")

## Completed

- (or "none")

## Remaining

- (step numbers and content; reason if blocked)

## Next action

- Next: …
- Notes: (or "none")
```

## When to write an ADR

Do not copy the plan's Design choices. Write to `docs/adr/` only when one of these applies:

- It binds later implementation, configuration, an external integration, or a public interface
- Other work will treat it as a given
- A strong rejected option exists and you need to prevent revisiting it

Keep local Why in a code comment. Keep choices that apply only to this work in the plan's Design choices. Do not create a dedicated ADR skill.

| Item | Rule |
|---|---|
| Filename | `docs/adr/NNNN-short-slug.md` (4-digit sequence) |
| Required | Status, date, context, decision, consequences |
| Relation to the plan | Link from the plan's Design choices |

Skeleton:

```markdown
# ADR NNNN: <title>

- Status: accepted
- Date: YYYY-MM-DD

## Context

## Decision

## Consequences
```

## Relation to other skills

- Follow [my-implement](../my-implement/SKILL.md) when coding.
- Follow [my-test](../my-test/SKILL.md) for how to test.
- This skill covers creating, saving, and updating the work plan, and recording binding decisions as ADRs. It does not replace the design workflow in [my-implement](../my-implement/SKILL.md).

## Hook into the implement skill

For multi-step implementation or fixes, update the plan file with this skill before and after `implement` work. Do not make large changes without a plan file.
