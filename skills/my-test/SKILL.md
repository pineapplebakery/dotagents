---
name: my-test
description: Run and analyze pytest checks, and add or correct test code for test-only requests. Also provide the TDD and staged-verification child workflow when my-implement delegates a Python code change. Use independently for test-only changes, execution, or analysis; use as a child for production-code changes when my-implement is available.
---

# My Test

## Modes

- For a request to run or analyze tests only, run the requested checks and report the results without editing project files. Diagnosing a failure does not authorize a fix.
- For a test-only change, such as adding or correcting tests, use this skill independently and apply the test-design and verification guidance below. Do not change production code in this mode. If the test change shows that production code must change, hand the production-code change off to `my-implement`.
- When delegated by `my-implement`, or when `my-implement` is unavailable and the request includes a production-code change, apply the TDD cycle and verification guidance below.

## TDD cycle

For new behavior and bug fixes:

1. Pick one behavior a caller can observe after the change.
2. Before changing production code, add or update a pytest test that states that behavior.
3. Run only that test and confirm it fails for the right reason: missing behavior or the reproduced bug. Do not treat environment problems or a broken test as evidence to proceed.
4. Implement the minimum needed to pass the test.
5. Refactor while keeping the tests green.
6. Widen verification as described in [Running](#running).

For behavior-preserving refactors, first confirm the relevant existing tests pass. Add a characterization test only when those tests do not adequately cover the behavior being preserved; the refactor does not require a failing test first. Do not require new tests for comment-only or docs-only changes that do not change runtime behavior.

## Test design

- When adding tests, write a docstring that states what behavior they verify. Use a module docstring for a new test module. Use a function docstring on each added test in an existing module, even if neighboring tests have no docstring. A one-line overview is enough.
- Write tests with `pytest` and follow the project's existing test layout. If the project has no convention and the user authorizes a new pytest layout, use `tests/`.
- Verify behavior from stable public boundaries, not internal steps of the implementation.
- Keep tests with the behavior they verify. When behavior changes ownership, move or update its tests to match the new owner. To compare equivalent behavior across components or paths, derive the expected value independently instead of calling the code under test to build it.
- One test covers one behavior. Name it so a failure shows expected vs actual.
- Prefer small inputs that run fast and deterministically. Fix seeds when using randomness.
- Do not assume external data, large artifacts, specialized hardware, or network access for ordinary tests. Keep required integration tests clearly separate and state their requirements in the test.
- Isolate side effects with `tmp_path`, `monkeypatch`, and fixtures. Avoid mocks that freeze implementation details.

## Running

Run every test command required by the workspace. Otherwise, start with the smallest relevant pytest target and widen to the file, related scope, and full suite according to the affected surface and regression risk. A narrow isolated change may not require the full suite; shared or high-impact changes usually do.

With direct pytest invocation, fail fast on the target test:

```bash
pytest tests/path/to/test_module.py::test_name -q
```

Examples of wider scopes are:

```bash
pytest tests/path/to/test_module.py -q
pytest -q
```

If a test cannot run, continue independent available checks and state what was not run and why. Do not change unrelated code or expected values to make a pre-existing failure pass.

If pytest is not already part of the project's test setup, do not add it without user approval.
