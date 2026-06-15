# How To Use The Agent Dev Kit

A practical guide for developers and AI agents working on the Konnect Flutter app.

---

## Quick Start (30-Second Version)

1. Open any Copilot/agent session in this repo.
2. The [`.github/copilot-instructions.md`](../.github/copilot-instructions.md) file loads automatically and points the agent to this kit.
3. The agent reads the memory files, picks the right skill, and follows the task flow.

**That's it.** The kit is designed to work without manual intervention.

---

## For Developers: How To Get The Best Results

### Giving Tasks To The Agent

Use the **task brief** format for consistent, low-token results:

```
Goal: Add offline caching for wishlist items.
Scope In: lib/src/features/wishlist/
Scope Out: UI changes, analytics
Acceptance: Items persist across app restart; tests pass.
```

Or **paste a Jira story directly** — the agent will automatically:
1. Parse all acceptance criteria
2. Normalize vague ACs into testable statements
3. Implement AC-by-AC in dependency order
4. Produce an AC validation report proving every criterion is met

```
[Paste your Jira story here — any format works]
```

You can also just say: _"Use `agent-dev-kit/templates/task-brief.md` format"_ and the agent will structure its own brief.

For token-efficient startup, run these first:

1. `agent-dev-kit/templates/startup-warmup-checklist.md`
2. `agent-dev-kit/templates/feature-discovery-scope.md`

### Choosing A Mode

| Mode | When To Use | How To Activate |
|------|-------------|-----------------|
| `mode:diff-only` | You want just the code changes | Add to your prompt |
| `mode:risk-first` | You want risks highlighted before code | Add to your prompt |
| `mode:token-budget` | Long/complex task, save tokens | Add to your prompt |
| `mode:warmup-gate` | Enforce startup checks before coding | Add to your prompt |
| `mode:feature-discovery` | Enforce feature-first scope before broad search | Add to your prompt || `mode:ac-driven` | Jira story / AC-driven development | Add to your prompt or paste a story |
| `mode:figma-to-ui` | Implement from Figma screens / design mockups | Add to your prompt or paste design |
### Reading Agent Output

Every response follows the same 5-section format:

- **Plan** — what will be done (max 5 steps)
- **Changes** — files and lines changed
- **Validation** — commands run and results
- **Risks** — what could go wrong
- **Next** — follow-up actions if any

---

## For AI Agents: Execution Playbook

### On Session Start

1. Complete `agent-dev-kit/templates/startup-warmup-checklist.md` and emit `Warm-Up Check`.
2. Complete `agent-dev-kit/templates/feature-discovery-scope.md` and lock the initial feature path.
3. Read these files (in order):
  - `agent-dev-kit/memory/architecture.rules`
  - `agent-dev-kit/memory/global.md`
  - `agent-dev-kit/memory/repo-gotchas.md`
4. Identify the task type and select a skill from `agent-dev-kit/skills/SKILLS.md`.

### Picking The Right Agent

**VS Code Copilot Agents** — select in the agent picker or the agent auto-routes based on your prompt:

| Task | Agent |
|------|-------|
| New feature / BLoC / screen / repository | `feature-scaffold` |
| Bug / crash / unexpected behavior | `flutter-debugger` |
| Architecture review / PR review (read-only) | `arch-reviewer` |
| Write tests (unit/bloc/widget/golden) | `flutter-tester` |
| **Safe refactoring** (extract/rename/split) | **`refactor`** |
| **New API / datasource / DTO** | **`api-integrator`** |
| Full story / AC delivery | `engineer` (via `subagents/engineer.md`) |

**Subagents** — used within agent chains or directly via `agent-dev-kit/subagents/`:

| Task | Subagent | File |
|------|----------|------|
| **Jira story / AC intake** | **Story Analyst** | **`subagents/story-analyst.md`** |
| End-to-end requirement delivery | Engineer | `subagents/engineer.md` |
| Build a new feature | Flutter Implementer | `subagents/flutter-implementer.md` |
| Investigate a bug | Bug Hunter | `subagents/bug-hunter.md` |
| **Auto-generate tests** | **Test Generator** | **`subagents/test-generator.md`** |
| **Auto-generate docs** | **Doc Writer** | **`subagents/doc-writer.md`** |
| Review code quality | Code Reviewer | `subagents/code-reviewer.md` |
| Run tests/validation | Test Runner | `subagents/test-runner.md` |
| Compress long prompts | Token Keeper | `subagents/token-keeper.md` |

### Engineer Autopilot Usage

Use this when you want one agent to own requirement understanding, implementation, tests, and delivery.

1. Start from `templates/engineer-brief.md`.
2. Delegate to `subagents/engineer.md`.
3. The agent performs implementation, mandatory test generation, validation, and delivery report.

See `workflows/delegation-matrix.md` for the recommended execution sequence.

### Following The Task Flow

```
[Story Intake] → Scope → Plan → Implement (AC-by-AC) → Auto-Generate Tests → Validate → Auto-Generate Docs → AC Validation Report → Report
```

**Story intake is automatic when a Jira story is pasted.** Test generation and documentation are automatic and mandatory. After every implementation step, the `test-generator` creates tests, then `doc-writer` creates/updates feature docs before the final report.

---

## File Map

```
agent-dev-kit/
├── README.md                          # Kit overview
├── HOW-TO-USE.md                      # This file
├── memory/
│   ├── codebase-snapshot.md           # ★ LOAD FIRST — full feature/service/package map
│   ├── session-handoff.md             # ★ End-of-session state → restores context next session
│   ├── gorouter-routes.md             # ★ GoRouter route registry — load when adding/changing screens
│   ├── architecture.rules             # Non-negotiable code + lint rules (incl. dual-navigation)
│   ├── global.md                      # Working style + token discipline
│   ├── repo-gotchas.md                # Known pitfalls (incl. GoRouter navigation gotchas)
│   └── naming-conventions.md          # File/class/folder naming patterns
├── skills/
│   ├── SKILLS.md                      # Skill registry with subagent mapping
│   ├── context.md                     # Tech snapshot + commands
│   └── code-patterns.md               # Copy-paste patterns (BLoC/Either, GoRouter, BlocConsumer, test)
├── subagents/
│   ├── story-analyst.md               # Jira story / AC parsing and intake
│   ├── flutter-implementer.md         # Feature/fix implementation
│   ├── navigation.md                  # ★ GoRouter screen registration (route → path list → builder)
│   ├── engineer.md                    # End-to-end requirement to delivery
│   ├── bug-hunter.md                  # Root-cause analysis
│   ├── test-generator.md              # AUTO: generates tests after every change
│   ├── doc-writer.md                  # AUTO: generates feature docs
│   ├── code-reviewer.md               # Quality review
│   ├── test-runner.md                 # Targeted validation
│   └── token-keeper.md                # Prompt compression
├── workflows/
│   ├── task-flow.md                   # End-to-end execution steps (with session resume + handoff)
│   ├── story-to-delivery.md           # Full Jira story → validated code pipeline
│   └── delegation-matrix.md           # Which agent/subagent for which task (incl. navigation)
├── templates/
│   ├── startup-warmup-checklist.md    # Required startup gate before coding
│   ├── feature-discovery-scope.md     # Feature-first scoping before broad reads
│   ├── jira-story-intake.md           # Jira story / AC parsing template
│   ├── figma-design-intake.md         # Figma / design screen → widget mapping
│   ├── ac-traceability-matrix.md      # Per-AC implementation tracking
│   ├── ac-validation-report.md        # Final AC proof for PR
│   ├── task-brief.md                  # Structured task input
│   ├── engineer-brief.md              # Engineer autopilot brief
│   ├── agent-delivery-report.md       # Required fields for PR delivery report checks
│   ├── pr-summary.md                  # Pull request description
│   ├── bug-report-minimal.md          # Minimal reproducible bug report
│   ├── feature-scaffold.md            # New feature folder + boilerplate + GoRouter steps
│   └── pre-pr-checklist.md            # Verification before PR (incl. routing checks)
├── commands/
│   └── shortcuts.md                   # Copy-paste Flutter commands
└── prompts/
    ├── token-budget.prompt.md         # Low-token execution preset
    └── ac-driven.prompt.md            # AC-driven development preset

.github/
├── copilot-instructions.md            # ★ Auto-loaded — session memory protocol + agent routing
├── agents/
│   ├── feature-scaffold.agent.md      # New BLoC + repository + UI + DI
│   ├── flutter-debugger.agent.md      # Crashes + BLoC state issues
│   ├── arch-reviewer.agent.md         # Architecture review (read-only)
│   ├── flutter-tester.agent.md        # bloc_test / widget / golden tests
│   ├── refactor.agent.md              # ★ Safe refactoring without behavior change
│   └── api-integrator.agent.md        # ★ API → DTO → entity → repository → DI
├── instructions/
│   ├── bloc.instructions.md           # Auto: **/bloc/**/*.dart
│   ├── ui.instructions.md             # Auto: **/ui/**/*.dart
│   ├── repository.instructions.md     # Auto: **/data/repository/**, packages/data/**, packages/domain/**
│   ├── test.instructions.md           # Auto: test/**/*.dart
│   ├── locator.instructions.md        # ★ Auto: lib/locator.dart
│   └── services.instructions.md      # ★ Auto: lib/src/services/**, lib/src/packages/**
└── prompts/
    └── session-resume.prompt.md       # ★ /session-resume — restore previous session context
```

---

## Common Scenarios

### Scenario 1: Fix a Bug (Bug Hunter + Test Runner)

**Your prompt:**
```
Fix the null currency crash in wishlist add-to-cart analytics.
mode:diff-only
```

**Agent output:**
```
Plan:
- Known gotcha: Firebase ecommerce events need currency when value is set
- Fix: fallback to countryConfig.currency in wishlist analytics

Changes:
- lib/src/features/wishlist/wishlist_online/data/analytics/wishlist_online_analytics_service.dart L38:
    currency: item.currency ?? locator.get<AppConfig>().countryConfig.currency,

Validation:
- flutter analyze: pass
- flutter test test/src/features/wishlist/: pass (18 tests)

Risks:
- Low: NZ currency fallback untested in integration

Next:
- Add NZ-specific unit test for null currency path
```

---

### Scenario 2: Build a New Feature (Feature Scaffold + Implementer)

**Your prompt:**
```
Add a loyalty points display to the account screen.
Use agent-dev-kit/templates/feature-scaffold.md format.
```

**Agent output:**
```
Plan:
- Create loyalty_points feature using clean-arch scaffold
- Wire into account screen as a BlocProvider widget
- Register in locator.dart

Changes:
- lib/src/features/loyalty_points/
    domain/i_repositories/i_loyalty_points_repository.dart   (interface)
    domain/entities/loyalty_points_entity.dart                (@freezed)
    data/repositories/loyalty_points_repository_impl.dart     (impl)
    data/datasources/remote/loyalty_points_remote_data_source.dart
    data/models/loyalty_points_model.dart                     (@JsonSerializable)
    ui/bloc/loyalty_points_bloc.dart
    ui/bloc/loyalty_points_event.dart
    ui/bloc/loyalty_points_state.dart
    ui/widgets/loyalty_points_widget.dart
- lib/locator.dart L290:
    ..registerLazySingleton<ILoyaltyPointsRepository>(
      () => LoyaltyPointsRepositoryImpl(locator(), locator()),
    )
- lib/routers.dart: BlocProvider wrapping in account route
- test/src/features/loyalty_points/
    blocs/loyalty_points_bloc_test.dart
    data/repositories/loyalty_points_repository_test.dart

Validation:
- flutter pub run build_runner build --delete-conflicting-outputs: success
- flutter analyze: pass
- flutter test test/src/features/loyalty_points/: pass (6 tests)

Risks:
- Medium: API contract assumed; verify endpoint response shape

Next:
- Integration test with real API
- Add analytics tracking via LoyaltyPointsAnalyticsService
```

---

### Scenario 3: Review Code Changes (Code Reviewer)

**Your prompt:**
```
Review the changes in lib/src/features/search/ for risks.
mode:risk-first
```

**Agent output:**
```
Findings:

1. [HIGH] Crash risk — search_repository_impl.dart L31
   SearchResultModel.fromJson called without null check on result.body
   Fix: guard with `if (result.body != null)` before parsing

2. [MEDIUM] Async safety — search_bloc.dart L48
   context.read<SearchBloc>() used after await without mounted check
   Fix: add `if (!mounted) return;` before context access

3. [LOW] Missing test — search_pills_repository.dart
   No test for empty pills response
   Fix: add blocTest for empty SearchPillsEntity list

Tests To Add:
- test/src/features/search/data/repositories/search_repository_test.dart
  → null body response case
- test/src/features/search/ui/bloc/search_bloc_test.dart
  → widget unmounted during async fetch

Residual Risk:
- GraphQL error mapping not validated (existing gap, not introduced by changes)
```

---

### Scenario 4: Run Targeted Tests (Test Runner)

**Your prompt:**
```
Run tests for the orders feature and check coverage.
```

**Agent output:**
```
Commands Executed:
- flutter analyze: pass (0 issues)
- flutter test test/src/features/orders/: pass
- flutter test test/src/features/orders/ --coverage: generated

Result: PASS (14/14 tests)

Failing Tests: none

Coverage:
- orders_bloc.dart: 92%
- orders_repository_impl.dart: 85%
- orders_page.dart: 68% (UI — lower expected)

Recommended Next Command:
- flutter test test/src/features/orders/ui/ for widget-level gaps
```

---

### Scenario 5: End-To-End Requirement Delivery (Engineer)

**Your prompt:**
```
Goal: Add pull-to-refresh support on the orders list page.
Scope In: lib/src/features/orders/
Scope Out: analytics, checkout
Acceptance:
1. Pull-to-refresh triggers a new fetch.
2. Loading and error states remain correct.
3. Unit/BLoC/widget tests cover refresh behavior.
mode:engineer-autopilot
```

---

### Scenario 5b: Deliver A Jira Story (Story Analyst + Engineer)

**Your prompt:**
```
Implement this Jira story:

KONNECT-4521: Add "Save for Later" to bag items

As a customer, I want to save bag items for later so that I can purchase them another time.

Acceptance Criteria:
1. Each bag item shows a "Save for Later" action
2. Tapping "Save for Later" moves the item from bag to a saved-items list
3. Saved items persist across app restart
4. User can move a saved item back to the bag
5. Empty saved-items state shows an appropriate message
6. Analytics event fires when item is saved or restored
```

**Agent output:**
```
Story Intake — KONNECT-4521: Add "Save for Later" to bag items

Parsed ACs:
| # | Criterion | Test Type | Status |
|---|-----------|-----------|--------|
| AC-1 | Bag item widget renders "Save for Later" action button | widget | pending |
| AC-2 | Tapping "Save for Later" dispatches SaveForLaterEvent → removes from bag state, adds to saved list | unit + widget | pending |
| AC-3 | Saved items persist via local storage and are loaded on app start | unit | pending |
| AC-4 | "Move to Bag" action on saved item dispatches RestoreToBagEvent → removes from saved, adds to bag | unit + widget | pending |
| AC-5 | Empty saved-items list renders EmptySavedItemsWidget with message | widget | pending |
| AC-6 | SaveForLaterAnalyticsService fires save_for_later / restore_to_bag events | unit | pending |

Scope: lib/src/features/bag/ + new lib/src/features/saved_items/
Assumptions: saved items use local storage (not API), analytics uses existing event pattern

Plan:
1. Create saved_items feature scaffold (entity, repository, bloc)
2. Implement AC-3 (persistence) — data layer first
3. Implement AC-2 + AC-4 (save/restore logic) — BLoC layer
4. Implement AC-1 + AC-5 (UI) — widget layer
5. Implement AC-6 (analytics)

Implementing AC-by-AC...

AC-1 ✓ Bag item shows "Save for Later" button
  Implementation: bag_item_widget.dart
  Test: bag_item_widget_test.dart → "renders Save for Later action"
  Status: passed

AC-2 ✓ Save for Later moves item from bag to saved list
  Implementation: bag_bloc.dart, saved_items_bloc.dart
  Test: bag_bloc_test.dart → "AC-2: SaveForLaterEvent removes item"
  Status: passed

[...continues for each AC...]

AC Validation Report:
  ACs: 6/6 passed
  Analyzer: pass
  Tests: 14 passed, 0 failed
  All criteria satisfied: YES
```

**Agent output:**
```
Plan:
- Reuse existing OrdersBloc fetch event for refresh path
- Add UI refresh trigger in orders page/widget
- Add bloc/widget regression tests for refresh gesture

Changes:
- lib/src/features/orders/ui/pages/orders_page.dart
  Added RefreshIndicator and wired onRefresh to dispatch OrdersFetchedEvent.
- test/src/features/orders/ui/bloc/orders_bloc_test.dart
  Added refresh event sequence test for [Loading, Loaded] states.
- test/src/features/orders/ui/pages/orders_page_test.dart
  Added pull-to-refresh interaction test and loading view assertion.

Validation:
- flutter analyze: pass
- flutter test test/src/features/orders/: pass (18 tests)

Risks:
- Low: refresh and first-load share event path; monitor for duplicate fetch calls.

Next:
- Optional integration test with slow network profile to validate UX timing.
```

---

### Scenario 5c: Implement From Figma Design (Design → UI)

**Your prompt:**
```
Implement this screen from Figma:
[pastes screenshot or Figma link]

It's the "Saved Items" screen with:
- List of saved products with image, title, price
- "Move to Bag" button on each item
- Empty state with illustration and "Start Shopping" CTA
- Swipe to delete
mode:figma-to-ui
```

**Agent output:**
```
Figma Design Intake — Saved Items Screen

Screen Inventory:
| # | Screen / State | Description |
|---|---------------|-------------|
| S-1 | Saved Items — List | Product cards with image, title, price, "Move to Bag" |
| S-2 | Saved Items — Empty | Illustration + "Start Shopping" button |

Widget Tree:
SavedItemsPage
├── AppBar (title: "Saved Items", back action)
├── Body
│   ├── BlocBuilder<SavedItemsBloc, SavedItemsState>
│   │   ├── LoadingState → SavedItemsShimmer
│   │   ├── LoadedState → SavedItemsList
│   │   │   └── SavedItemCard (Dismissible)
│   │   │       ├── ProductImage
│   │   │       ├── ProductTitle + Price
│   │   │       └── "Move to Bag" TextButton
│   │   └── EmptyState → SavedItemsEmptyWidget
│   │       ├── EmptyIllustration
│   │       └── "Start Shopping" ElevatedButton

Design Tokens:
| Element | Figma Value | Maps To |
|---------|-------------|---------|
| Card background | #FFFFFF | AppColors.surface |
| Title | 16sp semi-bold | AppTextStyles.bodyBold |
| Price | 14sp regular | AppTextStyles.bodySmall |
| CTA button | #E31837 | AppColors.primary |

State → Screen Mapping:
| BLoC State | Screen | Key Elements |
|-----------|--------|-------------|
| LoadingSavedItemsState | Shimmer | 3 placeholder cards |
| SavedItemsLoadedState | S-1 | Product cards list |
| SavedItemsEmptyState | S-2 | Illustration + CTA |
| SavedItemsErrorState | Error | Message + retry |

Implementation Plan:
1. Create saved_items feature scaffold
2. Implement data layer (entity, model, repository)
3. Implement BLoC with states matching design
4. Build SavedItemCard widget per design specs
5. Build EmptyState widget, wire interactions

Widget Tests:
- saved_items_page_test.dart → "renders list when loaded"
- saved_items_page_test.dart → "renders empty state with CTA"
- saved_item_card_test.dart → "renders image, title, price, move button"
- saved_item_card_test.dart → "swipe dismisses item"

Validation:
- flutter analyze: pass
- flutter test test/src/features/saved_items/: pass (8 tests)
```

---

### Scenario 5: Save Tokens on a Long Refactor (Token Keeper)

**Your prompt:**
```
Refactor the onboarding flow to use go_router. mode:token-budget
```

**Agent output (Turn 1):**
```
Plan:
- Replace Navigator.push calls with GoRouter.go/push in 4 onboarding screens
- Add routes in lib/routers.dart
- Keep BLoC wiring unchanged

Changes:
- lib/routers.dart: added /onboarding, /onboarding/location, /onboarding/preferences
- lib/src/features/onboarding/ui/pages/onboarding_page.dart L22,L45: Navigator → context.go
- lib/src/features/onboarding/ui/pages/location_page.dart L18: Navigator → context.push

Validation:
- flutter analyze: pass

Risks:
- Deep link paths may conflict with existing /onboarding Branch link

Next:
- Migrate remaining 2 screens in next turn
```

**Agent output (Turn 2):**
```
Changes (delta only):
- lib/src/features/onboarding/ui/pages/preferences_page.dart L30: Navigator → context.go
- lib/src/features/onboarding/ui/pages/welcome_page.dart L12: Navigator → context.push
- Removed unused Navigator imports from all 4 files

Validation:
- flutter analyze: pass
- flutter test test/src/features/onboarding/: pass (9 tests)

Risks:
- None new

Next:
- Done. PR ready — use templates/pr-summary.md
```

---

### Scenario 6: Use the Task Brief Template

**Your prompt:**
```
Use agent-dev-kit/templates/task-brief.md to scope this:
I need to add a "share receipt" button to the digital receipt screen.
```

**Agent output:**
```
## Task Brief

Goal: Add share button to digital receipt screen that shares receipt as PDF.

Constraints:
- Keep changes minimal
- Do not touch flavors/secrets

Scope:
- In: lib/src/features/digital_receipt/
- Out: receipts feature, analytics, push notifications

Acceptance Criteria:
1. Share button visible on digital receipt page
2. Tapping share opens system share sheet with PDF
3. BLoC test covers share event → success/error states

Validation:
- flutter analyze
- flutter test test/src/features/digital_receipt/

Output Style:
- Diff summary only
- Max 8 bullets
```

---

### Scenario 7: Use the Bug Report Template

**Your prompt:**
```
Use agent-dev-kit/templates/bug-report-minimal.md — the store locator
crashes when GPS is off on Android.
```

**Agent output:**
```
## Bug Report

Summary: Store locator crashes on Android when GPS permission denied

Repro Steps:
1. Disable GPS on Android device
2. Open app → tap "Find a store"
3. App crashes with Unhandled Exception

Expected: Show error message prompting user to enable location

Actual: Unhandled PlatformException crashes the app

Logs / Stack Trace:
  PlatformException(PERMISSION_DENIED, ...) at
  store_repository_impl.dart:42

Affected Layer:
- [x] Repository / Data Source

Flavor / Environment:
- Flavor: kmart_au_dev
- Platform: Android

Regression Risk: High — affects all Android users with GPS off
```

---

### Scenario 8: Use the Pre-PR Checklist

**Your prompt:**
```
Run the pre-PR checklist for my changes in lib/src/features/bag/
```

**Agent output:**
```
## Pre-PR Checklist — bag feature

Code Quality:
- [x] flutter analyze: pass
- [x] No new ignore_for_file added
- [x] No *.g.dart hand-edited
- [x] Package imports used

Architecture:
- [x] Changes follow data/domain/ui structure
- [x] No DTOs in UI layer
- [x] No new locator registrations needed
- [n/a] No new repository added

BLoC:
- [x] States extend Equatable with correct props
- [x] No BuildContext across async gaps
- [!] bag_bloc.dart L67: side effect in widget — consider moving to BLoC

Testing:
- [x] bloc_test used for BagBloc
- [x] Error case covered (empty bag)
- [x] flutter test test/src/features/bag/: pass (22 tests)

Safety:
- [x] No secrets logged
- [x] No CI/flavor changes
- [x] Only bag/ files modified

Action Items:
1. Move side effect at bag_bloc.dart L67 into BLoC event handler
```

---

### Scenario 9: Use Code Patterns for Quick Implementation

**Your prompt:**
```
I need to add a new repository for coupon validation.
Show me the pattern from agent-dev-kit/skills/code-patterns.md
```

**Agent output:**
```
From code-patterns.md — Pattern #2 (JsonSerializable) + #4 (Locator) + #1 (Either):

// domain/i_repositories/i_coupon_repository.dart
abstract class ICouponRepository {
  Future<Either<CouponModel, ResponseErrorObject>> validateCoupon(String code);
}

// data/repositories/coupon_repository_impl.dart
class CouponRepository implements ICouponRepository {
  CouponRepository(this._dataSource, this._commonNetworkResponseRepository);
  final CouponRemoteDataSource _dataSource;
  final CommonNetworkResponseRepository _commonNetworkResponseRepository;

  @override
  Future<Either<CouponModel, ResponseErrorObject>> validateCoupon(
    String code,
  ) async {
    final result = await _dataSource.validate(code);
    if (result.statusCode == AppConstants.noError) {
      return Left(CouponModel.fromJson(result.body));
    }
    return Right(
      _commonNetworkResponseRepository.processHttpDataIntoResponseObject(result),
    );
  }
}

// lib/locator.dart — add to cascade:
..registerLazySingleton<ICouponRepository>(
  () => CouponRepository(locator(), locator()),
)
```

---

### Scenario 10: Use Naming Conventions for Consistency

**Your prompt:**
```
What should I name the files and classes for a "gift card" feature?
```

**Agent output (from memory/naming-conventions.md):**
```
Files:
- gift_card_bloc.dart
- gift_card_event.dart
- gift_card_state.dart
- gift_card_model.dart
- gift_card_entity.dart
- i_gift_card_repository.dart
- gift_card_repository_impl.dart
- gift_card_remote_data_source.dart
- gift_card_analytics_service.dart
- gift_card_page.dart
- gift_card_balance_widget.dart
- gift_card_bloc_test.dart

Classes:
- GiftCardBloc
- GiftCardEvent / GiftCardFetchedEvent / GiftCardRedeemedEvent
- GiftCardState / InitialGiftCardState / LoadingGiftCardState / GiftCardLoadedState
- GiftCardModel
- GiftCardEntity
- IGiftCardRepository
- GiftCardRepository
- GiftCardAnalyticsService

Folder:
- lib/src/features/gift_card/
    data/ domain/ ui/
- test/src/features/gift_card/
    blocs/ data/ ui/
```

---

### Scenario 11: Auto-Generated Tests (Runs Automatically)

This scenario happens **automatically** — you don't need to ask for it.
After every implementation, the agent generates tests before validating.

**What you see in the agent output (embedded in every task):**
```
Auto-Generated Tests:

Test Files Created:
- test/src/features/loyalty_points/blocs/loyalty_points_bloc_test.dart
- test/src/features/loyalty_points/data/repositories/loyalty_points_repository_test.dart
- test/src/features/loyalty_points/ui/widgets/loyalty_points_widget_test.dart

Test Cases (14 total):
  loyalty_points_bloc_test.dart:
    ✓ initial state is InitialLoyaltyPointsState
    ✓ emits [Loading, Loaded] on successful fetch
    ✓ emits [Loading, Loaded(empty)] when points list is empty
    ✓ emits [Loading, Error] on repository failure
    ✓ verify repository.fetchPoints() called once

  loyalty_points_repository_test.dart:
    ✓ returns Left(model) on success (statusCode == noError)
    ✓ returns Right(error) on 500 response
    ✓ returns null on null response body
    ✓ verify data source called with correct userId

  loyalty_points_widget_test.dart:
    ✓ displays LoyaltyPointsWidget
    ✓ shows correct points balance text
    ✓ shows loading shimmer during LoadingState
    ✓ shows error message during ErrorState
    ✓ tap "View history" navigates

Mock Classes: MockLoyaltyPointsRepository, MockLoyaltyPointsRemoteDataSource
Build Runner Required: yes (new @GenerateMocks)
Run Command: flutter test test/src/features/loyalty_points/
```

**If you want to generate tests on demand (for existing code without tests):**
```
You: Generate tests for lib/src/features/flybuys/repositories/flybuys_repository_impl.dart
```

**Agent output:**
```
Plan:
- Read flybuys_repository_impl.dart to identify methods and dependencies
- Create matching test file with success/failure/edge cases

Auto-Generated Tests:

Test Files Created:
- test/src/features/flybuys/data/repositories/flybuys_repository_test.dart

Test Cases (5 total):
  ✓ linkFlybuys returns Left(model) on success
  ✓ linkFlybuys returns Right(error) on 401
  ✓ unlinkFlybuys returns Left(model) on success
  ✓ unlinkFlybuys returns Right(error) on network failure
  ✓ getFlybuysStatus returns null on null response

Mock Classes: MockFlybuysRemoteDataSource, MockCommonNetworkResponseRepository
Build Runner Required: yes
Run Command: flutter test test/src/features/flybuys/

Validation:
- flutter pub run build_runner build --delete-conflicting-outputs: success
- flutter test test/src/features/flybuys/: pass (5 tests)

Risks:
- None: tests cover existing behavior only
```

---

### Scenario 12: Auto-Generated Documentation (Runs Automatically for New Features)

This happens **automatically** after new feature implementation. You can also trigger it on demand.

**What you see in the agent output (embedded in feature delivery):**
```
Auto-Generated Documentation:

Docs Created:
- lib/src/features/loyalty_points/docs/README.md

Sections Generated:
- Overview
- Architecture (ASCII diagram)
- Data Flow (mermaid diagram)
- Key Files table (7 files)
- State Management table (4 states)
- Dependencies
- Testing paths
- Known Limitations

Diagrams Included: 2 (ASCII architecture + mermaid data flow)
ENGINEERING_DOCUMENTATION.md Updated: no (no new top-level pattern)
```

**On demand — generate docs for an existing feature:**
```
You: Generate documentation for the store_locator feature.
```

**Agent output:**
```
Plan:
- Read store_locator source files to extract architecture, BLoC states, repo methods
- Generate feature README matching next_gen_home doc style

Docs Created:
- lib/src/features/store_locator/docs/README.md

Content:
  # Store Locator — Architecture Documentation

  ## Overview
  Enables customers to find nearby Kmart stores using geolocation
  and postcode search, displaying results on a map and as a list.

  ## Architecture
  ┌─────────────────────────────────────────┐
  │            PRESENTATION                 │
  │  StoreLocatorBloc │ Pages │ Widgets     │
  └─────────────────────────────────────────┘
                      │
  ┌─────────────────────────────────────────┐
  │              DOMAIN                     │
  │  StoreEntity │ IStoreRepository          │
  └─────────────────────────────────────────┘
                      │
  ┌─────────────────────────────────────────┐
  │               DATA                      │
  │  StoreModel │ DataSource │ RepoImpl     │
  └─────────────────────────────────────────┘

  ## Data Flow
  graph TD
    A[StoreLocatorPage] --> B[StoreLocatorBloc]
    B --> C[StoreRepository]
    C --> D[StoreRemoteDataSource]
    D --> E[HTTP API]

  ## Key Files
  | Layer | File | Purpose |
  |-------|------|---------|
  | Domain | store_repository.dart | Interface |
  | Data | store_repository_impl.dart | Implementation |
  | Presentation | store_locator_bloc.dart | State management |

  ## State Management
  | State | When | UI Effect |
  |-------|------|-----------|
  | InitialStoreState | BLoC created | Empty |
  | LoadingStoreState | Fetch started | Shimmer |
  | StoreLoadedState | Stores received | Map + list |
  | StoreErrorState | GPS denied / API fail | Error message |

Risks:
- None: documentation only, no code changes
```

**On demand — generate an Architecture Decision Record:**
```
You: Write an ADR for switching from Navigator to go_router in onboarding.
```

**Agent output:**
```
Docs Created:
- lib/src/features/onboarding/docs/ADR-001-go-router-migration.md

Content:
  # ADR-001: Migrate Onboarding from Navigator to GoRouter

  ## Status
  Accepted

  ## Context
  Onboarding used imperative Navigator.push calls, making deep linking
  and route management inconsistent with the rest of the app which uses
  go_router. Testing navigation required widget-level pump setups.

  ## Decision
  - Replace all Navigator.push/pop in onboarding with context.go/push.
  - Define onboarding routes in lib/routers.dart.
  - Keep BLoC wiring unchanged.

  ## Consequences
  - Positive: consistent routing, deep link support, easier testing
  - Negative: minor learning curve for devs familiar with old flow
  - Risks: deep link paths may conflict with Branch SDK links
```

---

## Token Saving Tips For Developers

1. **Be specific** — _"Fix null in `wishlist_online_bloc.dart` L42"_ saves tokens vs _"something is wrong with wishlist"_.
2. **Use modes** — `mode:diff-only` and `mode:token-budget` cut output by ~60%.
3. **Use templates** — structured input = structured (shorter) output.
4. **Scope narrowly** — tell the agent what's in/out of scope.
5. **Don't re-explain** — the kit's memory files persist across turns; no need to repeat repo context.

---

## Extending The Kit

### Adding A New Gotcha
Edit `memory/repo-gotchas.md` — add one bullet per pitfall.

### Adding A New Skill
Add an entry to `skills/SKILLS.md` with: name, use-case, subagent chain, input/output contract.

### Adding A New Subagent
Create a file in `subagents/` with: Purpose, Pre-Read, Rules, Input Contract, Output Contract.
Update `workflows/delegation-matrix.md` to include it.

### Adding A New Template
Create a file in `templates/` with placeholder sections. Reference it in `README.md`.

### Adding A New Code Pattern
Add a numbered section to `skills/code-patterns.md` with a title and copy-paste-ready snippet.
