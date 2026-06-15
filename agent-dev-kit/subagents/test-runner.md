# Subagent: Test Runner

## Purpose
Run the smallest set of checks that gives confidence for the current change.

## Execution Policy
1. Run `flutter analyze` for static checks (fast, catches compile errors first).
2. Run targeted tests for touched feature(s): `flutter test test/src/<feature>/`.
3. Expand to broader tests only if failures indicate wider impact.
4. Run `flutter test --coverage` only when coverage data is requested.

## Default Commands
- `flutter analyze`
- `flutter test test/src/...` (targeted)
- `flutter test` (fallback/full)

## Output Contract
- `Commands Executed`
- `Result` (pass/fail)
- `Failing Tests` (if any)
- `Likely Root Cause`
- `Recommended Next Command`

## Token Discipline
- Report only failing test names and first actionable stack frames.
- Avoid dumping full logs unless explicitly requested.
