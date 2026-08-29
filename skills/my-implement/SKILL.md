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

## Runtime and API design

- Use built-in exception types when they describe the failure. Do not use `assert` for input validation, preconditions, or required runtime behavior; reserve it for internal invariants that can safely disappear under optimized execution.
- Keep `try` blocks narrow. Catch only expected exceptions; do not use bare or broad catches unless re-raising or deliberately isolating and recording a failure. Error messages must describe the actual condition and include relevant values clearly.
- Manage files, sockets, locks, database connections, and similar resources with `with` or an explicit `finally`. Do not rely on object destruction for cleanup. If ownership or lifetime is non-obvious, document it.
- Avoid mutable module-level or class-level state. If it is required, keep it internal and document its ownership, lifetime, and reason for existence.
- Keep comprehensions, generator expressions, conditional expressions, and lambdas simple. Prefer a loop or named helper when an expression needs multiple stages or non-obvious control flow.
- Use nested functions only when they close over a local value. Otherwise, use a module-private helper so it remains testable. Avoid metaclasses, custom descriptors, import hacks, and other dynamic features unless a concrete requirement justifies them.
- Do not use mutable default arguments. Use `None` and initialize inside the function, including when the mutable value comes from a custom object rather than a literal.
- Keep executable work in `main()` behind `if __name__ == "__main__":`; importing a module must not run CLI handling, open resources, or perform expensive setup.
- Give public APIs accurate argument and return annotations. Prefer abstract collection types at API boundaries, and use `Any` only at a deliberate dynamic boundary with a documented reason.

## Naming and comments

- Use English identifiers.
- Choose descriptive names and avoid unexplained, project-local abbreviations. Short names are acceptable for tightly scoped iterators or established mathematical notation.
- Do not comment what the code already says.
- When you comment, include **Why** the code is needed. Comments that mark steps in a flow are fine when they help understanding.
- If you cannot take the simple path and must add complexity, record the constraint and why you chose that path at the site.
- When changing existing code, match the surrounding and task language. For new files, use the same comment language as nearby project code.

## Docstrings

- Document public modules, classes, functions, and methods when callers need to know how to use them. Add a docstring to private code when its behavior, constraints, or side effects are not obvious from the code.
- Start with the caller-visible purpose. Do not describe the implementation line by line or repeat a clear function name.
- For non-trivial APIs, describe the parts a caller cannot infer reliably from the signature: parameter meaning and valid values, units/shapes/devices, default behavior, return structure, side effects, resource ownership, preconditions, and relevant exceptions.
- Use `Args`, `Returns`, `Yields`, `Raises`, or `Attributes` sections when those details exist. List each item by its parameter or attribute name and describe behavior rather than repeating its type annotation.
- Keep documentation synchronized with behavior. When a public contract or important restriction changes, update its docstring and the relevant test in the same change.
- Do not add boilerplate docstrings to trivial private helpers, test functions, or overridden methods whose inherited contract is unchanged. Do not document behavior that the code does not provide or tests do not support.
