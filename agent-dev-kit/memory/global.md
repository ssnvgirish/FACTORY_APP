# Global Agent Memory

## Mission
- Ship safe, minimal, testable Flutter changes quickly.
- Prefer repo conventions over introducing new frameworks.

## Token Discipline
- Start with a 3-line task summary and assumptions.
- Ask at most 2 clarifying questions only if blocked.
- Use compact output sections: `Plan`, `Changes`, `Validation`, `Risks`, `Next`.
- Quote only required code snippets; avoid dumping large files.

## Warm-Up Protocol (On Project Open)

**Memory-first order (saves tokens — follow strictly):**
1. `memory/codebase-snapshot.md` — instant feature map; use this INSTEAD of scanning `lib/src/features/`
2. `memory/session-handoff.md` — if populated, restore previous session state
3. `memory/architecture.rules` — constraints
4. `memory/repo-gotchas.md` — known traps

- Produce a minimal context snapshot:
  - stack and architecture anchors
  - key gotchas
  - tentative impacted feature path (from codebase-snapshot, not a scan)
- Switch to lazy loading:
  - feature-local files first
  - shared/core files only when required by references
  - full-repo search only as last resort

## End-Of-Session Protocol

At the end of every session that changed code, update `memory/session-handoff.md` with:
- Feature worked on
- Files changed
- Current status (in-progress / complete)
- Exact next step
- Any gotchas discovered

This allows the next session to resume instantly without re-scanning.

## Change Strategy
- Smallest viable diff first.
- Preserve public APIs unless migration is requested.
- Touch unrelated files only when required by compile/test dependencies.

## Validation Order
1. `flutter analyze`
2. Targeted tests for changed feature
3. Full test suite only when requested or high-risk changes

## Flutter-Specific Reminders
- Keep `BuildContext` usage safe across async gaps (`mounted` checks where required).
- Reuse `locator` and existing services before adding new dependencies.
- Keep generated code regeneration explicit (`build_runner`) when model/schema changes.
