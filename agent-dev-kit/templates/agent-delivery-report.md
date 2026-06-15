# Agent Delivery Report Template

Paste this into the PR description for agent-driven changes.

## Warm-Up Check

Warm-Up Check:
- required_reads: pass
- summary_ready: pass
- feature_scope_ready: pass
- expansion_policy_ready: pass

## Feature Discovery Scope

Feature Discovery Scope:
- selected_feature_path: lib/src/features/[feature]/
- scope_in: lib/src/features/[feature]/, test/src/features/[feature]/
- scope_out: unrelated features, flavors/secrets, CI unless required

## Story Reference (When Story-Driven)

- Ticket: [KONNECT-XXXX]
- Title: [story title]
- ACs Parsed: [count]

## Plan
- [step 1]
- [step 2]

## Changes
- [file]: [what changed]

## Validation
- `flutter analyze`: pass/fail
- `flutter test test/src/features/[feature]/`: pass/fail

## AC Status (When Story-Driven)

| AC # | Criterion | Result | Evidence |
|------|-----------|--------|----------|
| AC-1 | [text] | PASS/FAIL | [test name or manual evidence] |
| AC-2 | [text] | PASS/FAIL | [test name or manual evidence] |

- ACs Passed: [X]/[total]
- AC Pass Rate: [X]%

## Risks
- [risk]

## Next
1. [next step]
