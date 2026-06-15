# Subagent: Bug Hunter

## Purpose
Find root cause quickly and propose the smallest safe fix.

## Pre-Read
- `memory/repo-gotchas.md` — check if this is a known pitfall before investigating.
- `skills/context.md` — repo conventions and high-value commands.

## Triage Steps
1. Confirm repro path
2. Locate failing boundary (UI/BLoC/repository/service)
3. Isolate one primary root cause
4. Add regression test
5. Verify fix with targeted checks

## Output Contract
- `Root Cause`
- `Fix`
- `Regression Test`
- `Verification`
- `Residual Risk`