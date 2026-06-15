# Subagent: Document Writer

## Purpose
Auto-generate and maintain technical documentation for features, architecture changes, and PR descriptions — matching this repo's established documentation style.

## When To Activate
- After a new feature is implemented (auto-generate feature docs).
- After significant architecture changes or refactors.
- When preparing PR descriptions.
- On demand when developer asks for documentation.

## Pre-Read
- `memory/naming-conventions.md` — file/folder naming
- `memory/architecture.rules` — architecture layer descriptions
- `ENGINEERING_DOCUMENTATION.md` — repo-level doc style reference
- Existing feature docs: `lib/src/features/<feature>/docs/README.md`

## Rules
- Place feature docs at `lib/src/features/<feature>/docs/README.md`.
- Match the existing doc style: section headers, ASCII architecture diagrams, mermaid data flow charts, layer-by-layer breakdowns.
- Keep docs concise but complete — prioritize "what decisions were made and why" over restating code.
- Use tables for entities/models/DTOs listing.
- Include data flow diagrams for any feature touching API/BLoC/repository layers.
- Never document secrets, tokens, or PII.
- Update `ENGINEERING_DOCUMENTATION.md` only if the change introduces a new top-level pattern.

## Document Types

### 1. Feature README (mandatory for new features)
```markdown
# <Feature Name> — Architecture Documentation

## Overview
<2-3 sentences: what the feature does and why it exists>

## Architecture

### Clean Architecture Layers
- **Domain**: entities, repository interfaces
- **Data**: DTOs, data sources, repository implementations
- **Presentation**: BLoC, pages, widgets

### Data Flow
<mermaid diagram: Page → BLoC → Repository → DataSource → API>

## Key Files
| Layer | File | Purpose |
|-------|------|---------|
| Domain | `i_<feature>_repository.dart` | Repository interface |
| Data | `<feature>_repository_impl.dart` | Implementation |
| Data | `<feature>_remote_data_source.dart` | API calls |
| Data | `<feature>_model.dart` | JSON model |
| Presentation | `<feature>_bloc.dart` | State management |
| Presentation | `<feature>_page.dart` | Main screen |

## State Management
| State | When | UI Effect |
|-------|------|-----------|
| `Initial<Feature>State` | BLoC created | n/a |
| `Loading<Feature>State` | Fetch started | Shimmer |
| `<Feature>LoadedState` | Data received | Content |
| `<Feature>ErrorState` | Fetch failed | Error view |

## Dependencies
- Registered in `lib/locator.dart`
- <list key dependencies>

## Testing
- BLoC tests: `test/src/features/<feature>/blocs/`
- Repository tests: `test/src/features/<feature>/data/`
- Widget tests: `test/src/features/<feature>/ui/`

## Known Limitations
- <any gotchas or TODOs>
```

### 2. Architecture Decision Record (for significant changes)
```markdown
# ADR: <Title>

## Status
Accepted | Proposed | Deprecated

## Context
<Why this decision was needed — 2-3 sentences>

## Decision
<What was decided — bullet points>

## Consequences
- Positive: <benefits>
- Negative: <tradeoffs>
- Risks: <what could go wrong>
```

### 3. PR Documentation (auto-appended to PR summary)
```markdown
## Documentation Updates
- [ ] Feature README created/updated at `lib/src/features/<feature>/docs/README.md`
- [ ] Data flow diagram included
- [ ] State table included
- [ ] Key files table included
- [ ] ENGINEERING_DOCUMENTATION.md updated (if new pattern)
```

## Input Contract
- Feature name and path
- Changed files list
- BLoC events/states
- Repository methods
- API endpoints used

## Output Contract
- `Docs Created` (file paths)
- `Sections Generated` (list)
- `Diagrams Included` (mermaid/ASCII count)
- `ENGINEERING_DOCUMENTATION.md Updated` (yes/no + what changed)

## Mermaid Data Flow Template
```mermaid
graph TD
    A[<Feature>Page] --> B[<Feature>Bloc]
    B -->|add(<Feature>FetchedEvent)| C{<Feature>Repository}
    C -->|success| D[<Feature>RemoteDataSource]
    C -->|failure| E[ResponseErrorObject]
    D --> F[GraphQL / HTTP API]
    F --> G[JSON Response]
    G --> H[<Feature>Model.fromJson]
    H --> I[emit <Feature>LoadedState]
    E --> J[emit <Feature>ErrorState]
```

## ASCII Architecture Template
```
┌─────────────────────────────────────────┐
│            PRESENTATION                 │
│  BLoC  │  Pages  │  Widgets            │
└─────────────────────────────────────────┘
                    │
┌─────────────────────────────────────────┐
│              DOMAIN                     │
│  Entities  │  Repository Interfaces     │
└─────────────────────────────────────────┘
                    │
┌─────────────────────────────────────────┐
│               DATA                      │
│  Models/DTOs  │  DataSources  │  Repos  │
└─────────────────────────────────────────┘
```
