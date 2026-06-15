# Repo Gotchas

- `BlocProvider.maybeOf<T>(context)` is not available in this repo's `flutter_bloc` usage pattern.
- For nullable BLoC lookup, use guarded `BlocProvider.of<T>(context)` patterns and protect async UI callbacks with `mounted` checks.
- Firebase Analytics ecommerce events require `currency` when `value` is provided.
- For wishlist add-to-cart analytics, use `locator.get<AppConfig>().countryConfig.currency` when item currency can be null.
- For webview interception, preserve known-host logic and scheme safety:
  - `isKnownKmartHost(Uri?)` for Kmart domains/subdomains
  - `isExternalUrl(Uri?)` for non-Kmart `http/https` only
- Be careful around Gradle Kotlin-DSL upgrades; this repo has prior compatibility issues with recent Gradle/plugin resolution.

## GoRouter Navigation Gotchas

- **GoRouter `redirect` drops `extra`**: When `willRedirect = true`, the `extra` parameter is lost. For routes that rely on `extra` data, always return `null` from `redirect` to skip redirection. See the guard in `app_bottom_nav_bar_router.dart`.
- **Never call `context.go()` / `context.push()` directly in widgets** — all navigation must go through `AppNavigationService`. This prevents cross-widget navigation drift and keeps analytics hooks intact.
- **Use `NavigationExtrasManager` for complex object passing**: Deep-link and feature-push routes may pass typed objects. Use `NavigationExtrasManager.put<T>(key, value)` before navigation and `NavigationExtrasManager.get<T>(key)` in the route builder. There is a TTL configured from Optimizely — stale extras are cleared automatically.
- **`featurePaths` vs `deepLinkPaths`**: `featurePaths` are top-level pushed over the current tab. `deepLinkPaths` are stacked on top of a feature path. Placing a route in the wrong list breaks the tab stack depth.
- **`hideBottomNavRoutes`**: Full-screen flows (onboarding, checkout, error pages) must be added here to suppress the bottom nav bar.