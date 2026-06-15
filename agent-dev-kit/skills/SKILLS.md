# Skills Registry

Use these skills as reusable playbooks. Keep responses short and action-oriented.

## `session-resume`
- Use for: **restoring context from a previous session without re-scanning the codebase**.
- Prompt: `.github/prompts/session-resume.prompt.md` (slash command: `/session-resume`).
- Loads: `memory/codebase-snapshot.md` + `memory/session-handoff.md`.
- Output: Context Restore Report with last status and exact next step.
- Trigger: user says "resume", "continue from last time", "where were we", or starts a new session on an active feature branch.

## `codebase-snapshot-sync`
- Use for: updating `memory/codebase-snapshot.md` when features are added, renamed, or removed.
- Subagent: none — run directly.
- Steps: update Feature Inventory table + Known Active Areas section + commit with `docs(agent): update codebase-snapshot`.
- Trigger: after merging a new feature, after a significant refactor, or when agent complains of missing feature in snapshot.

## `safe-refactor`
- Use for: extracting widgets, splitting BLoCs, renaming symbols, removing duplication — without changing behavior.
- Agent: `refactor` (`.github/agents/refactor.agent.md`).
- Guardrails: no public API changes, no behavior drift, tests must pass before/after.
- Output: refactor plan, changes list, analyze + test results, risk note.

## `api-integration`
- Use for: adding a new API endpoint, DTO, datasource, or third-party service to the data layer.
- Agent: `api-integrator` (`.github/agents/api-integrator.agent.md`).
- Subagent chain: `api-integrator` → `test-generator` → `test-runner`.
- Output: full DTO → entity → datasource → repository → DI registration chain.

## `gorouter-navigation`
- Use for: **adding a new navigable screen to the GoRouter system** — route constant, path registration, GoRoute builder, BlocProvider wrapping, extras handling.
- Subagent: `navigation` (`subagents/navigation.md`).
- Pre-read: `memory/gorouter-routes.md` (route registry), `memory/repo-gotchas.md` (navigation gotchas).
- Input: feature name, page class, path type (feature/deep-link), extras needed.
- Output: 4-step change set (constant → path list → GoRoute builder → navigation call), analyze result.
- Guardrails:
  - Never use `context.go`/`context.push` directly — always `AppNavigationService`.
  - Never pass objects via `context.push(extra:)` — use `NavigationExtrasManager`.
  - Always wrap page in `BlocProvider` inside the route builder, not in the widget.
  - Update `memory/gorouter-routes.md` after registration.
- Trigger: user says "add screen", "add route", "navigate to", "register page in router", or a new page is created that needs navigation.

## `flutter-feature-delivery`
- Use for: new feature slices in existing architecture.
- Subagent: `flutter-implementer` -> `test-generator` -> `test-runner` -> `doc-writer` -> `code-reviewer`.
- Input: feature goal, screens impacted, API contract, acceptance criteria.
- Output: minimal file-level plan, implementation, **auto-generated tests**, **feature docs**, validation commands.

## `flutter-bugfix-triage`
- Use for: runtime issue, test failure, or regression.
- Subagent: `bug-hunter` -> `test-generator` -> `test-runner` -> `doc-writer` -> `code-reviewer`.
- Input: symptom, logs, stack trace, repro steps.
- Output: root cause, smallest fix, **auto-generated regression test**, **updated docs if behavior changed**, risk note.

## `bloc-refactor-safe`
- Use for: BLoC/event/state cleanup without behavior drift.
- Subagent: `flutter-implementer` -> `test-generator` -> `test-runner`.
- Guardrails: preserve event/state public contracts unless requested.
- Pre-read: `memory/architecture.rules` (BLoC And UI section).

## `auto-test-generation`
- Use for: generating tests for existing or new code that lacks coverage.
- Subagent: `test-generator` -> `test-runner`.
- Input: list of source files to cover.
- Output: test files created, test count, mock classes, run command.
- Trigger: **automatic** after every implement step; also available on demand.

## `auto-doc-generation`
- Use for: generating or updating feature-level documentation.
- Subagent: `doc-writer`.
- Input: feature name, changed files, BLoC states, repository methods.
- Output: feature README with architecture diagram, data flow, state table, key files.
- Trigger: **automatic** for new features; on demand for updates.
- Doc location: `lib/src/features/<feature>/docs/README.md`.

## `test-targeted-fast`
- Use for: run only high-signal tests related to changed files.
- Output: exact commands, pass/fail summary, next test expansion if needed.

## `token-budget-mode`
- Use for: long tasks where context can explode.
- Subagent: `token-keeper` (activate at session start).
- Behavior: summarize frequently, avoid full-file reprints, keep concise diffs.
- Prompt preset: `prompts/token-budget.prompt.md`.

## `new-feature-scaffold`
- Use for: creating a brand-new feature from scratch.
- Template: `templates/feature-scaffold.md` for folder structure + boilerplate.
- Patterns: `skills/code-patterns.md` for copy-paste BLoC/repo/test code.
- Naming: `memory/naming-conventions.md` for file/class names.
- Checklist: `templates/pre-pr-checklist.md` before completing.

## `engineer-autopilot`
- Use for: end-to-end delivery from requirement to validated implementation.
- Subagent: `engineer` orchestrates implementation + mandatory tests + delivery report.
- Input: goal, constraints, scope in/out, acceptance criteria.
- Output: implementation diff summary, generated tests summary, validation outcomes, residual risk.
- Guardrails: follow `memory/architecture.rules`, do not skip test generation for behavior changes.

## `jira-story-delivery`
- Use for: **converting a Jira story or acceptance criteria into validated, PR-ready code**.
- Workflow: `workflows/story-to-delivery.md` (full AC-driven pipeline).
- Subagent chain: `story-analyst` → `engineer` → `flutter-implementer` → `test-generator` → `test-runner` → `doc-writer` → `code-reviewer`.
- Input: raw Jira story text, ticket description, or acceptance criteria in any format.
- Output: completed story intake, AC traceability matrix, implementation, AC-linked tests, validation report.
- Guardrails:
  - Every AC must be parsed, numbered, and normalized before coding.
  - Implementation proceeds AC-by-AC in dependency order.
  - Each AC must have a passing test before moving to the next.
  - Final output includes AC validation report with per-AC evidence.
- Templates used:
  - `templates/jira-story-intake.md` — story parsing
  - `templates/ac-traceability-matrix.md` — progress tracking
  - `templates/ac-validation-report.md` — final proof
- Prompt mode: `prompts/ac-driven.prompt.md`
- Trigger: user pastes a Jira story, references a ticket, or says "implement this story/ticket/AC".

## `ac-gap-analysis`
- Use for: checking if existing code already satisfies some ACs from a story.
- Subagent: `story-analyst` → `code-reviewer`.
- Input: Jira story + existing feature code.
- Output: per-AC gap analysis (already satisfied / needs work / missing entirely).
- Use case: resuming work on a partially implemented story.

## `figma-to-ui`
- Use for: **converting Figma screens or design mockups into Flutter widgets**.
- Workflow: part of `workflows/story-to-delivery.md` (Phase 0 + Phase 3 for UI ACs).
- Subagent: `story-analyst` (design intake) → `flutter-implementer` (widget implementation) → `test-generator` (widget tests).
- Input: Figma link, screenshot, or verbal description of UI design.
- Output: widget tree plan, state-to-screen mapping, implemented widgets, widget tests.
- Template: `templates/figma-design-intake.md` for structured extraction.
- Rules:
  - Map design tokens to existing app theme — never hardcode.
  - Follow widget tree from design intake.
  - Implement all states shown in design (loading, empty, error, loaded).
  - Widget tests verify each state renders correct elements.
- Trigger: user provides Figma link, pastes a screenshot, or says "implement this design/screen".
