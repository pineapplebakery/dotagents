---
name: my-work-plan
description: Decide whether work needs a dated Markdown plan under docs/plans/, then create and update it when required. Use as the planning child of my-implement, or independently for coordinated deliverables or phases, behavior or configuration changes with unresolved design choices, long-running or resumable work, or an explicit plan request. Do not invoke independently for read-only analysis, comment, typo, or docs-only edits, or a single obvious fix unless a plan is explicitly requested.
---

# My Work Plan

Pin the request, goal, steps, evidence, and next action in Markdown under `docs/plans/`. After a conversation break, the same file alone should be enough to resume.

## When to use

When `my-implement` delegates planning, apply these criteria even when the result is to skip the plan file. For independent use, use this skill when at least one of these applies:

- The request has multiple deliverables or dependent phases that must stay coordinated
- A caller-visible behavior or configuration will change and requires coordinated steps or a non-obvious choice
- A name, default, or behavior split still has to be chosen
- The work is long-running, may wait on a dependency or approval, or must be resumable after interruption
- The user asks to make the plan, progress, or remaining work explicit

If the user says a plan is not needed, skip it. Otherwise, an explicit plan request overrides the remaining skip conditions. Without an explicit request, skip the plan file when:

- The work is incidental inspection, a comment/typo/docs-only edit, or a single obvious fix with no remaining design choice
- The request is a read-only review or analysis and the user did not ask for a plan file

Skipping the plan file does not skip deciding. Before editing, put the observable done-when conditions in the first progress update and include any non-obvious assumption. If an unspecified choice would materially affect the result, ask before editing; otherwise choose a reasonable default and state it when relevant.

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

Progress updates **overwrite the current plan file**. Chat may summarize, but `docs/plans/` is the source of truth.

## Required sections

Do not use vague "later" or "mostly done". Include all of the following every time.

| Section | What to write |
|---|---|
| Request | The gist of the instruction that created this plan. What, how far, and constraints. Do not paste the full prompt |
| Goal | What the work is for (1–2 sentences) |
| Done when | What must be observable to finish. Include how to verify (test names, commands) |
| Steps | **Numbered**. Give each step a status and add evidence when done or the dependency when blocked |
| Next action | One concrete next action. Note waits or dangerous operations if any |

Use `Steps` as the single source of truth for progress. The `in progress` step is the current work, `done` steps contain completed work and evidence, and `pending` or `blocked` steps are the remaining work. Do not repeat them in separate Current, Completed, or Remaining sections. Include a `Design choices` section only when the work has actual decisions worth preserving; keep those decisions in this plan unless they meet the ADR criteria below.

## Writing rules

- Write for a reader with no prior context. Do not rely on pronouns alone (avoid "that", "the previous one").
- Summarize the user's instruction in Request. Do not substitute the agent's own restatement of goal or done-when. Do not paste the prompt or system text.
- If the request changes mid-work, update Request and leave one sentence on what changed.
- When present, Design choices record what you picked and why, including useful evidence or rejected options. Keep work-local choices in the plan. If a choice meets the ADR criteria below, write an ADR and link it from the plan.
- Make steps executable units (example: "Add a regression test for cache invalidation in `tests/test_cache.py`").
- Use these status words: `pending` / `in progress` / `done` / `blocked` / `skipped` (give a reason when skipped).
- Keep at most one step `in progress` at a time. Add paths, check results, or a concise command-result gist to a step when it becomes `done`.
- Separate guess from confirmed fact. Mark unconfirmed items as "unconfirmed: …".
- On update, make the whole file current. Do not leave the file stale after reporting a diff in chat.
- This skill is the source of truth for plan criteria, format, location, and update timing. `AGENTS.md` owns shared skill routing and the invariant of where plans live.

## When to update

1. **Before substantive work**: apply the usage and skip criteria. If a plan for this request exists, update it. If none exists and skip applies, do not create one; follow the pre-edit rule above. Otherwise, create the plan with the request, goal, done-when conditions, steps, and next action.
2. **After meaningful progress**: update the affected step's status and evidence, then set the next action. Do not rewrite the file for every minor command.
3. **When blocked or redirected**: record the missing dependency or decision in the affected step, update the request when its scope changed, and set the next action.
4. **When finished**: record every step's final status and evidence that the done-when conditions are met, set the plan status to `done`, and set the next action to `none`.

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

## Steps

1. [pending] …
2. [pending] …
3. [pending] …

## Next action

- Next: …
- Notes: (or "none")
```

Add this section only when the work has decisions worth preserving:

```markdown
## Design choices

- (Decision and why it was chosen)
```

## When to write an ADR

This skill records planning decisions and ADRs. It does not define code-level design or implementation procedures.

Do not copy the plan's Design choices. Write to `docs/adr/` only when one of these applies:

- The decision establishes a long-lived project boundary, public API or external contract, or external integration policy
- The decision is expensive to change or difficult to reverse
- A strong rejected option must be recorded to prevent costly reconsideration
- The workspace requires an ADR for the decision

Keep local Why in a code comment. Keep local, easily changed choices in the plan's Design choices. Do not create a dedicated ADR skill.

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
