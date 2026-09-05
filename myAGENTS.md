# Shared Agent Instructions

Keep only guidance that applies across workspaces in this file. Put project-specific structure, technology, verification, artifacts, output language, and permissions in the workspace `AGENTS.md`, or link to the relevant documentation from there. Workspace-specific instructions take precedence when instructions conflict.

## Communication and judgment

- Communicate concisely, directly, and candidly.
- Distinguish verified facts from assumptions. Do not present unverified information as fact.
- Before starting, define observable conditions that determine completion. Ask questions only when unclear conditions would materially affect the result.
- Confirm before making decisions that are destructive, externally visible, or require broader permissions.

## Working principles

- Before starting, inspect the workspace `AGENTS.md`, relevant documentation, the files to change, and their callers.
- Choose the simplest implementation that meets the current requirements. Confirm that each change is needed for the completion conditions, and do not introduce abstractions only for possible future use.
- Keep changes small and focused on the request. Do not leave unnecessary new files or dead code. Preserve unrelated user changes.
- Follow the existing structure, naming, language, and tools. Do not introduce new conventions without approval.
- Use comments to explain reasons or constraints that are not evident from the code. Do not add comments that merely restate the implementation.
- Before adding a dependency, check whether existing dependencies or standard features can solve the problem. Obtain user approval before adding dependencies.
- Do not output, record, or commit credentials, private keys, tokens, or other secrets.
- Do not commit generated artifacts or large data unless the workspace explicitly identifies them as tracked files.
- When work requires a plan, follow the `my-work-plan` skill and keep the plan in `docs/plans/`.
- If the same failure recurs, propose a rule that prevents it. Put workspace-specific rules in that workspace's `AGENTS.md`; add only cross-workspace rules to this file.

## Verification

- Before claiming completion, verify the result with observable evidence proportionate to the change, such as tests, static checks, and diff review. State which checks were not run.
- Start with focused, fast checks that avoid network access and external data where practical. Make randomized verification reproducible across runs.
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

For Python code changes, including tests, use `my-implement` as the parent workflow when it exists. It delegates plan lifecycle to `my-work-plan` when required and TDD and test verification to `my-test`; those child workflows do not call back to the parent. A child may be used independently when `my-implement` does not apply or is unavailable.

When `ponytail` is also active for a Python code change, `my-work-plan`, `my-implement`, and `my-test` take precedence for planning, implementation workflow, test framework and TDD, staged verification, ruff, and docstrings. Apply `ponytail` only to implementation simplicity within those requirements; do not use its minimal-check policy to weaken them.

Use `ponytail-review` and `ponytail-audit` only when the user explicitly asks for an overengineering or complexity review. They do not replace a general review for correctness, regressions, security, performance, or test coverage.

| Skill | When to use it | Path |
|---|---|---|
| my-work-plan | Create and update work plans in `docs/plans/` | `.agents/skills/my-work-plan/SKILL.md` |
| my-git-commit | Review the change scope and create a Conventional Commits message | `.agents/skills/my-git-commit/SKILL.md` |
| my-implement | Add or change Python code with a simple structure and ruff verification | `.agents/skills/my-implement/SKILL.md` |
| my-test | TDD and pytest workflow delegated by `my-implement`; standalone for test execution or analysis without code changes | `.agents/skills/my-test/SKILL.md` |
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
