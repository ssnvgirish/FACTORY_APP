# Jira Story Intake Template

Use this template to parse a Jira story (or any ticket with acceptance criteria) into a structured, actionable format the agent can execute against.

## Instructions

When the user pastes a Jira story, ticket, or requirements with acceptance criteria:
1. Extract all fields below from the raw text.
2. Normalize each acceptance criterion into a testable statement.
3. Classify the story type and map to the right skill/subagent.
4. Produce a traceability matrix linking each AC to implementation + test.

---

## Story Metadata

| Field | Value |
|-------|-------|
| Ticket ID | [e.g. KONNECT-1234] |
| Title | [story title] |
| Type | feature / bug / refactor / spike |
| Priority | critical / high / medium / low |
| Epic / Parent | [if provided] |
| Reporter | [if provided] |
| Assignee | [if provided] |
| Sprint | [if provided] |

## User Story

> As a [persona], I want [goal], so that [benefit].

[Or paste the raw description verbatim if not in user-story format.]

## Acceptance Criteria (Parsed)

Extract each AC into a numbered, testable statement. Normalize vague criteria into precise conditions.

| # | Acceptance Criterion | Testable? | Test Type | Status |
|---|---------------------|-----------|-----------|--------|
| AC-1 | [precise statement] | yes/no | unit / widget / integration / manual | pending |
| AC-2 | [precise statement] | yes/no | unit / widget / integration / manual | pending |
| AC-3 | [precise statement] | yes/no | unit / widget / integration / manual | pending |

### Normalization Rules
- Convert "should work correctly" → specific expected behavior with input/output
- Convert "handles errors" → specific error scenarios (network failure, empty response, null data)
- Convert "looks good" → specific UI elements rendered, correct text, proper layout
- Convert "performs well" → measurable metric or defer to manual validation
- Flag any AC that cannot be automated as `manual` test type

## Assumptions (Agent-Inferred)

List assumptions made when the story is ambiguous. Each assumption should be explicit and reviewable.

1. [assumption]
2. [assumption]

## Out Of Scope

Items explicitly excluded or inferred as out of scope:

- [item]

## Technical Context (Extracted)

- API endpoints mentioned: [if any]
- Screens / pages mentioned: [if any]
- Existing features referenced: [if any]
- Data models referenced: [if any]
- **Figma / design attached**: yes / no
  - If yes: complete `templates/figma-design-intake.md` for UI specs
  - Link or screenshot reference: [URL or description]

## Scope Mapping

Based on the parsed story, map to repo paths:

- Feature path: `lib/src/features/[feature]/`
- Test path: `test/src/features/[feature]/`
- Shared dependencies: [list only if referenced]

## Story Classification → Skill Selection

| Story Type | Skill | Primary Subagent |
|-----------|-------|-----------------|
| New feature | `jira-story-delivery` | `engineer` |
| Bug fix | `flutter-bugfix-triage` | `bug-hunter` |
| Refactor | `bloc-refactor-safe` | `flutter-implementer` |
| UI-only change | `flutter-feature-delivery` | `flutter-implementer` |
| Spike / investigation | manual | `bug-hunter` |

## Gate: Ready For Implementation?

- [ ] All ACs parsed and numbered
- [ ] Each AC has a test type assigned
- [ ] Assumptions listed and reasonable
- [ ] Scope mapped to feature path
- [ ] Skill and subagent selected
- [ ] No blocking ambiguities (or assumptions cover them)
- [ ] If Figma attached: `figma-design-intake.md` completed with widget tree + state mapping

If any gate fails → ask the user for clarification before proceeding.
