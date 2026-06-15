# Factory Manager — Flutter Mobile App

A production-grade Flutter application for a window frame and sheet manufacturing factory. Manages quality checks, production reports, and salary multiplier calculations across 5 machines and 6 distinct user roles.

## Architecture

- **Clean Architecture** with feature-based modules
- **BLoC** (flutter_bloc) for state management
- **Firebase** (Auth + Data Connect) backend
- **GoRouter** for declarative routing with role-based guards
- **GetIt** for dependency injection

## Project Structure

```
lib/
├── core/
│   ├── constants/app_constants.dart   # Machine names, roles, lookup tables
│   ├── theme/app_theme.dart           # Dark navy + amber Material 3 theme
│   ├── errors/failures.dart           # Typed failure classes
│   ├── utils/
│   │   ├── calculations.dart          # All business formula functions
│   │   └── validators.dart            # Form validation helpers
│   ├── widgets/common_widgets.dart    # Reusable UI components
│   ├── di/injection.dart              # GetIt DI setup
│   └── router/app_router.dart         # GoRouter config + bottom nav
├── features/
│   ├── auth/                          # Login, user entity, Firebase Auth
│   ├── frames/                        # 8 frame report types (all CRUD)
│   ├── sheets/                        # 8 sheet report types (all CRUD)
│   ├── salary/                        # Multiplier calculation & history
│   ├── admin/                         # User mgmt, reference tables, dropdowns
│   └── dashboard/                     # Summary cards, weekly charts
└── main.dart
```

## User Roles

| Role | Access |
|------|--------|
| Machine Operator | Submit reports for assigned machines |
| Quality & Packing Supervisor | Packing reports + quality checks |
| Frames Senior Operator | Approve frame health reports |
| Sheet Senior Operator | Approve sheet health reports |
| Plant Manager | View all, salary calculations |
| Admin | Full access + user management |

## Machines

- **Frames**: Machine 1, Machine 2
- **Sheets**: Machine 3, Machine 4, Machine 5

## Reports (per machine type)

1. Machine Cleaning (variable **a**)
2. Tools Count (variable **b**)
3. Machine Health / Maintenance (with approval workflow)
4. Production Details → auto-generates Weight/Running Feet report
5. Weight Report / Running Feet Report (variable **c** = efficiency)
6. Shift Packing (variables **d** = quality acceptance, **e** = packing efficiency)
7. Report Writing Efficiency (variable **f** — auto-scored)
8. Customer Rejection (2× deduction)

## Salary Formula

```
Multiplier = Σ(variable_i / 100 × weightage_i / 100) for i = a..f
Monthly Salary = Fixed Salary × Multiplier
```

## Setup

1. Create a Firebase project and enable **Authentication** (Email/Password)
2. Add `google-services.json` (Android) and/or `GoogleService-Info.plist` (iOS)
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Deploy the Data Connect schema and connector configuration.
5. Seed initial reference tables (frame weight lookup, salary weightages, etc.) through the app/admin flows or connector-backed scripts.
6. Create the first Admin user manually in Firebase Auth, then provision their profile through the backend data store.
7. Run:
   ```bash
   flutter run
   ```

## Backend Data

| Collection | Purpose |
|-----------|---------|
| `users` | User profiles with roles, machines, salary |
| `frameReports/{type}/items` | All frame report documents |
| `sheetReports/{type}/items` | All sheet report documents |
| `salaryCalculations/{operatorId}/months/{YYYY-MM}` | Saved salary calc records |
| `referenceTables` | Weight tables, targets, salary weightages |
| `dropdowns` | Configurable dropdown values |
# FACTORY_APP
