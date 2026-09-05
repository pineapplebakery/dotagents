---
name: my-implement
description: Parent workflow for implementing or changing Python code with a readable, simple structure. Use for Python features, bug fixes, refactors, or external-code integration; delegate planning decisions and pytest TDD to the maintained child skills.
---

# My Implement

## Workflow

1. Before coding, follow [my-work-plan](../my-work-plan/SKILL.md) for the plan-file decision, pre-work requirements, and [update timing](../my-work-plan/SKILL.md#when-to-update).
2. If a refactor removes a caller or changes which component owns behavior, search all production and test references before choosing the destination. Move a helper to its sole production owner, and keep it shared only when multiple production consumers need it. Move or update the related tests to match the new ownership.
3. Implement by following [my-test](../my-test/SKILL.md), which owns the test-first workflow, verification sequence, and pytest setup policy.
4. Run the applicable ruff checks below and review the change scope. Ruff and diff review remain useful even when a test cannot run.
5. If a work plan is in use, return to [my-work-plan](../my-work-plan/SKILL.md) and close it with evidence.

## Ruff after implementation

Follow the workspace's required Ruff scope and command when documented in `AGENTS.md`, `README.md`, project configuration, or CI. Otherwise, format and lint the changed Python files with an already installed project Ruff; do not broaden the scope to all of `src` or `tests` by default, and do not include vendored code.

1. Prefer the project's documented command. If none exists, use an already installed `ruff` executable and run `ruff format PATHS` followed by `ruff check PATHS`.
2. Do not install or download Ruff automatically; if an installed `ruff` executable is unavailable, skip Ruff and report it.
3. Fix issues caused by or within the requested change and rerun the applicable commands. Do not modify unrelated code for pre-existing violations; report them separately.
4. After Ruff formatting, inspect the diff. Unless the workspace requires whole-file formatting, exclude formatting-only changes to pre-existing code unrelated to the request. If those changes cannot be separated safely without altering the user's existing changes, report the constraint and Ruff result; do not revert user changes or modify out-of-scope code solely to resolve the formatting diff.
5. If Ruff is unavailable, continue other independent checks and state in the completion report that Ruff was not run.

## Design

- Prefer a direct structure with few layers so later readers can follow the flow.
- Treat about 30 lines of real work per function as a soft readability signal, excluding blank lines, comments, and docstrings. Above about 50 lines, check for mixed responsibilities or unclear control flow. Do not split only to reduce line count. Add a Why comment only when a non-obvious constraint explains why the longer shape is necessary.
- Keep function and class responsibilities narrow, and avoid encoding the same knowledge or reason to change in multiple places. Introduce an abstraction, layer, config key, dependency, interface, or extension point only to solve a concrete current problem such as existing duplication, coupling, or an external boundary. Do not extract a helper only for predicted reuse or line-count reduction, add an interface for a single implementation, or add plugins or hooks before a second real need appears.
- Keep project-specific logic in the workspace's established source layout. Isolate dependencies on external or generated code behind a narrow boundary when doing so reduces coupling. (Separation of Concerns / Dependency Inversion)
- When behavior changes ownership, do not preserve a stale boundary with a mechanical import rewrite just to keep tests green. Recheck the import graph after the old caller is removed.
- Preserve existing public boundaries when adding behavior. Subtypes must not break contracts, and interfaces must not require unused methods. Prefer editing existing files when it keeps the structure clear.
- **Composition**: In new code, do not share behavior through inheritance; compose small parts. Do not rewrite existing inheritance hierarchies without a request.
- **Fail Fast**: Invalid input or broken assumptions must fail immediately at the boundary. Do not silently coerce and continue.
- **Measure First**: Do not optimize until measurement or a public-boundary test gives evidence. Do not fit numbers by guesswork.

When these rules compete, choose the simplest implementation that meets the current requirement and preserves caller-visible contracts.

## Naming and comments

- Use English identifiers.
- Do not comment what the code already says.
- When you comment, include **Why** the code is needed. Comments that mark steps in a flow are fine when they help understanding.
- If you cannot take the simple path and must add complexity, record the constraint and why you chose that path at the site.
- When changing existing code, match the surrounding and task language. For new files, use the same comment language as nearby project code.

## Docstrings

- Document public modules, classes, functions, and methods regardless of complexity. Start each docstring with a concise overview of its caller-visible purpose.
- For public APIs, include applicable `Args`, `Returns`, `Yields`, `Raises`, and `Attributes` sections. Describe parameter meaning and valid values, units/shapes/devices, default behavior, return structure, side effects, resource ownership, preconditions, and relevant exceptions when they cannot be inferred reliably from the signature.
- Keep each `Args` item concise and on a single line.
- Keep documentation synchronized with behavior. When a public contract or important restriction changes, update its docstring and the relevant test in the same change.
- For simple private helpers, the overview is sufficient. Test purpose docstrings follow [my-test](../my-test/SKILL.md); do not add Args/Returns sections to tests. Do not add boilerplate docstrings to overridden methods whose inherited contract is unchanged. Do not document behavior that the code does not provide or tests do not support.
