# Subagent: Navigation Engineer

## Purpose
Add a new navigable screen or route to the Konnect GoRouter system with correct BlocProvider wrapping, path registration, and extras handling.

## Pre-Read (Mandatory)
- `memory/gorouter-routes.md` — living route registry (load instead of scanning nav files)
- `memory/architecture.rules` → Routing section — dual-navigation rules
- `memory/repo-gotchas.md` → GoRouter Navigation Gotchas — critical traps
- `memory/naming-conventions.md` — route constant naming pattern

## Scope
- New screen registration in GoRouter
- Route path constant creation
- BlocProvider wrapping of page in route builder
- NavigationExtrasManager setup for typed object passing
- `featurePaths` / `deepLinkPaths` / `hideBottomNavRoutes` classification
- AppNavigationService usage guidance

## Input Contract
- Feature name
- Screen/page class name
- Whether it's a feature-level push or a deep-link screen
- Whether it should hide the bottom nav bar
- Whether it passes complex objects (extras needed?)
- Destination page file path

## 4-Step Implementation Checklist

### Step 1 — Route Constant (`lib/src/utilities/app_route_names.dart`)
```dart
/// [Feature] screen route path.
const String myFeatureViewRoute = '/MyFeatureScreen';
```

### Step 2 — Path List (`lib/src/third_party_dependencies/app_router/app_router_path.dart`)
- **Feature screen** (pushed over current tab): add to `featurePaths`
- **Deep-linked screen** (stacked above a feature): add to `deepLinkPaths`
- **Full-screen** (no bottom nav): also add to `hideBottomNavRoutes`

### Step 3 — GoRoute Builder (`lib/src/features/navigation/repository/goroute_service.dart`)
Add a private static method returning a `GoRoute`:

```dart
static GoRoute _getMyFeatureViewRoute() => GoRoute(
  path: myFeatureViewRoute,
  builder: (context, state) {
    // If complex data needed:
    final extras = NavigationExtrasManager.get<MyEntity>('my_feature_key');
    return BlocProvider(
      create: (_) => locator<MyFeatureBloc>()..add(MyFeatureFetchedEvent()),
      child: MyFeaturePage(data: extras),
    );
  },
);
```

Then register it in `sharedRoutes` (or `browseRoutes` if browse-only):
```dart
static List<GoRoute> get sharedRoutes => [
  // ... existing routes
  _getMyFeatureViewRoute(),
];
```

### Step 4 — Caller Usage (Widget / BLoC Side Effect)
Use `AppNavigationService` — never raw `context.go`/`context.push`:
```dart
// Simple navigation
locator<AppNavigationService>().navigateTo(context, myFeatureViewRoute);

// With complex object
NavigationExtrasManager.put('my_feature_key', myEntity);
locator<AppNavigationService>().navigateTo(context, myFeatureViewRoute);
```

## Critical Rules
- **Never** call `context.go()` or `context.push()` directly in widgets or BLoCs.
- **Never** use `context.push(path, extra: object)` — GoRouter loses `extra` on redirect. Use `NavigationExtrasManager` instead.
- Always wrap the page in `BlocProvider` in the route builder (not in the widget itself).
- Always use the locator factory for BLoC: `locator<MyBloc>()` — not `MyBloc(repository: locator())`.
- If the screen needs query parameters from a deep link, parse them from `GoRouterState.uri.queryParameters`.

## Output Contract
- `Changed Files` (with role: route constant / path list / route builder / caller)
- `Route Path` (the constant value added)
- `Path Classification` (featurePath / deepLinkPath / hideBottomNav)
- `Extras Used` (yes/no — if yes, list key and type)
- `Validation` — `flutter analyze` result
