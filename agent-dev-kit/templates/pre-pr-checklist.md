# Pre-PR Checklist

Run through before opening a pull request. Agent should auto-verify these.

## Code Quality
- [ ] `flutter analyze` passes with zero issues
- [ ] No `// ignore_for_file:` added without justification
- [ ] No `*.g.dart` or `*.freezed.dart` files hand-edited
- [ ] Package imports used (not relative imports)

## Architecture
- [ ] New code follows feature folder structure (`data/domain/ui`)
- [ ] New repository has interface in `domain/i_repositories/`
- [ ] New dependency registered in `lib/locator.dart`
- [ ] No DTOs leaked into UI layer
- [ ] No direct `locator.get()` calls in pure domain/entity logic

## Routing (When Feature Has A Navigable Screen)
- [ ] Route path constant added to `lib/src/utilities/app_route_names.dart`
- [ ] Route path added to correct list in `app_router_path.dart` (`featurePaths`, `deepLinkPaths`, and/or `hideBottomNavRoutes`)
- [ ] `GoRoute` builder added to `goroute_service.dart` and registered in `sharedRoutes`
- [ ] Page wrapped in `BlocProvider` inside the GoRoute builder (not in the widget)
- [ ] Navigation calls use `AppNavigationService` — no raw `context.go`/`context.push` in widgets or BLoCs
- [ ] If passing objects between routes, `NavigationExtrasManager` used (not `context.push(extra:)`)
- [ ] `memory/gorouter-routes.md` updated with new route entry

## BLoC
- [ ] Events are descriptive and past-tense (`FetchedEvent`, `LoadedEvent`)
- [ ] States extend `Equatable` with correct `props`
- [ ] No `BuildContext` usage across async gaps without `mounted` check
- [ ] Side effects driven through BLoC, not widgets

## Testing
- [ ] BLoC tests use `bloc_test` with `blocTest<>()`
- [ ] Mocks generated with `@GenerateMocks` + `build_runner`
- [ ] Test folder mirrors source folder structure
- [ ] Error/edge cases covered (empty data, network failure)
- [ ] `flutter test test/src/features/<feature>/` passes

## Safety
- [ ] No secrets, tokens, or PII logged
- [ ] No changes to flavors/CI unless task requires it
- [ ] No unrelated files modified
- [ ] `build_runner` run if freezed/json_serializable models changed

## Design Compliance (When Figma/Design Provided)
- [ ] All screens from design are implemented
- [ ] All states (loading, empty, error, loaded) match design
- [ ] Colors/typography use existing theme tokens (no hardcoded values)
- [ ] Spacing/padding matches design specs
- [ ] Interactions match design interaction specs
- [ ] Touch targets ≥ 44x44 logical pixels
- [ ] Widget tests cover each state's visual output

## PR Description
- [ ] Uses `templates/pr-summary.md` format
- [ ] Uses `templates/agent-delivery-report.md` for agent-driven PRs
- [ ] Risks section filled in
- [ ] Validation commands and results included
