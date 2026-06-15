# Agent Dev Kit For Konnect

This folder provides a compact operating system for agent-driven Flutter development.

## Goals
- Faster implementation with minimal context bloat
- Consistent architecture and testing behavior
- Reusable subagent roles and prompt templates

## Structure
- `memory/`: non-negotiable architecture + working constraints + naming conventions + **GoRouter route registry**
- `skills/`: reusable task playbooks + **GoRouter patterns** + code patterns cheatsheet
- `subagents/`: specialized execution roles (incl. story analyst for Jira/AC intake, **navigation for GoRouter screen registration**)
- `templates/`: briefs, PR summaries, bug reports, feature scaffold (**incl. GoRouter steps**), pre-PR checklist (**incl. routing checks**), **Jira story intake, AC traceability matrix, AC validation report**
- `workflows/`: end-to-end execution flow + delegation matrix + **story-to-delivery (AC-driven pipeline)**
- `commands/`: copy-ready command shortcuts
- `prompts/`: reusable prompt presets (token-budget mode, **AC-driven mode**)

## Fast Start
1. Read `memory/global.md` and `memory/architecture.rules`.
2. Check `memory/naming-conventions.md` for file/class patterns.
3. **If adding a navigable screen**: read `memory/gorouter-routes.md` first.
4. Select a skill from `skills/SKILLS.md`.
5. Use `skills/code-patterns.md` for copy-paste-ready patterns.
6. Delegate to a matching subagent in `subagents/`.
7. Use `workflows/task-flow.md` for execution order.
8. Verify with `templates/pre-pr-checklist.md`.
9. Summarize results with `templates/pr-summary.md`.

## Jira Story / AC Workflow
1. User pastes a Jira story or acceptance criteria.
2. Parse with `templates/jira-story-intake.md`.
3. Track with `templates/ac-traceability-matrix.md`.
4. Follow `workflows/story-to-delivery.md` for full AC-driven pipeline.
5. Validate with `templates/ac-validation-report.md`.
6. Use `prompts/ac-driven.prompt.md` for AC-focused output format.

## Figma / Design → UI Workflow
1. User provides Figma link, screenshot, or design description.
2. Extract UI specs with `templates/figma-design-intake.md`.
3. Map screens to widget tree, design tokens to existing theme, states to BLoC.
4. Implement widgets following the extracted structure.
5. Widget tests verify each state renders correct elements per design.
6. Integrates seamlessly with Jira story workflow when both are provided.

## Token Saving Tips
- Keep prompts under 15 lines.
- Include only changed paths, not full files.
- Ask for `diff-only output` and `top-3 risks`.