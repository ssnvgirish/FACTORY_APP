# Konnect Codebase Snapshot

> **Purpose:** Instant codebase map — load this instead of scanning the repo. Update it when adding or removing features.
> **Last Synced:** See git blame / commit date on this file.

---

## Feature Inventory (`lib/src/features/`)

| Feature | Path | Description |
|---------|------|-------------|
| `account` | `lib/src/features/account/` | User account management |
| `alert` | `lib/src/features/alert/` | In-app alert/banner system |
| `app_config` | `lib/src/features/app_config/` | Remote config, feature flags |
| `app_router` | `lib/src/features/app_router/` | GoRouter setup — `StatefulShellRoute.indexedStack` |
| `bag` | `lib/src/features/bag/` | Shopping bag (native + webview) |
| `barcode` | `lib/src/features/barcode/` | Barcode/QR scanner |
| `brand_logo` | `lib/src/features/brand_logo/` | Brand logo display utility |
| `catalogue` | `lib/src/features/catalogue/` | Product catalogue browsing |
| `category_preferences` | `lib/src/features/category_preferences/` | User category preference settings |
| `common` | `lib/src/features/common/` | Shared feature-level utilities |
| `contentful_components` | `lib/src/features/contentful_components/` | CMS-driven UI components (Contentful) |
| `contextual_message` | `lib/src/features/contextual_message/` | Contextual in-app messaging |
| `deep_linking` | `lib/src/features/deep_linking/` | Branch.io deep link handling |
| `digital_receipt` | `lib/src/features/digital_receipt/` | Digital receipt display |
| `discover` | `lib/src/features/discover/` | Discover/explore tab |
| `flybuys` | `lib/src/features/flybuys/` | Flybuys loyalty integration |
| `force_update` | `lib/src/features/force_update/` | Forced app update gate |
| `home` | `lib/src/features/home/` | Home tab feed (Contentful-driven, mosaic layouts) |
| `inapp_web_view` | `lib/src/features/inapp_web_view/` | In-app WebView (known-host interception) |
| `mini_pdp` | `lib/src/features/mini_pdp/` | Mini product detail sheet |
| `more` | `lib/src/features/more/` | More/settings tab |
| `navigation` | `lib/src/features/navigation/` | Bottom navigation bar |
| `next_gen_home` | `lib/src/features/next_gen_home/` | Next-gen home feed (in development) |
| `onboarding` | `lib/src/features/onboarding/` | First-launch onboarding flow |
| `onepass` | `lib/src/features/onepass/` | OnePass loyalty program |
| `orders` | `lib/src/features/orders/` | Order history and tracking |
| `pdp` | `lib/src/features/pdp/` | Product Detail Page |
| `perso_categories` | `lib/src/features/perso_categories/` | Personalised category recommendations |
| `perso_products` | `lib/src/features/perso_products/` | Personalised product recommendations |
| `perso_recommendations_feedback` | `lib/src/features/perso_recommendations_feedback/` | User feedback on recommendations |
| `plp` | `lib/src/features/plp/` | Product Listing Page |
| `postcode` | `lib/src/features/postcode/` | Postcode selector/store context |
| `profile_completion` | `lib/src/features/profile_completion/` | Profile completion nudge |
| `push_notification` | `lib/src/features/push_notification/` | Braze push notification handler |
| `receipts` | `lib/src/features/receipts/` | Purchase receipts list |
| `recent_order` | `lib/src/features/recent_order/` | Recent order widget/banner |
| `search` | `lib/src/features/search/` | Search with typeahead, pills |
| `sharedwishlist` | `lib/src/features/sharedwishlist/` | Shareable wishlist via deep link |
| `shop` | `lib/src/features/shop/` | Shop tab root |
| `shoppable_feed` | `lib/src/features/shoppable_feed/` | Shoppable feed (Tolstoy integration) |
| `store_locator` | `lib/src/features/store_locator/` | Nearby store finder with geolocation |
| `team_member` | `lib/src/features/team_member/` | Team member mode |
| `user_avatar` | `lib/src/features/user_avatar/` | User avatar display |
| `user_engagement` | `lib/src/features/user_engagement/` | Engagement nudges and prompts |
| `user_preferences` | `lib/src/features/user_preferences/` | User settings and preferences |
| `wallet` | `lib/src/features/wallet/` | Wallet / offers |
| `wishlist` | `lib/src/features/wishlist/` | Wishlist (online + in-store sub-features) |

---

## Services (`lib/src/services/`)

| Service | File(s) | Purpose |
|---------|---------|---------|
| Analytics | `analytics/unified_analytics_service.dart` | Central analytics facade (Firebase, Braze, Tealium) |
| Analytics Utility | `analytics/analytics_utility.dart` | Shared analytics helpers |
| Branch | `branch/branch_service_impl.dart` | Deep linking via Branch.io |
| Contentful | `contentful/` | CMS content delivery |
| Firebase | `firebase/` | Firebase services (analytics, remote config) |
| Native Integration | `native_integration/` | Native platform channels |
| Observability | `observability/` | Sentry crash reporting, logging |
| Optimizely | `optimizely/` | A/B testing and feature flags |
| Tealium | `tealium/` | Tag management / analytics |
| Search Pills | `search_pills_service.dart` | Search suggestion pills |

---

## Packages (`lib/src/packages/`)

| Package | Purpose |
|---------|---------|
| `domain/` | Abstract repos + entities — pure Dart, zero Flutter imports |
| `data/` | Repository implementations, DTOs, data sources |
| `data_api/` | HTTP/GraphQL API client (`ApiClientImpl`, `RetryClient`) |
| `data_credentials/` | Secure credential storage |
| `design_system_kmart/` | Design tokens, components, themes (`DesignColors`, `DesignTypography`, `AppDimens`) |
| `network_connectivity/` | Network status detection |

---

## Core Files

| File | Purpose |
|------|---------|
| `lib/locator.dart` | GetIt DI registrations (100+ entries) — register ALL new services here |
| `lib/routers.dart` | Navigator 1.0 route generator for in-tab screens |
| `lib/src/features/app_router/` | GoRouter setup with tabs |
| `lib/main.dart` | App entry point |
| `analysis_options.yaml` | Lint rules |
| `pubspec.yaml` | Dependencies |

---

## Architecture Quick Ref

```
UI (Page/Widget) → BLocProvider → BLoC → Repository (I*Repository) → DataSource → API
                                  ↑                                   ↑
                              GetIt locator                    locator registered
```

- **Feature scope**: `lib/src/features/<feature>/bloc/`, `data/`, `ui/`
- **Shared scope**: `lib/src/packages/domain/` (abstract), `lib/src/packages/data/` (impl)
- **DI**: Always constructor inject. Register in `lib/locator.dart`.
- **Error**: `Either<Failure, T>` from repository → BLoC `.fold()`

---

## Known Active Areas / Tech Debt

> Update this section as work progresses. Helps agents skip irrelevant areas.

| Area | Status | Notes |
|------|--------|-------|
| `next_gen_home` | 🚧 In development | New home feed replacing `home` feature |
| `home` | ✅ Stable | Contentful-driven, do not refactor without explicit task |
| `wishlist` | ✅ Stable | Has sub-features: `wishlist_online/`, `wishlist_instore/` |
| `bag` | ✅ Stable | Uses WebView for checkout flow |
| `search` | ✅ Stable | GraphQL-backed typeahead |
| `onepass` / `flybuys` | ✅ Stable | Loyalty — touch carefully, QA coverage required |
| `pdp` / `plp` | ✅ Stable | Core commerce — high traffic, no unnecessary changes |
| WebView interception | ⚠️ Gotcha | Uses `isKnownKmartHost()` + `isExternalUrl()` — preserve logic |
| Gradle/Kotlin-DSL | ⚠️ Fragile | Prior compatibility issues — avoid upgrading without explicit task |

---

## How To Update This File

Run this when a significant feature is added, renamed, or removed:

1. Update the **Feature Inventory** table.
2. Update **Known Active Areas** with current in-progress work.
3. Commit with: `docs(agent): update codebase-snapshot [JIRA-ID]`
