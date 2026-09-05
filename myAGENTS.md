# Shared Agent Instructions

Keep only guidance that applies across workspaces in this file. Put project-specific structure, technology, verification, artifacts, output language, and permissions in the workspace `AGENTS.md`, or link to the relevant documentation from there. Workspace-specific instructions take precedence when instructions conflict.

## Communication and judgment

- Communicate concisely, directly, and candidly.
- Distinguish verified facts from assumptions. Do not present unverified information as fact.
- Before starting, define observable conditions that determine completion. Ask questions only when unclear conditions would materially affect the result.
- Confirm before making decisions that are destructive, externally visible, or require broader permissions.
- Within the same request, reuse an approval only while its target, operation, impact, and applicable conditions remain unchanged. Confirm again when any of them changes. While approval is pending, continue independent work that is safe and already authorized. This does not replace approval required by the execution environment.

## Working principles

- Before starting, inspect the workspace `AGENTS.md`, relevant documentation, the files to change, and their callers.
- Choose the simplest implementation that meets the current requirements. Confirm that each change is needed for the completion conditions, and do not introduce abstractions only for possible future use.
- Keep changes small and focused on the request. Do not leave unnecessary new files or dead code. Preserve unrelated user changes.
- Follow the existing structure, naming, language, and tools. Treat conventions explicitly defined in this file or an applicable `my-*` skill as established; do not introduce other conventions without approval.
- Use comments to explain reasons or constraints that are not evident from the code. Do not add comments that merely restate the implementation.
- Before adding a dependency, check whether existing dependencies or standard features can solve the problem. Obtain user approval before adding dependencies.
- Do not output, record, or commit credentials, private keys, tokens, or other secrets.
- Do not commit generated artifacts or large data unless the workspace explicitly identifies them as tracked files.
- When work requires a plan, follow the `my-work-plan` skill and keep the plan in `docs/plans/`.
- If the same failure recurs, propose a rule that prevents it. Put workspace-specific rules in that workspace's `AGENTS.md`; add only cross-workspace rules to this file.

## Verification

- Before claiming completion, verify the result with observable evidence proportionate to the change, such as tests, static checks, and diff review. State which checks were not run.
- If a required check is not run or does not pass, distinguish "implementation complete" from "verification complete" in the report. Unless applicable instructions explicitly exempt the check, do not treat it as optional or claim that the completion conditions are met. Continue any independent checks that can still run.
- Run checks required by the workspace regardless of change size. Otherwise, start with focused, fast checks and widen them according to the affected surface and risk. Avoid network access and external data where practical, and make randomized verification reproducible across runs.
- Do not modify unrelated code or expected values to resolve pre-existing failures. Report those failures separately and continue independent checks when possible.
- Confirm the need and execution conditions before running operations that take a long time, cost money, use substantial compute, or download large files.
- Do not change configuration or expected values without evidence merely to make checks pass.
- If no test infrastructure exists, do not create it without a request. Verify with available methods and propose new infrastructure if needed.
- For new behavior and bug fixes, when suitable test infrastructure exists, first capture the expected behavior in a test.

## Git

- Before committing, inspect `git status` and the diff, and stage only files related to the request.
- Use Conventional Commits messages and follow the `my-git-commit` skill for details.
- Do not run `git push` or `git rm`. When needed, provide the command for the user to run.
- Rewrite history or perform operations that are difficult to recover from only when the user explicitly requests them.

## Skills (read only when needed)

Use a skill only when its file exists.

For Python production-code changes, use `my-implement` as the parent workflow when it exists. It delegates planning to `my-work-plan`, which defines the request, goal, done-when conditions, steps, and next action; `my-work-plan` records and maintains that plan under `docs/plans/` when a plan file is warranted, while still requiring lightweight planning when no file is created. It delegates TDD and test verification to `my-test`. The parent loads the child instructions; child workflows do not reload the parent. Do not use `my-test` independently to change production code while `my-implement` is available. Use `my-work-plan` independently for planning outside Python changes, and use `my-test` independently for test-only changes (including adding or correcting tests), test execution, or test analysis.

When `ponytail` is also active for a Python code change, `my-work-plan`, `my-implement`, and `my-test` take precedence for planning, implementation workflow, test framework and TDD, staged verification, ruff, and docstrings. Apply `ponytail` only to implementation simplicity within those requirements; do not use its minimal-check policy to weaken them.

Use `ponytail-review` and `ponytail-audit` only when the user explicitly asks for an overengineering or complexity review. They do not replace a general review for correctness, regressions, security, performance, or test coverage.

| Skill | When to use it | Path |
|---|---|---|
| my-work-plan | Define the work plan and, when needed, record and update it in `docs/plans/` | `.agents/skills/my-work-plan/SKILL.md` |
| my-git-commit | Draft a Conventional Commits message or create the requested commit | `.agents/skills/my-git-commit/SKILL.md` |
| my-implement | Add or change Python code with a simple structure and ruff verification | `.agents/skills/my-implement/SKILL.md` |
| my-test | TDD and pytest workflow delegated by `my-implement`; standalone for test-only changes, execution, or analysis | `.agents/skills/my-test/SKILL.md` |
| show-me | Visualize the current topic with a diagram, tree, Mermaid, or HTML | `.agents/skills/show-me/SKILL.md` |
| eli5 | Explain code or technical concepts with accessible language and examples | `.agents/skills/eli5/SKILL.md` |
| ponytail | Simplify implementation within applicable workflow and verification requirements | `.agents/skills/ponytail/SKILL.md` |
| ponytail-review | Review the current diff specifically for overengineering when requested | `.agents/skills/ponytail-review/SKILL.md` |
| ponytail-audit | Audit the workspace specifically for overengineering when requested | `.agents/skills/ponytail-audit/SKILL.md` |
| ponytail-debt | List debt recorded in `ponytail:` comments | `.agents/skills/ponytail-debt/SKILL.md` |

<!-- Disabled because its benchmark evidence is not included in the installed Skill:
| ponytail-gain | Show the effect of ponytail simplifications in a scoreboard | `.agents/skills/ponytail-gain/SKILL.md` |
-->
<!-- Disabled because its auto-update guidance bypasses `skill-install.sh`:
| ponytail-help | Show how to use ponytail commands | `.agents/skills/ponytail-help/SKILL.md` |
-->
