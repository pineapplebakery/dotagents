---
name: my-test
description: Apply test-first development and staged verification with pytest. Use when adding or changing Python behavior, fixing bugs, refactoring, or adding or updating pytest tests.
---

# My Test

## TDD cycle

1. Pick one behavior a caller can observe after the change.
2. Before changing production code, add or update a pytest test that states that behavior.
3. Run only that test and confirm it fails for the right reason (missing implementation or the bug). Do not treat environment problems or a broken test as evidence to proceed.
4. Implement the minimum needed to pass the test.
5. Clean up design while keeping the full suite green.
6. Widen verification: target test, then related tests, then the full runnable suite.

For refactors that must keep current behavior, first add characterization tests that lock that behavior. Do not require new tests for comment-only or docs-only changes that do not change runtime behavior.

## Test design

- Write tests with `pytest` and follow the project's existing test layout. If the project has no convention and the user authorizes a new pytest layout, use `tests/`.
- Verify behavior from stable public boundaries, not internal steps of the implementation.
- One test covers one behavior. Name it so a failure shows expected vs actual.
- Prefer small inputs that run fast and deterministically. Fix seeds when using randomness.
- Do not assume external datasets, large artifacts, specialized hardware, or network access for ordinary tests. Keep required integration tests clearly separate and state their requirements in the test.
- Isolate side effects with `tmp_path`, `monkeypatch`, and fixtures. Avoid mocks that freeze implementation details.

## Running

Use the project's configured test runner. With direct pytest invocation, fail fast on the target test:

```bash
pytest tests/path/to/test_module.py::test_name -q
```

After implementing, widen to the file, related scope, then the full suite:

```bash
pytest tests/path/to/test_module.py -q
pytest -q
```

Then run ruff as in [my-implement](../my-implement/SKILL.md).

If pytest is not already part of the project's test setup, do not add it without user approval. If no test infrastructure exists, do not create one without a request.
