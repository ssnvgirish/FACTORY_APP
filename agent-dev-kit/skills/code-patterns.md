# Code Patterns Cheatsheet

Quick-reference for patterns actually used in this repo. Copy-paste ready.

---

## 1. Either Pattern (Result Type)
The repo uses a custom `Either<L, R>` from `lib/src/packages/domain/types/type/either.dart`.

> **⚠️ Convention in this repo**: `Left` = **success**, `Right` = **failure** (opposite of Haskell standard).

```dart
import 'package:kmart/src/packages/domain/types/type/either.dart';

// Success ← Left
return Left(data);

// Failure ← Right
return Right(ResponseErrorObject(...));
```

In BLoC, fold the result:
```dart
final result = await _repository.fetch();
result.fold(
  (data) => emit(MyFeatureLoadedState(data: data)),      // Left = success
  (error) => emit(MyFeatureErrorState(error.message)),   // Right = failure
);
```

---

## 2. JsonSerializable Model
```dart
import 'package:json_annotation/json_annotation.dart';

part '<file_name>.g.dart';

@JsonSerializable()
class MyModel {
  MyModel({required this.id, required this.name});

  factory MyModel.fromJson(Map<String, dynamic> json) =>
      _$MyModelFromJson(json);

  @JsonKey(defaultValue: '')
  final String id;

  @JsonKey(defaultValue: '')
  final String name;

  Map<String, dynamic> toJson() => _$MyModelToJson(this);
}
```

Then run: `flutter pub run build_runner build --delete-conflicting-outputs`

---

## 3. Freezed Entity
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '<file_name>.freezed.dart';
part '<file_name>.g.dart';

@freezed
abstract class MyEntity with _$MyEntity {
  const factory MyEntity({
    required String id,
    required String name,
  }) = _MyEntity;

  factory MyEntity.fromJson(Map<String, dynamic> json) =>
      _$MyEntityFromJson(json);
}
```

---

## 4. Locator Registration Styles
```dart
// Singleton (created immediately)
..registerSingleton<MyService>(MyService())

// Lazy singleton (created on first access)
..registerLazySingleton<IMyRepository>(
  () => MyRepositoryImpl(locator(), locator()),
)

// Factory (new instance each time)
..registerFactory<MyBloc>(
  () => MyBloc(repository: locator()),
)
```

---

## 5. BlocProvider in GoRouter Route Builder
```dart
// In lib/src/features/navigation/repository/goroute_service.dart
static GoRoute _getMyFeaturePage() => GoRoute(
  path: myFeatureViewRoute,
  builder: (context, state) => BlocProvider(
    create: (_) => locator<MyFeatureBloc>()..add(MyFeatureFetchedEvent()),
    child: const MyFeaturePage(),
  ),
);
```

---

## 6. GoRouter Route Registration (Full 4-Step Pattern)

### Step 1 — Route constant (`lib/src/utilities/app_route_names.dart`)
```dart
const String myFeatureViewRoute = '/MyFeatureScreen';
```

### Step 2 — Path list (`lib/src/third_party_dependencies/app_router/app_router_path.dart`)
```dart
final featurePaths = [
  // ... existing
  myFeatureViewRoute,  // add here for feature-level push
];
```

### Step 3 — GoRoute builder (`goroute_service.dart → sharedRoutes`)
```dart
static List<GoRoute> get sharedRoutes => [
  // ... existing
  _getMyFeaturePage(),
];
```

### Step 4 — Navigate via AppNavigationService (widget or BLoC)
```dart
// Simple
locator<AppNavigationService>().navigateTo(context, myFeatureViewRoute);

// With typed object (use NavigationExtrasManager, NOT context.push extra)
NavigationExtrasManager.put('feature_key', myEntity);
locator<AppNavigationService>().navigateTo(context, myFeatureViewRoute);

// Retrieve in GoRoute builder
final data = NavigationExtrasManager.get<MyEntity>('feature_key');
```

---

## 7. BlocBuilder / BlocConsumer in Widget
```dart
// BlocBuilder — for state → UI rendering only
BlocBuilder<MyFeatureBloc, MyFeatureState>(
  builder: (context, state) {
    if (state is LoadingMyFeatureState) return const CircularProgressIndicator();
    if (state is MyFeatureLoadedState) return MyContent(data: state.data);
    if (state is MyFeatureErrorState) return ErrorWidget(state.message);
    return const SizedBox.shrink();
  },
)

// BlocConsumer — when you need both rendering AND side effects (navigation, snackbar)
BlocConsumer<MyFeatureBloc, MyFeatureState>(
  listenWhen: (prev, current) => current is MyFeatureSuccessState,
  listener: (context, state) {
    if (state is MyFeatureSuccessState) {
      // Side effect: navigate, show snackbar, etc.
      locator<AppNavigationService>().navigateTo(context, someRoute);
    }
  },
  buildWhen: (prev, current) => current is! MyFeatureSuccessState,
  builder: (context, state) {
    if (state is LoadingMyFeatureState) return const CircularProgressIndicator();
    if (state is MyFeatureLoadedState) return MyContent(data: state.data);
    return const SizedBox.shrink();
  },
)
```

---

## 7. Network Call Through GraphQL
```dart
// Data source uses the shared GQL infrastructure
import 'package:kmart/src/resources/remote_data_resource/gql/interface/inetworklib.dart';

class MyRemoteDataSource {
  MyRemoteDataSource(this._networkLib);
  final INetworkLib _networkLib;

  Future<dynamic> fetchData(String param) async {
    return _networkLib.performQuery(
      QueryMutation.myQuery(param),
    );
  }
}
```

---

## 8. HTTP API Call
```dart
import 'package:kmart/src/resources/remote_data_resource/http/ihttp_api_helper.dart';

class MyRemoteDataSource {
  MyRemoteDataSource(this._httpApiHelper);
  final IHttpApiHelper _httpApiHelper;

  Future<HttpResponseData> fetchData() async {
    return _httpApiHelper.get(url: 'endpoint/path');
  }
}
```

---

## 9. Analytics Event Tracking
```dart
class MyAnalyticsService {
  MyAnalyticsService(this._eventTracker);
  final FirebaseEventTracker _eventTracker;

  void trackScreenView({Map<String, String>? parameters}) {
    _eventTracker.logEvent(
      name: 'my_screen_view',
      parameters: parameters,
    );
  }
}
```

---

## 10. Test Setup Pattern — Mockito (Code-Generated Mocks)
```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '<test_file>.mocks.dart';

@GenerateMocks([IMyRepository, MyAnalyticsService])
void main() {
  late MyBloc bloc;
  late MockIMyRepository repository;

  setUp(() {
    repository = MockIMyRepository();
    bloc = MyBloc(repository: repository);
  });

  tearDown(() => bloc.close());
  // ... tests
}
```
Run after adding new mocks: `flutter pub run build_runner build --delete-conflicting-outputs`

---

## 11. Test Setup Pattern — Mocktail (No Code Generation)
```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Manual mock class — no @GenerateMocks needed
class MockMyRepository extends Mock implements IMyRepository {}

void main() {
  late MyBloc bloc;
  late MockMyRepository repository;

  setUpAll(() {
    // Register fallback values for sealed/custom types used in when()
    registerFallbackValue(MyEntityFake());
  });

  setUp(() {
    repository = MockMyRepository();
    bloc = MyBloc(repository: repository);
  });

  tearDown(() => bloc.close());

  blocTest<MyBloc, MyBlocState>(
    'emits [Loading, Loaded] on success',
    build: () {
      when(() => repository.fetch()).thenAnswer((_) async => Left(mockEntity));
      return bloc;
    },
    act: (bloc) => bloc.add(MyFeatureFetchedEvent()),
    expect: () => [
      isA<LoadingMyState>(),
      isA<MyLoadedState>(),
    ],
    verify: (_) {
      verify(() => repository.fetch()).called(1);
    },
  );
}
```
> **Use mocktail** when you want to avoid `build_runner` for test mocks. **Use mockito** for consistency with existing test files in this repo (most existing tests use mockito).

---

## 12. BLoC With Either Fold Pattern
```dart
Future<void> _onFetched(
  MyFeatureFetchedEvent event,
  Emitter<MyFeatureState> emit,
) async {
  emit(LoadingMyFeatureState());

  final result = await _repository.fetch();

  result.fold(
    (data) => emit(MyFeatureLoadedState(data: data)),   // Left = success
    (error) => emit(MyFeatureErrorState(error.message)), // Right = failure
  );
}
```

---

## 13. Freezed BLoC State
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '<feature>_state.freezed.dart';

@freezed
sealed class MyFeatureState with _$MyFeatureState {
  const factory MyFeatureState.initial() = MyFeatureInitialState;
  const factory MyFeatureState.loading() = MyFeatureLoadingState;
  const factory MyFeatureState.loaded({required MyFeatureEntity data}) = MyFeatureLoadedState;
  const factory MyFeatureState.error({required String message}) = MyFeatureErrorState;
}
```

Use in BLoC builder:
```dart
BlocBuilder<MyFeatureBloc, MyFeatureState>(
  builder: (context, state) => state.when(
    initial: () => const SizedBox.shrink(),
    loading: () => const CircularProgressIndicator(),
    loaded: (data) => MyContent(data: data),
    error: (message) => ErrorWidget(message),
  ),
)
```

---

## 14. Deep Link Route With Query Parameters
```dart
// In goroute_service.dart
static GoRoute _getMyDeepLinkRoute() => GoRoute(
  path: myDeepLinkViewRoute,
  builder: (context, state) {
    // Query params from deep link URL
    final productId = state.uri.queryParameters['productId'];
    final campaignId = state.uri.queryParameters['campaign'];
    return BlocProvider(
      create: (_) => locator<MyBloc>()
        ..add(MyFetchedEvent(productId: productId, campaign: campaignId)),
      child: const MyDeepLinkPage(),
    );
  },
);
```
