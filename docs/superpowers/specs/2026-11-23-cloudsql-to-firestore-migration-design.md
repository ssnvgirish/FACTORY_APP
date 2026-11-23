# Migrate from Cloud SQL (Firebase Data Connect) to Firestore

Date: 2026-11-23

## Goal

Stop paying for Cloud SQL (`prabitha-operations-service`, database `fdcdb`,
`asia-south1`) by moving the app's data to Firestore on the Firebase Spark
(free) plan. All existing data (masters, users, historical reports) is
migrated. Login moves to Firebase Auth.

## Current state

- Flutter app talks directly to Firebase Data Connect, which is backed by
  Cloud SQL for PostgreSQL. Data Connect cannot target any other database.
- Schema: ~53 tables in `dataconnect/schema/schema.gql`; operations in
  `dataconnect/connector/*.gql` (~4,000 lines); ~350 generated Dart files in
  `lib/generated/dataconnect/`.
- Data access happens only in `lib/features/*/data/datasources/*_remote_datasource.dart`,
  plus `lib/core/utils/seed_data.dart`, `lib/core/utils/master_table_seeder.dart`,
  `lib/core/di/injection.dart` and `lib/main.dart`.
- Login is custom: phone + plain-text password compared against the `users`
  table; every operation is `@auth(level: PUBLIC)`. `DevFlags.bypassPasswordCheck`
  is `true`.
- SQL backup from 2026-09-28 exists in `tools/sql/backup/2026-09-28/`.

## Approach

Swap the data layer inside the datasources and cut over once. Entities,
repositories, blocs and UI are unchanged. Work happens on a branch; data is
migrated, tested, then the app is switched and Cloud SQL shut down.

Rejected: feature-by-feature with both backends live (data in two places,
needs sync, throwaway work); adding another abstraction layer (repositories
already are the boundary).

## Design

### 1. Collections

One Firestore collection per table (`users`, `master_machines`,
`frame_production_details_reports`, `sheet_cleaning_reports`, ...). Document
ID = existing UUID so cross-record IDs remain valid. Field names stay as in
the schema (camelCase). `Date`/`Timestamp` become Firestore `Timestamp`;
arrays (`roles`, `assignedMachines`) stay arrays. Parent/line-item pairs
(production, packing, customer rejection) remain separate collections
linked by ID so datasource logic keeps its shape.

### 2. Queries and free-plan limits

Spark limits: 50K reads/day, 20K writes/day, 1 GiB storage.

- Date-filtered list queries become `where('date', ...)` + `orderBy`; no full
  collection scans for reports.
- Dashboard continues to aggregate in Dart over date-scoped queries.
- Weight/target lookups (`section + density`, `thickness + density`) use master
  collections cached in memory per session.
- Enable Firestore offline persistence to reduce repeat reads.
- Composite indexes are declared in `firestore.indexes.json`.

### 3. Auth and security rules

- Each user becomes a Firebase Auth account: email `<normalized phone>@prabitha.app`
  with the user's existing password. Profile (roles, machines, salary,
  isActive) lives in `users/{uid}`.
- `AuthRemoteDataSource` signs in via `FirebaseAuth` instead of comparing
  passwords; inactive users are rejected after sign-in.
- `DevFlags.bypassPasswordCheck` is removed (Firebase Auth has no equivalent).
- Rules: signed-in users can read/write report collections; only admins can
  write masters and `users`; unauthenticated access denied.
- Admin user creation/edit uses a secondary `FirebaseApp` instance so the
  admin is not signed out when creating another account. Password changes for
  other users are out of scope unless the current admin screen already offers
  them (to be confirmed during planning).

### 4. Data migration

One-off Node script in `tools/migrate/` using `firebase-admin`:

1. Read from Cloud SQL (fresh export just before cutover; the 2026-09-28
   backup is only a fallback).
2. Write each table to its collection in batched writes, preserving IDs.
3. Create Auth accounts and `users` docs.
4. Print per-collection counts compared with source row counts; fail loudly on
   mismatch.

### 5. Cleanup after cutover

Remove `dataconnect/`, `lib/generated/dataconnect/`, the `firebase_data_connect`
dependency and the `dataconnect` key in `firebase.json`. Add `cloud_firestore`.
Take a final export, then delete the Cloud SQL instance.

### 6. Testing

- Existing bloc/widget tests keep running against mocked datasources.
- New datasource tests against the Firestore emulator (date-range queries,
  master lookups, user CRUD).
- Migration script verified by count comparison and spot checks of weight
  lookups and salary data.
- Manual smoke test of login and each report flow before cutover.

## Amendments (2026-11-23, during planning)

These refine the sections above after reading the datasource code.

1. **Line items are embedded, not separate collections.** Section 1 said
   parent/line-item pairs stay as separate collections. Instead, children are
   embedded as arrays in the parent document (`lineItems`, `entries`,
   `rejectedItems`). A report is then 1 read instead of 1 + N, which matters
   for the 50K reads/day quota. Migration merges child rows into parents.
2. **Stock totals are maintained, not recomputed.** The dashboard currently
   reads every production and packing report ever written. On Firestore that
   would burn the free quota. Instead `stock_totals/{frame|sheet}` and
   `stock_variants/*` hold running counters, updated with
   `FieldValue.increment` in the same write batch as each submit/delete of a
   production or packing report. The migration script rebuilds them from
   history.
3. **Dates are stored as `yyyy-MM-dd` strings** (not Timestamps), so range
   queries are timezone-proof and match the old `Date` semantics. Instants
   (`submittedAt`, `shiftEndTime`, entry start/end) are Timestamps.
4. **User documents are keyed by Firebase Auth UID** (`users/{authUid}`) and
   keep the legacy `uid` field (the phone), because reports reference
   operators by that legacy value. Auth email is `<digits of normalized phone>@prabitha.app`.
   Firebase Auth requires passwords of 6+ characters and existing passwords
   are 4 characters (`1234`), so the Auth password is `prb#` + the password the
   user types. Users still just type their normal password.
5. **Changing a user's phone is not supported** after migration (it would
   change the Auth login email, which needs the Admin SDK). The admin screen
   rejects it with a clear message; deactivate and re-create instead.
6. **Datasource tests use `fake_cloud_firestore`** instead of the emulator.
   Security rules are tested separately with the Firestore emulator.
7. **Renaming a master value** (section, density, thickness) is an in-place
   update plus a batch update of the weight/target rows that reference it,
   rather than the old insert → retarget → delete dance (which only existed
   to satisfy SQL foreign keys).

## Risks

- Biggest effort is rewriting ~10 datasources and the seeders.
- Spark read quota (50K/day) could be hit with many operators; mitigated by
  date-scoped queries and caching. Move to Blaze (pay-as-you-go, same free
  quota) is possible if ever needed.
- Firestore is not relational: no joins, so any report that joined tables in
  SQL must be done in Dart (current code already does this).
- Plain-text passwords in the old `users` table must be handled carefully
  during migration and not be copied into Firestore.

## Out of scope

Redesigning the data model, new features, UI changes, password-change flows
beyond what exists today.
