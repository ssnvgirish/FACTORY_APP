# GoRouter Route Registry

> **Purpose:** Living map of all navigable routes. Load this instead of scanning navigation files.
> **Last Synced:** See git blame / commit date on this file.

---

## Navigation Architecture Summary

```
app_bottom_nav_bar_router.dart (GoRouter root)
 └── StatefulShellRoute.indexedStack (4 tabs)
      ├── /HomeScreen       → HomeTab   → routes: sharedRoutes + homeRoutes
      ├── /CategoryPage     → BrowseTab → routes: browseRoutes
      ├── /WishlistPage     → Wishlist  → routes: sharedRoutes
      └── /BagView          → BagTab    → routes: sharedRoutes

GoRouteService / RouteDefinitions (goroute_service.dart)
 └── sharedRoutes[] — GoRoute builders shared by all tabs
 └── browseRoutes[] — Browse-only routes

lib/routers.dart — Navigator 1.0 (legacy in-tab pushes, still used)
```

---

## Route Registration Files

| Step | File | What to add |
|------|------|-------------|
| 1 | `lib/src/utilities/app_route_names.dart` | Route path constant string |
| 2 | `lib/src/third_party_dependencies/app_router/app_router_path.dart` | Add to `featurePaths` or `deepLinkPaths` |
| 3 | `lib/src/features/navigation/repository/goroute_service.dart` | `_getMyFeatureViewRoute()` static method |
| 4 | `goroute_service.dart → sharedRoutes[]` | Add `_getMyFeatureViewRoute()` to the list |

**Optional:**
- Add to `hideBottomNavRoutes` if it's a full-screen flow (no bottom nav).
- Add to `lib/routers.dart` if you also need Navigator 1.0 fallback.

---

## Path Categories

### `featurePaths` — top-level feature screens (pushed over current tab)
These produce a tab stack depth of: `TabRoot → Feature`.

| Route Constant | Path | Feature |
|----------------|------|---------|
| `searchViewRoute` | `/SearchScreen` | Search |
| `nativeSearchViewRoute` | `/NativeSearchScreen` | Search (native) |
| `productDetailsPageViewRoute` | `/ProductDetailsPageScreen` | PDP |
| `accountViewRoute` | `/AccountScreen` | Account |
| `storeLocatorRouter` | `/StoreLocatorRoute` | Store Locator |
| `myOrdersViewRoute` | `/MyOrdersScreen` | Orders |
| `postCodeSelectionViewRoute` | `/PostCodeSelectionScreen` | Postcode |
| `bagWebViewRoute` | `/BagWebView` | Bag (web) |
| ... | ... | (see app_router_path.dart for full list) |

### `deepLinkPaths` — stacked on top of a feature (depth: `Tab → Feature → DeepLink`)
| Route Constant | Path | Feature |
|----------------|------|---------|
| `productDetailsViewRoute` | `/ProductDetailsView` | PDP deep link |
| `productListingViewRoute` | `/ProductListingView` | PLP |
| ... | ... | |

### `hideBottomNavRoutes` — full-screen (no bottom nav bar)
| Route Constant | Path |
|----------------|------|
| `onBoardingViewRoute` | `/OnBoardingScreen` |
| `bagWebViewRoute` | `/BagWebView` |
| `updateViewRoute` | `/UpdateScreen` |
| `commonErrorViewRoute` | `/CommonErrorWidget` |
| `onePassAuthWebViewRoute` | `/OnePassAuthWebViewWidget` |
| `deleteAccountViewRoute` | `/DeleteAccountScreen` |
| ... | ... | (see app_router_path.dart for full list) |

---

## Navigation Services

### `AppNavigationService` (preferred — use this in widgets/BLoCs)
```dart
import 'package:kmart/src/third_party_dependencies/app_router/services/app_navigation_service.dart';

// Navigate to a tab root
appNavigationService.navigateToHome(context);

// Navigate to any named route
appNavigationService.navigateTo(context, myFeatureViewRoute);
```

### `NavigationExtrasManager` (for passing typed objects through routes)
```dart
import 'package:kmart/src/third_party_dependencies/app_router/utils/navigation_extras_manager.dart';

// Store before navigation
NavigationExtrasManager.put('my_key', myEntity);

// Retrieve in GoRoute builder
final data = NavigationExtrasManager.get<MyEntity>('my_key');

// Take (get + remove, for single-use)
final data = NavigationExtrasManager.take<MyEntity>('my_key');
```

---

## GoRoute Builder Pattern (in `goroute_service.dart`)

```dart
static GoRoute _getMyFeatureViewRoute() => GoRoute(
  path: myFeatureViewRoute,
  builder: (context, state) {
    // Optional: extract extras
    final extras = NavigationExtrasManager.get<MyEntity>('my_key');
    return BlocProvider(
      create: (_) => locator<MyFeatureBloc>()..add(MyFeatureFetchedEvent()),
      child: MyFeaturePage(extras: extras),
    );
  },
);
```

---

## Tab Root Routes (app_bottom_nav_bar_router.dart)

| Tab | Path | Root Widget |
|-----|------|-------------|
| Home | `/HomeScreen` | `AppPages.instance.getNativeHomePage()` |
| Browse | `/CategoryPage` | `DiscoverPageBuilder` |
| Wishlist | `/WishlistPage` | `AppPages.instance.getWishlistPage()` |
| Bag | `/BagView` | `AppPages.instance.getBagPage()` or web |

---

## How To Update This File

When adding a new navigable screen:
1. Add its row to the correct path category table above.
2. Add the GoRoute builder signature to the "Pattern" reference.
3. Commit with: `docs(agent): update gorouter-routes [JIRA-ID]`
