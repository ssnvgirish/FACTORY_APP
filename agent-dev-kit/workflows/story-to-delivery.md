# Story-To-Delivery Workflow

End-to-end workflow for converting a Jira story (with acceptance criteria) into validated, PR-ready code. This is the primary workflow when the user pastes a story or ticket.

---

## Phase 0: Story Intake

**Trigger**: User pastes a Jira story, ticket text, acceptance criteria, or Figma designs.

1. Parse the story using `templates/jira-story-intake.md`.
2. Extract and number all acceptance criteria.
3. Normalize vague ACs into testable statements.
4. Classify story type → select skill and subagent.
5. Map scope to feature path(s).
6. List assumptions explicitly.
7. **If Figma / design input provided**: complete `templates/figma-design-intake.md`.
   - Break screens into widget tree.
   - Map design tokens to existing theme.
   - Extract interaction specs.
   - Map states to BLoC states.
   - Link UI-related ACs to specific widgets.

**Gate**: All intake fields populated. Figma intake completed if designs provided. If ambiguity blocks implementation → ask user (max 2 questions).

**Output**: Completed story intake + design intake (if applicable) + AC table.

---

## Phase 1: Warm-Up + Scope Lock

1. Complete `templates/startup-warmup-checklist.md` (if not done this session).
2. Complete `templates/feature-discovery-scope.md` using story scope mapping.
3. Read only the scoped feature path files.
4. Emit `Warm-Up Check`.

**Gate**: Warm-up passes. Feature path confirmed.

---

## Phase 2: AC-Driven Planning

1. Initialize `templates/ac-traceability-matrix.md` with all ACs from Phase 0.
2. For each AC, plan:
   - Which layer is affected (data / domain / ui / bloc)
   - Which files need to change or be created
   - What test(s) will prove the AC
3. Order ACs by dependency (data layer first, then domain, then UI).
4. Produce a max-5-step implementation plan.

**Output**: Traceability matrix initialized + implementation plan.

---

## Phase 3: AC-By-AC Implementation

For **each AC** (in dependency order):

1. Mark AC as `in-progress` in traceability matrix.
2. Implement the smallest change that satisfies the AC.
   - For UI ACs with Figma specs: follow widget tree from design intake.
   - Use existing design tokens — never hardcode colors/fonts/spacing.
   - Implement all states shown in design (loading, empty, error, loaded).
3. Write the test(s) that prove the AC (trigger `test-generator` subagent).
   - Widget tests for UI ACs must verify visual elements per design.
4. Run the test(s) to verify pass.
5. Mark AC as `passed` (or `failed` if test fails → fix before next AC).
6. Update traceability matrix.

**Rules**:
- Do NOT move to the next AC until current AC passes.
- If an AC requires a new feature scaffold, use `templates/feature-scaffold.md`.
- If an AC requires new DI registration, update `lib/locator.dart`.
- If an AC touches routing, update `lib/routers.dart`.

---

## Phase 4: Cross-AC Validation

After all ACs are individually passed:

1. Run `flutter analyze` — must pass with zero new issues.
2. Run targeted test suite: `flutter test test/src/features/<feature>/`.
3. Verify all tests pass together (catch AC interaction regressions).
4. Run `build_runner` if any model/schema changes.
5. Update traceability matrix with final status.

---

## Phase 5: Docs + Delivery Report

1. Trigger `doc-writer` subagent for new features or significant behavior changes.
2. If Figma-driven: verify all screens from design are implemented (design QA checklist).
3. Verify against `templates/pre-pr-checklist.md`.
4. Generate `templates/ac-validation-report.md` — the final proof that all ACs are met.
5. Generate `templates/pr-summary.md` and `templates/agent-delivery-report.md`.

---

## Phase 6: Final Gate

- [ ] All ACs in traceability matrix are `passed` or `manual-verified`
- [ ] No AC is `failed`, `not-started`, or `in-progress`
- [ ] `flutter analyze` passes
- [ ] All targeted tests pass
- [ ] Pre-PR checklist passes
- [ ] AC validation report complete
- [ ] PR summary includes AC coverage evidence

**Result**: Ready for PR / Not ready (with specific blockers listed).

---

## Quick Reference: Phase → Subagent

| Phase | Subagent(s) |
|-------|------------|
| 0: Story Intake | `story-analyst` |
| 1: Warm-Up | — (agent core) |
| 2: Planning | `story-analyst` + `engineer` |
| 3: Implementation | `flutter-implementer` + `test-generator` |
| 4: Validation | `test-runner` + `code-reviewer` |
| 5: Docs + Report | `doc-writer` |
| 6: Final Gate | `code-reviewer` |

---

## Abort Conditions

- If >2 ACs cannot be satisfied due to missing API/design → stop and request clarification.
- If tests fail after 2 fix attempts per AC → escalate with diagnostic summary.
- If story scope expands beyond original feature path → pause, re-scope, and confirm with user.
