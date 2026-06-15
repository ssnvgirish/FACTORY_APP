import 'dart:async';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // Global test configuration for the factory app test suite.
  // No Firebase initialization needed — tests use mocks/fakes.
  await testMain();
}
