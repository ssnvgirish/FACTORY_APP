# Feature Discovery Scope Template

Use this template before implementation to keep context loading token-efficient.

## Requirement Snapshot
- Goal: [one sentence]
- Non-goals: [what is explicitly out]

## Candidate Feature Paths (Ranked)
1. `lib/src/features/[feature_a]/` — [why likely]
2. `lib/src/features/[feature_b]/` — [why likely]

## Selected Initial Scope
- In:
  - `lib/src/features/[selected_feature]/`
  - `test/src/features/[selected_feature]/`
- Out:
  - unrelated features
  - build/flavor/secrets

## Minimal Files To Read First
- `lib/src/features/[selected_feature]/...` [top 2-5 files]
- `test/src/features/[selected_feature]/...` [existing related tests]

## Expand Only If Needed
- `lib/locator.dart` if dependency injection is touched
- `lib/routers.dart` if navigation is touched
- shared services only if imported by selected feature files

## Discovery Exit Criteria
- [ ] impacted feature path confirmed
- [ ] minimal impacted files listed
- [ ] first targeted validation commands identified
