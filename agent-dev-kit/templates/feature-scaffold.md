# Feature Scaffold Template

Use this to create a new feature matching the repo's established patterns.

## Folder Structure

```
lib/src/features/<feature_name>/
├── data/
│   ├── datasources/
│   │   └── remote/
│   │       └── <feature>_remote_data_source.dart
│   ├── models/
│   │   └── <feature>_model.dart               # @JsonSerializable
│   ├── repositories/
│   │   └── <feature>_repository_impl.dart      # implements I<Feature>Repository
│   └── analytics/
│       └── <feature>_analytics_service.dart     # optional
├── domain/
│   ├── entities/
│   │   └── <feature>_entity.dart               # @freezed or Equatable
│   └── i_repositories/
│       └── i_<feature>_repository.dart         # abstract interface
├── ui/ (or presentation/)
│   ├── bloc/
│   │   ├── <feature>_bloc.dart
│   │   ├── <feature>_event.dart
│   │   └── <feature>_state.dart
│   ├── pages/
│   │   └── <feature>_page.dart
│   └── widgets/
│       └── <feature>_widget.dart
```

Mirror in test:
```
test/src/features/<feature_name>/
├── blocs/
│   └── <feature>_bloc_test.dart
├── data/
│   └── repositories/
│       └── <feature>_repository_test.dart
└── ui/
    ├── pages/
    │   └── <feature>_page_test.dart
    └── widgets/
        └── <feature>_widget_test.dart
```

## BLoC Pattern (Copy-Paste)

### Event
```dart
abstract class <Feature>Event {}

class <Feature>FetchedEvent extends <Feature>Event {}
```

### State (Equatable)
```dart
import 'package:equatable/equatable.dart';

abstract class <Feature>State extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial<Feature>State extends <Feature>State {}
class Loading<Feature>State extends <Feature>State {}
class <Feature>LoadedState extends <Feature>State {
  <Feature>LoadedState({required this.data});
  final <Feature>Model data;
  @override
  List<Object?> get props => [data];
}
class <Feature>ErrorState extends <Feature>State {
  <Feature>ErrorState({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}
```

### BLoC
```dart
import 'package:bloc/bloc.dart';

class <Feature>Bloc extends Bloc<<Feature>Event, <Feature>State> {
  <Feature>Bloc({required <Feature>Repository repository})
      : _repository = repository,
        super(Initial<Feature>State()) {
    on<<Feature>FetchedEvent>(_onFetched);
  }

  final <Feature>Repository _repository;

  Future<void> _onFetched(
    <Feature>FetchedEvent event,
    Emitter<<Feature>State> emit,
  ) async {
    emit(Loading<Feature>State());
    try {
      final result = await _repository.fetch();
      emit(<Feature>LoadedState(data: result));
    } catch (e) {
      emit(<Feature>ErrorState(message: e.toString()));
    }
  }
}
```

## Repository Pattern (Copy-Paste)

### Interface
```dart
abstract class I<Feature>Repository {
  Future<Either<<Feature>Model, ResponseErrorObject>> fetch();
}
```

### Implementation
```dart
class <Feature>Repository implements I<Feature>Repository {
  <Feature>Repository(this._dataSource, this._commonNetworkResponseRepository);

  final <Feature>RemoteDataSource _dataSource;
  final CommonNetworkResponseRepository _commonNetworkResponseRepository;

  @override
  Future<Either<<Feature>Model, ResponseErrorObject>> fetch() async {
    final result = await _dataSource.fetch();
    if (result.statusCode == AppConstants.noError) {
      return Left(<Feature>Model.fromJson(result.body));
    }
    return Right(
      _commonNetworkResponseRepository.processHttpDataIntoResponseObject(result),
    );
  }
}
```

## GoRouter Registration (When Feature Has A Navigable Screen)

### Step 1 — Route Constant (`lib/src/utilities/app_route_names.dart`)
```dart
/// <Feature> screen route path.
const String <feature>ViewRoute = '/<Feature>Screen';
```

### Step 2 — Path Classification (`app_router_path.dart`)
```dart
// Choose ONE of:
final featurePaths = [..., <feature>ViewRoute];      // pushed over current tab
final deepLinkPaths = [..., <feature>ViewRoute];     // deep-linked, stacked above feature
final hideBottomNavRoutes = [..., <feature>ViewRoute]; // also add if full-screen
```

### Step 3 — GoRoute Builder (`goroute_service.dart`)
```dart
static GoRoute _get<Feature>ViewRoute() => GoRoute(
  path: <feature>ViewRoute,
  builder: (context, state) => BlocProvider(
    create: (_) => locator<<Feature>Bloc>()..add(<Feature>FetchedEvent()),
    child: const <Feature>Page(),
  ),
);

// Register in sharedRoutes:
static List<GoRoute> get sharedRoutes => [
  // ...existing
  _get<Feature>ViewRoute(),
];
```

### Step 4 — Navigation Call (Widget / BLoC Side Effect)
```dart
// Simple
locator<AppNavigationService>().navigateTo(context, <feature>ViewRoute);

// With extras
NavigationExtrasManager.put('<feature>_key', entity);
locator<AppNavigationService>().navigateTo(context, <feature>ViewRoute);
```

---

## BLoC Test Pattern (Copy-Paste)
```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([<Feature>Repository])
void main() {
  late <Feature>Bloc bloc;
  late Mock<Feature>Repository repository;

  setUp(() {
    repository = Mock<Feature>Repository();
    bloc = <Feature>Bloc(repository: repository);
  });

  test('initial state is Initial<Feature>State', () {
    expect(bloc.state, Initial<Feature>State());
  });

  blocTest<<Feature>Bloc, <Feature>State>(
    'emits [Loading, Loaded] on successful fetch',
    build: () {
      when(repository.fetch()).thenAnswer((_) async => Left(mockModel));
      return bloc;
    },
    act: (bloc) => bloc.add(<Feature>FetchedEvent()),
    expect: () => [
      Loading<Feature>State(),
      isA<<Feature>LoadedState>(),
    ],
  );
}
```

## Checklist
- [ ] Feature folder created under `lib/src/features/`
- [ ] Interface in `domain/i_repositories/`
- [ ] Impl in `data/repositories/`
- [ ] BLoC + events + states in `ui/bloc/`
- [ ] Registered in `lib/locator.dart`
- [ ] Test folder mirrors source folder
- [ ] `build_runner` run if using `@freezed` or `@JsonSerializable`
- [ ] **Route constant added to `lib/src/utilities/app_route_names.dart`** (if page is navigable)
- [ ] **GoRoute builder added to `lib/src/features/navigation/repository/goroute_service.dart`** (if page is navigable)
- [ ] **Path added to `featurePaths` or `deepLinkPaths` in `app_router_path.dart`** (correct category)
- [ ] **Added to `hideBottomNavRoutes`** (if full-screen — no bottom nav)
- [ ] **`memory/gorouter-routes.md` updated** with new route entry
- [ ] Navigation calls use `AppNavigationService`, not raw `context.go`/`context.push`
