# Work plan: Apply instruction review decisions

- Created: 2026-09-05
- Status: done

## Request

- Apply the decisions made for the adversarial review of the shared instructions and maintained Skills. Preserve the findings explicitly rejected by the user, and do not modify gitignored third-party Skills.
- The user later requested a numbered decision table with rationale so each finding remains understandable without the review conversation.

## Goal

Remove ambiguous permissions, duplicated progress records, overbroad triggers, and project-specific assumptions while preserving the user's pytest, documentation, and test-purpose conventions.

## Done when

- [x] Adopted findings 2-5, 7-11, 14, and 16-18 are reflected in the maintained instructions and metadata.
- [x] Finding 13 is applied as a soft function-length heuristic without mandatory comments.
- [x] Rejected findings 1, 6, 12, and 15 remain unchanged in substance.
- [x] All maintained Skills pass structural validation and the final diff has no whitespace errors or unintended third-party changes.
- [x] A numbered table records every finding, its disposition, rationale, and affected files.

## Review decisions

| No. | Finding | Decision | Rationale | Reflected in |
|---:|---|---|---|---|
| 1 | Pytest has no fallback | No change | Pytest is an intentional prerequisite. Keeping approval before adding it prevents an unavailable dependency from silently changing the workspace setup. | Existing `skills/my-test/SKILL.md` policy retained |
| 2 | Approval continuation is undefined | Adopt | Reusing approval for the same target, operation, impact, and conditions avoids redundant confirmation without extending authority. Independent safe work can continue while approval is pending. | `myAGENTS.md` |
| 3 | Full tests and broad Ruff scope are always implied | Adopt | Workspace-required checks must still run, but otherwise verification should widen according to impact and risk. This avoids unrelated failures and unnecessary edits while preserving evidence. | `myAGENTS.md`, `skills/my-test/SKILL.md`, `skills/my-implement/SKILL.md` |
| 4 | Test execution and code-changing TDD are not separated | Adopt | A run-or-analyze request does not authorize edits or fixes. TDD applies only when code changes are part of the request. | `skills/my-test/SKILL.md` |
| 5 | Commit-message drafting and creating a commit are not separated | Adopt | Mentioning Git or requesting a draft is not permission to stage or commit. Git writes now require an explicit commit request or applicable existing approval. | `myAGENTS.md`, `skills/my-git-commit/SKILL.md`, its `agents/openai.yaml` |
| 6 | “Confirm” could mean self-check or user confirmation | No change | In context, checking whether a change is needed is a self-check, while user authorization is consistently described as approval or confirmation before an operation. Additional wording would add little decision value. | Existing wording retained |
| 7 | Work-plan activation is too broad | Adopt | Incidental inspection, editing, and verification steps should not create a plan by themselves. Plans are now for multiple deliverables, dependent phases, long-running or resumable work, or explicit requests. | `skills/my-work-plan/SKILL.md` and its `agents/openai.yaml` |
| 8 | Read-only and normally unchanged locations are conflated | Adopt | Recording a reason cannot grant permission. Read-only or prohibited locations require explicit exception authorization; normally unchanged locations follow workspace-defined exception conditions. | `README.md`, `skills/my-git-commit/SKILL.md` |
| 9 | Refactoring can be forced to start with a failing test | Adopt | Behavior-preserving refactoring should begin from passing coverage. Characterization tests are needed only when existing tests do not adequately protect the behavior. | `skills/my-test/SKILL.md` |
| 10 | A plan repeats progress in several sections | Adopt | `Steps` can retain current, completed, remaining, evidence, and blocker information in one place. Keeping `Next action` separately preserves resumability without synchronization overhead. | `skills/my-work-plan/SKILL.md` |
| 11 | Design principles repeat the same rule under different names | Adopt | Repeated KISS/YAGNI/SOLID/Open-Closed descriptions increase interpretation cost. The text now uses actionable rules while retaining distinct constraints for interfaces, extension points, composition, fail-fast behavior, and evidence-based optimization. | `skills/my-implement/SKILL.md` |
| 12 | General principles overlap between shared and Python instructions | No standalone change | The overlap is intentional layering: `myAGENTS.md` owns cross-workspace judgment, while `my-implement` gives Python-specific application rules. Only the internal duplication identified in No. 11 was consolidated. | Existing ownership retained |
| 13 | Function line-count guidance creates mechanical work | Partial adopt | The 30/50-line figures remain useful review signals, but they are not split thresholds. A Why comment is required only for a non-obvious constraint, not merely because a function is long. | `skills/my-implement/SKILL.md` |
| 14 | ADR creation criteria are too broad | Adopt | ADRs should capture durable boundaries, contracts, external integration policy, expensive-to-reverse choices, or significant rejected alternatives. Local and easily changed choices belong in the work plan. | `skills/my-work-plan/SKILL.md` |
| 15 | Test-purpose statements can duplicate test names | No change | The user prioritizes future readers and newly assigned maintainers. A concise purpose statement at the start of each test module or group is therefore retained even when names are already descriptive. | Existing `skills/my-test/SKILL.md` rule retained |
| 16 | Shared Skills assume runtime/offline/dataset project structure | Adopt | Shared instructions should express ownership and independent expectations without inventing project-specific paths. Concrete runtime or data boundaries belong in the relevant workspace instructions. | `skills/my-implement/SKILL.md`, `skills/my-test/SKILL.md` |
| 17 | `uvx ruff` can retrieve an external package implicitly | Adopt | Verification must not silently install or download tooling. Use the workspace command or existing project Ruff; external retrieval requires approval, and unavailable Ruff is reported. | `skills/my-implement/SKILL.md` |
| 18 | README contains stale fixed instruction line counts | Adopt | Exact counts become incorrect as instructions evolve and encourage editing to a quota. Qualitative concision and reviewability are the stable requirements. | `README.md` |

## Design choices

- Keep `my-implement` Python-specific and keep pytest as the required test framework, as the user decided.
- Consolidate repeated design principles without removing the concrete interface, extension-point, composition, fail-fast, or measurement rules.
- Store work-local design decisions in the plan; reserve ADRs for durable or expensive-to-change decisions.

## Steps

1. [done] Mapped the accepted decisions to `myAGENTS.md`, `README.md`, the four maintained Skills, and their UI metadata. Confirmed the worktree was clean at commit `43acb3c` before changes and read the complete `skill-creator` instructions and `openai.yaml` reference.
2. [done] Updated `myAGENTS.md`, `README.md`, and the four maintained Skills. Synchronized affected `agents/openai.yaml` metadata, preserved pytest-only testing and test-purpose statements, and left third-party Skills unchanged.
3. [done] Validated all four maintained Skill frontmatters and `agents/openai.yaml` files with the existing Ruby YAML parser, confirmed the adopted and rejected rule markers, and passed `git diff --check`. The bundled validator could not start because PyYAML is not installed, so no dependency was added; the equivalent validations from its source passed. The changed-file list contains no gitignored third-party Skill.
4. [done] Added the numbered review-decision table with rationale and file-level traceability to this plan.

## Next action

- Next: none.
- Notes: the bundled `quick_validate.py` was not run to completion because its PyYAML dependency is unavailable; equivalent structural checks passed without installing it.
