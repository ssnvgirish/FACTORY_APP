# Subagent: Test Generator

## Purpose
Automatically generate unit, BLoC, repository, and widget tests for any new or changed feature code.

## When To Activate
- **Always** — after any feature implementation or bug fix that changes behavior.
- Triggered automatically in the task flow between "Implement" and "Validate" steps.

## Pre-Read
- `memory/naming-conventions.md` — test file/class naming
- `skills/code-patterns.md` — Pattern #10 (Test Setup), and test templates below

## Rules
- Mirror source folder structure under `test/src/features/<feature>/`.
- One test file per source file that contains logic (BLoC, repository, service).
- Use `@GenerateMocks` + `mockito` for mock generation (repo convention).
- Use `blocTest<>()` from `bloc_test` for all BLoC tests.
- Use `testWidgets` with `createWidgetUnderTest()` helper for widget tests.
- Every test file must have `setUp()` and clean mock instantiation.
- Prefer Arrange/Act/Assert (AAA) commenting style.

## Test Coverage Requirements
For each changed/new file, generate tests covering:

### BLoC (mandatory for every BLoC)
1. Initial state check
2. Happy path: event → [Loading, Loaded] state sequence
3. Empty data path: event → [Loading, Loaded(empty)]
4. Error path: event → [Loading, Error] when repository throws
5. Verify mock interactions with `verify().called()`

### Repository (mandatory for every repository)
1. Success path: returns `Left(model)` on valid response
2. Null/empty response: returns null or empty model
3. Network error: returns `Right(ResponseErrorObject)` or throws
4. Verify data source called with correct parameters

### Widget (mandatory for pages, recommended for complex widgets)
1. Renders required UI elements (find.byType, find.text)
2. Displays correct text/labels
3. Handles each BLoC state (loading shimmer, loaded content, error view, empty view)
4. Interactive elements respond to taps

## Input Contract
- List of changed/created source files
- BLoC event/state definitions
- Repository method signatures

## Output Contract
- `Test Files Created` (paths)
- `Test Cases` (count per file, names)
- `Mock Classes Needed` (list for @GenerateMocks)
- `Build Runner Required` (yes/no — yes if new mocks added)
- `Run Command` (exact flutter test command for the generated tests)

## BLoC Test Template
```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kmart/src/features/<feature>/ui/bloc/<feature>_bloc.dart';
import 'package:kmart/src/features/<feature>/ui/bloc/<feature>_event.dart';
import 'package:kmart/src/features/<feature>/ui/bloc/<feature>_state.dart';
import 'package:kmart/src/features/<feature>/data/repositories/<feature>_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '<feature>_bloc_test.mocks.dart';

@GenerateMocks([<Feature>Repository])
void main() {
  late <Feature>Bloc bloc;
  late Mock<Feature>Repository mockRepository;

  setUp(() {
    mockRepository = Mock<Feature>Repository();
    bloc = <Feature>Bloc(repository: mockRepository);
  });

  tearDown(() => bloc.close());

  group('<Feature>Bloc', () {
    test('initial state is Initial<Feature>State', () {
      expect(bloc.state, Initial<Feature>State());
    });

    blocTest<<Feature>Bloc, <Feature>State>(
      'emits [Loading, Loaded] on successful fetch',
      build: () {
        when(mockRepository.fetch()).thenAnswer((_) async => mockData);
        return bloc;
      },
      act: (bloc) => bloc.add(<Feature>FetchedEvent()),
      expect: () => [
        Loading<Feature>State(),
        isA<<Feature>LoadedState>(),
      ],
      verify: (_) {
        verify(mockRepository.fetch()).called(1);
      },
    );

    blocTest<<Feature>Bloc, <Feature>State>(
      'emits [Loading, Loaded(empty)] when data is empty',
      build: () {
        when(mockRepository.fetch()).thenAnswer((_) async => emptyData);
        return bloc;
      },
      act: (bloc) => bloc.add(<Feature>FetchedEvent()),
      expect: () => [
        Loading<Feature>State(),
        isA<<Feature>LoadedState>().having(
          (s) => s.data, 'data is empty', isEmpty,
        ),
      ],
    );

    blocTest<<Feature>Bloc, <Feature>State>(
      'emits [Loading, Error] on repository failure',
      build: () {
        when(mockRepository.fetch()).thenThrow(Exception('Network error'));
        return bloc;
      },
      act: (bloc) => bloc.add(<Feature>FetchedEvent()),
      expect: () => [
        Loading<Feature>State(),
        isA<<Feature>ErrorState>(),
      ],
    );
  });
}
```

## Repository Test Template
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:kmart/src/features/<feature>/data/repositories/<feature>_repository_impl.dart';
import 'package:kmart/src/features/<feature>/data/datasources/remote/<feature>_remote_data_source.dart';
import 'package:kmart/src/features/common/repositories/common_network_response_repository.dart';
import 'package:kmart/src/utilities/app_constants.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '<feature>_repository_test.mocks.dart';

@GenerateMocks([<Feature>RemoteDataSource, CommonNetworkResponseRepository])
void main() {
  late <Feature>RepositoryImpl repository;
  late Mock<Feature>RemoteDataSource mockDataSource;
  late MockCommonNetworkResponseRepository mockCommonRepo;

  setUp(() {
    mockDataSource = Mock<Feature>RemoteDataSource();
    mockCommonRepo = MockCommonNetworkResponseRepository();
    repository = <Feature>RepositoryImpl(mockDataSource, mockCommonRepo);
  });

  tearDown(() {
    reset(mockDataSource);
    reset(mockCommonRepo);
  });

  group('<Feature>Repository', () {
    test('returns Left(model) on success', () async {
      // Arrange
      when(mockDataSource.fetch()).thenAnswer(
        (_) async => HttpResponseData(statusCode: AppConstants.noError, body: validJson),
      );

      // Act
      final result = await repository.fetch();

      // Assert
      expect(result.isLeft, isTrue);
      verify(mockDataSource.fetch()).called(1);
    });

    test('returns Right(error) on failure', () async {
      // Arrange
      when(mockDataSource.fetch()).thenAnswer(
        (_) async => HttpResponseData(statusCode: 500, body: {}),
      );

      // Act
      final result = await repository.fetch();

      // Assert
      expect(result.isRight, isTrue);
    });

    test('returns null/empty on null response body', () async {
      // Arrange
      when(mockDataSource.fetch()).thenAnswer(
        (_) async => HttpResponseData(statusCode: AppConstants.noError, body: null),
      );

      // Act & Assert
      final result = await repository.fetch();
      expect(result, isNull);
    });
  });
}
```

## Widget Test Template
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kmart/src/features/<feature>/ui/widgets/<feature>_widget.dart';

void main() {
  group('<Feature>Widget', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        home: Scaffold(
          body: <Feature>Widget(),
        ),
      );
    }

    testWidgets('displays all required UI elements', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(<Feature>Widget), findsOneWidget);
    });

    testWidgets('displays correct text content', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('Expected Label'), findsOneWidget);
    });

    testWidgets('handles tap interaction', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      // verify navigation or state change
    });
  });
}
```
