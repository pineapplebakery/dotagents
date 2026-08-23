---
name: test
description: Test-first development and staged verification with pytest. Use when adding or changing implementation, fixing bugs, changing behavior, refactoring, or adding or updating tests.
---

# Test

## TDD cycle

1. Pick one behavior a caller can observe after the change.
2. Before changing production code, add or update a pytest test that states that behavior.
3. Run only that test and confirm it fails for the right reason (missing implementation or the bug). Do not treat environment problems or a broken test as evidence to proceed.
4. Implement the minimum needed to pass the test.
5. Clean up design while keeping the full suite green.
6. Widen verification: target test, then related tests, then the full runnable suite.

For refactors that must keep current behavior, first add characterization tests that lock that behavior. Do not require new tests for comment-only or docs-only changes that do not change runtime behavior.

## Test design

- Write tests with `pytest`. Always put them under `tests/`.
- Mirror the `src/` directory layout under `tests/`, and pair each module with its test file. Example: tests for `src/train.py` live in `tests/test_train.py`.
- Verify behavior from stable public boundaries, not internal steps of the implementation.
- One test covers one behavior. Name it so a failure shows expected vs actual.
- Prefer small inputs that run fast and deterministically on CPU. Fix seeds when using randomness.
- Do not assume a full dataset, pretrained weights, GPU, or network for ordinary tests. Keep required integration tests clearly separate and state their requirements in the test.
- Isolate side effects with `tmp_path`, `monkeypatch`, and fixtures. Avoid mocks that freeze implementation details.

## Running

Fail fast on the target test:

```bash
uv run pytest tests/path/to/test_module.py::test_name -q
```

After implementing, widen to the file, related scope, then the full suite:

```bash
uv run pytest tests/path/to/test_module.py -q
uv run pytest -q
```

If pytest is not a development dependency, add it to the root uv project as a development dependency and update the lockfile. If `pyproject.toml` does not exist, do not create a test harness without a request.
