# Startup Warm-Up Checklist

Use this checklist at session start. Do not proceed to implementation until all required items are complete.

## Required Reads (Memory-First Order — Saves Tokens)

- [ ] `agent-dev-kit/memory/codebase-snapshot.md` — **load FIRST** — instant feature/service/package map. Use this INSTEAD of scanning `lib/src/features/`.
- [ ] `agent-dev-kit/memory/session-handoff.md` — if populated, restore previous session state before reading anything else
- [ ] `agent-dev-kit/memory/architecture.rules`
- [ ] `agent-dev-kit/memory/repo-gotchas.md`
- [ ] `agent-dev-kit/memory/naming-conventions.md`

## Required Warm-Up Output
- [ ] 3-line summary with:
  - stack/architecture anchors
  - key gotchas
  - likely impacted feature path (from `codebase-snapshot.md`, not a scan)
- [ ] If `session-handoff.md` was populated: emit "Session Restored: [status]" with next step

## Scope Gate
- [ ] Initial scope narrowed to one feature path under `lib/src/features/<feature>/`
- [ ] Matching tests path identified under `test/src/features/<feature>/`
- [ ] No broad repo scan done before feature path is identified

## Expansion Rules
- [ ] Shared/core files (`lib/locator.dart`, `lib/routers.dart`, shared services) loaded only when referenced by scoped files
- [ ] Broad search used only after targeted search fails

## Agent Selection Gate
- [ ] Task type identified and correct agent selected:
  - New feature/BLoC/screen → `feature-scaffold`
  - Bug/crash/unexpected behavior → `flutter-debugger`
  - Architecture/PR review → `arch-reviewer`
  - Writing tests → `flutter-tester`
  - Safe refactoring → `refactor`
  - New API/datasource/DTO → `api-integrator`
  - Full story delivery → `engineer`

## Gate Result (Mandatory)
Write this before implementation:

```
Warm-Up Check:
- required_reads: pass|fail
- session_restored: pass|n/a
- summary_ready: pass|fail
- feature_scope_ready: pass|fail
- agent_selected: pass|fail
- expansion_policy_ready: pass|fail
```

If any field is `fail`, stop and complete warm-up before coding.
