# Naming Conventions

## Files
| Type | Pattern | Example |
|------|---------|---------|
| BLoC | `<feature>_bloc.dart` | `orders_bloc.dart` |
| Events | `<feature>_event.dart` | `orders_event.dart` |
| States | `<feature>_state.dart` | `orders_state.dart` |
| Model (data layer) | `<feature>_model.dart` | `orders_model.dart` |
| Entity (domain) | `<feature>_entity.dart` | `search_product_entity.dart` |
| Interface repo | `i_<feature>_repository.dart` | `i_search_repository.dart` |
| Impl repo | `<feature>_repository_impl.dart` | `search_repository_impl.dart` |
| Remote data source | `<feature>_remote_data_source.dart` | `search_pills_remote_datasource.dart` |
| Analytics | `<feature>_analytics_service.dart` | `orders_analytics_service.dart` |
| Page | `<feature>_page.dart` | `orders_page.dart` |
| Widget | `<feature>_<purpose>_widget.dart` | `orders_list_widget.dart` |
| Test | `<source_file>_test.dart` | `orders_bloc_test.dart` |
| Mock (generated) | `<test_file>.mocks.dart` | `orders_bloc_test.mocks.dart` |
| Constants/strings | `<feature>_strings.dart` | `orders_strings.dart` |

## Classes
| Type | Pattern | Example |
|------|---------|---------|
| BLoC | `<Feature>Bloc` | `OrdersBloc` |
| Event (abstract) | `<Feature>Event` | `OrdersEvent` |
| Event (concrete) | `<Feature><Action>Event` | `OrdersFetchedEvent` |
| State (abstract) | `<Feature>State` | `OrdersState` |
| State (concrete) | `<Status><Feature>State` or `<Feature><Status>State` | `LoadingOrdersState`, `OrderHistoryLoadedState` |
| Model | `<Feature>Model` | `OrderHistoryModel` |
| Entity | `<Feature>Entity` | `SearchProductEntity` |
| Interface | `I<Feature>Repository` | `ISearchRepository` |
| Implementation | `<Feature>Repository` | `SearchRepository` |
| Analytics | `<Feature>AnalyticsService` | `OrdersAnalyticsService` |

## Folders
- Feature root: `lib/src/features/<snake_case_feature>/`
- Clean-arch layers: `data/`, `domain/`, `ui/` (or `presentation/`)
- Sub-features: nest under parent, e.g. `wishlist/wishlist_online/`, `wishlist/wishlist_instore/`
- Services/utilities: `lib/src/services/`, `lib/src/utilities/`
- Packages: `lib/src/packages/`

## Import Style
- Use **package imports** (`package:kmart/...`), not relative imports.
- Enforced by `prefer_relative_imports: false` in `analysis_options.yaml`.
