---
name: my-implement
description: Implement or change Python code with a readable, simple structure. Follow KISS, YAGNI, DRY, and Why comments. Use when adding features, fixing bugs, refactoring, or integrating external code.
---

# My Implement

## Workflow

1. Read the applicable `AGENTS.md` files, relevant project documentation, the files you will change, and their callers.
2. If the work is multi-step, follow [my-work-plan](../my-work-plan/SKILL.md) and write the goal, done-when, and steps in `docs/plans/YYYY-MM-DD-<slug>.md` before coding. Update that file as each step finishes.
3. Follow [my-test](../my-test/SKILL.md): express the expected behavior as a pytest test before changing production code, and confirm it fails for the intended reason. If pytest is not already part of the project's test setup, obtain user approval before adding it.
4. If a refactor removes a caller or moves behavior between runtime and offline/preparation paths, audit ownership before choosing the module: search all production and test references, classify each helper by its remaining production consumers, and move a helper to its sole production owner. Keep it shared only when multiple production consumers need it.
5. Pick the simplest design that fits the existing structure.
6. Implement the minimum needed to make the tests pass.
7. Remove duplication and obscurity while keeping tests green.
8. Run related tests, then ruff as below, then review the change scope.
9. Close the work plan's done-when with evidence.

## Ruff after implementation

After the implementation and tests are done, format and lint with ruff. Prefer `src` and `tests` when those directories exist; otherwise pass the Python files you changed. Do not run ruff on `vendor/`.

1. If `uv` is available, run `uvx ruff format PATHS` then `uvx ruff check PATHS`.
2. If ruff reports issues, fix them and run the same commands again until both succeed.
3. If `uv` is not available, do not install ruff. In the completion report, state that ruff was not run.

## Design

- Prefer a direct structure with few layers so later readers can follow the flow. (KISS)
- Aim for about 30 lines of real work per function, excluding blank lines, comments, and docstrings. If a function exceeds 50 lines, consider splitting by responsibility. Do not split only to cut line count. If you keep a long function, comment why that shape is needed. (SRP)
- Use DRY to avoid putting the same knowledge or reason-to-change in multiple places. Do not abstract for predicted duplication, and do not extract a helper used once.
- Keep function and class responsibilities narrow. Add a new layer, config key, or dependency only when you can explain why it is needed. (SRP / YAGNI)
- Keep project-specific logic in the workspace's established source layout. Isolate dependencies on external or generated code behind a narrow boundary when doing so reduces coupling. (Separation of Concerns / Dependency Inversion)
- When behavior changes ownership, do not preserve a stale boundary with a mechanical import rewrite just to keep tests green. Recheck the import graph after the old caller is removed.

When principles conflict, pick the simplest implementation that meets the current requirement. Use SOLID and Open/Closed to inspect existing design, not as a reason to add unused layers, interfaces, or extension points. Where those overlap the five items above, the items above are the source of truth.

- **SOLID**: Inspect object design for single responsibility, extension, and dependency direction. Subtypes must not break contracts. Do not make fat interfaces for unused methods.
- **Open/Closed**: Add behavior without breaking existing public boundaries. Do not add plugins or hooks until a second real need appears. Prefer editing existing files.
- **Dependency Inversion**: Do not add an interface when there is only one implementation.
- **Composition**: In new code, do not share behavior through inheritance; compose small parts. Do not rewrite existing inheritance hierarchies without a request.
- **Fail Fast**: Invalid input or broken assumptions must fail immediately at the boundary. Do not silently coerce and continue.
- **Measure First**: Do not optimize until measurement or a public-boundary test gives evidence. Do not fit numbers by guesswork.

## Naming and comments

- Use English identifiers.
- Do not comment what the code already says.
- When you comment, include **Why** the code is needed. Comments that mark steps in a flow are fine when they help understanding.
- If you cannot take the simple path and must add complexity, record the constraint and why you chose that path at the site.
- When changing existing code, match the surrounding and task language. For new files, use the same comment language as nearby project code.
