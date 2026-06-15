# Task Flow (Token-Efficient)

## -1) Session Resume (If Returning To Existing Work)

- If `memory/session-handoff.md` is populated, load it FIRST.
- Reconstruct context from handoff — DO NOT re-scan the codebase.
- Emit "Session Restored: [status from handoff]" and proceed from the recorded next step.
- Use `/session-resume` prompt for guided reload.

## 0) Warm-Up (On Open)

- Read memory files in this order (memory-first to save tokens):
  1. `memory/codebase-snapshot.md` — **use as feature map instead of scanning**
  2. `memory/session-handoff.md` — previous session state
  3. `memory/architecture.rules`
  4. `memory/repo-gotchas.md`
  5. `memory/naming-conventions.md`
- Create a 3-line context snapshot and assumptions.
- Identify likely feature path; do not scan unrelated features.
- Complete `templates/startup-warmup-checklist.md`.
- Emit `Warm-Up Check` result before implementation.

Hard gate:
- If any warm-up check field is `fail`, stop. Do not implement or broaden context.

## 0.5) Story Intake (When Jira Story Provided)
- If the user pastes a Jira story or acceptance criteria, run `templates/jira-story-intake.md` first.
- If Figma screens or design mockups are provided, also complete `templates/figma-design-intake.md`.
- Parse and number all ACs. Normalize vague criteria into testable statements.
- Initialize `templates/ac-traceability-matrix.md` with all ACs.
- Select skill + subagent based on story type.
- Follow `workflows/story-to-delivery.md` for the full AC-driven execution flow.
- If no story is provided, proceed to Step 1 as normal.

## 1) Scope
- Problem statement (1-2 lines)
- Affected files/features
- Done criteria (or ACs from story intake)
- Complete `templates/feature-discovery-scope.md` before reading beyond the selected feature area.

## 2) Plan
- Max 5 steps
- Identify tests to run before coding

## 3) Implement
- Smallest diff first
- Keep API compatibility unless requested
- If ACs exist: implement AC-by-AC in dependency order
- Update `ac-traceability-matrix.md` after each AC passes
- Do not move to next AC until current AC's test passes

## 4) Auto-Generate Tests (MANDATORY)
- Runs automatically after every implementation step.
- Subagent: `test-generator` — see `subagents/test-generator.md`.
- For each changed/new file, generate the matching test file:
  - BLoC → `blocTest<>()` with initial/happy/empty/error cases
  - Repository → success/failure/null-response cases
  - Widget → renders elements, correct text, tap interactions
- Mirror source path: `lib/src/features/X/` → `test/src/features/X/`
- Add `@GenerateMocks` and run `build_runner` if new mocks needed.
- Skip only if the change is purely cosmetic (comments, formatting).

## 5) Validate
- `flutter analyze`
- `flutter pub run build_runner build` (if new mocks)
- targeted tests: `flutter test test/src/features/<feature>/`
- broader tests only on demand/risk

## 6) Auto-Generate Docs
- Subagent: `doc-writer` — see `subagents/doc-writer.md`.
- Create/update `lib/src/features/<feature>/docs/README.md` for new features.
- Include: overview, architecture diagram, data flow, state table, key files.
- For bug fixes/refactors: update existing docs if behavior changed.
- Skip only for trivial changes (typos, formatting).

## 7) AC Validation (When Story-Driven)
- Complete `templates/ac-validation-report.md` with per-AC evidence.
- Verify all ACs are `passed` or `manual-verified` in traceability matrix.
- Include AC pass rate in delivery report.

## 8) Report
- What changed
- Why it is safe
- What remains risky
- AC traceability summary (if story-driven)

## 9) Session Handoff (ALWAYS — Even For Partial Work)
Update `memory/session-handoff.md` with:
- Feature/branch/Jira reference
- Files changed (paths only)
- Current status: in-progress | complete | blocked
- Exact next step (specific enough to resume without re-reading code)
- Any new gotchas discovered
- Tests status

This is the primary mechanism for cross-session memory. Skip only if zero code was touched.

## Standard Output Format
- `Plan:`
- `Changes:`
- `Validation:`
- `AC Status:` (when story-driven — per-AC pass/fail summary)
- `Risks:`
- `Next:`
