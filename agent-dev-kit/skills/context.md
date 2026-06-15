# Konnect Context For Skills

## Tech Snapshot
- Flutter `>=3.41.0`, Dart `>=3.8.0`.
- State management: `bloc` + `flutter_bloc`.
- DI: `get_it` via `lib/locator.dart`.
- Common tooling: `build_runner`, `freezed`, `json_serializable`, `bloc_test`, `mocktail`.

## High-Value Commands
- Install deps: `flutter pub get`
- Analyze: `flutter analyze`
- Run tests: `flutter test`
- Coverage: `flutter test --coverage`
- Codegen: `flutter pub run build_runner build --delete-conflicting-outputs`

## Repository Nuance
- App has AU/NZ flavors and env-specific config files.
- Prefer scoped changes in `lib/src/features/<feature>`.
- Maintain `locator` registrations when introducing new repositories/services.

## Token-Efficient Working Agreement
- Reference files by path and line, not full content.
- Return diffs and command results summarized in <= 8 bullets.
- Escalate to full suite/testing only when risk is high.
