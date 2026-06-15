# Engineer Brief Template

Use this template when invoking the engineer autopilot workflow.

## Goal

[One sentence outcome]

## Constraints

- Keep diffs minimal and architecture-aligned
- Avoid flavor/secrets/build config changes unless explicitly required
- Preserve public API unless migration is requested

## Scope

- In: [features/files to change]
- Out: [areas not to touch]

## Acceptance Criteria

1. [functional requirement]
2. [error handling requirement]
3. [test coverage expectation]

## Technical Context

- API contracts: [if any]
- Existing patterns to reuse: [BLoC/repository/service]
- Known gotchas: [if any]

## Validation Requirements

- `flutter analyze`
- `flutter test test/src/features/<feature>/`
- Additional checks: [optional]

## Delivery Format

- Plan
- Changes
- Validation
- Risks
- Next
