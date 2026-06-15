# Delegation Matrix

## Pick The Right Agent

### VS Code Copilot Agents (`.github/agents/`) — primary routing
| Task | Agent | File |
|------|-------|------|
| New feature / BLoC / screen / repository | `feature-scaffold` | `.github/agents/feature-scaffold.agent.md` |
| Bug / crash / BLoC state issue / navigation | `flutter-debugger` | `.github/agents/flutter-debugger.agent.md` |
| Architecture review / PR review (read-only) | `arch-reviewer` | `.github/agents/arch-reviewer.agent.md` |
| Write unit/bloc/widget/golden tests | `flutter-tester` | `.github/agents/flutter-tester.agent.md` |
| Safe refactor (extract/rename/split/drift) | `refactor` | `.github/agents/refactor.agent.md` |
| New API / datasource / DTO / repository | `api-integrator` | `.github/agents/api-integrator.agent.md` |

### Subagents (`agent-dev-kit/subagents/`) — used within agent chains
- Jira story / AC intake and parsing: `subagents/story-analyst.md`
- New feature implementation: `subagents/flutter-implementer.md`
- **GoRouter screen registration**: `subagents/navigation.md`
- Bug investigation: `subagents/bug-hunter.md`
- End-to-end requirement to delivery: `subagents/engineer.md`
- Auto-generate tests: `subagents/test-generator.md`
- Auto-generate docs: `subagents/doc-writer.md`
- Quality/review pass: `subagents/code-reviewer.md`
- Validation/test execution: `subagents/test-runner.md`
- Prompt compression: `subagents/token-keeper.md`

## Recommended Sequence
1. `token-keeper` compresses task brief.
2. `story-analyst` parses Jira story and extracts ACs. **(when story/ticket provided)**
3. `flutter-implementer` or `bug-hunter` executes core task.
4. `navigation` registers any new screens in GoRouter. **(when new page added)**
5. `test-generator` auto-creates tests for all changed files. **(automatic — never skip)**
6. `test-runner` validates (analyze + run generated tests).
7. `doc-writer` generates/updates feature documentation. **(automatic for new features)**
8. `code-reviewer` performs final risk review + AC traceability check.

## Story-Driven Sequence (Full AC Workflow)
1. `story-analyst` parses story → produces intake + traceability matrix.
2. `token-keeper` compresses context if story is large.
3. `engineer` plans AC-by-AC implementation.
4. `flutter-implementer` implements each AC in dependency order.
5. `test-generator` creates AC-linked tests for each criterion.
6. `test-runner` validates per-AC and cross-AC.
7. `doc-writer` generates docs for new features.
8. `code-reviewer` verifies traceability matrix + final review.

## Escalation Rule
- If failure persists after 2 fix attempts, stop and request missing context/logs instead of broad speculative refactor.