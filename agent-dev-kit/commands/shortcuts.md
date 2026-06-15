# Command Shortcuts

## Setup
- `flutter pub get`
- `flutter pub run build_runner build --delete-conflicting-outputs`

## Validate
- `flutter analyze`
- `flutter test`
- `flutter test --coverage`

## Codegen Watch (Dev)
- `flutter pub run build_runner watch --delete-conflicting-outputs`

## Flavor Run Examples
- `flutter run --flavor kmart_au_dev --dart-define=FLAVOR=kmartAuDev --dart-define=SENTRY_DSN=<dsn>`
- `flutter run --flavor kmart_nz_dev --dart-define=FLAVOR=kmartNzDev`

## Targeted Test (Single Feature)
- `flutter test test/src/<feature>/`

## Agent Prompt Macros
- `mode:diff-only` — output changed paths + line-level diffs only
- `mode:risk-first` — lead with top-3 risks, then changes
- `mode:token-budget` — activate `prompts/token-budget.prompt.md`
- `mode:engineer-autopilot` — use `templates/engineer-brief.md` + `subagents/engineer.md` for end-to-end requirement delivery
- `mode:warmup-gate` — enforce `templates/startup-warmup-checklist.md` before planning or coding
- `mode:feature-discovery` — enforce `templates/feature-discovery-scope.md` before broad context loading