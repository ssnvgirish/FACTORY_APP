# Data Connect migration — copy/paste guide

Fixes **Frames / Sheets Machine Health Report submit** (live DB still on old rating schema).

## Prerequisites

- Firebase CLI logged in: `firebase login`
- Access to project `prabitha-operations`
- Run commands from the **repo root** (`factory_app/`)

## Step 1 — Safe SQL prep (required)

```bash
firebase dataconnect:sql:shell --project prabitha-operations --service prabitha-operations-service --location asia-south1
```

Paste the full contents of:

`tools/sql/07_safe_health_report_migration.sql`

Press Enter. You should see verification SELECTs confirming:

- `total_maintenance_duration_hours` exists
- `frame_maintenance_entry` / `sheet_maintenance_entry` exist

Type `\q` to quit the shell.

## Step 1b — Clear migration blockers (required)

`sql:migrate` runs as a single transaction and aborts on the first failing
statement. Two statements can fail on existing data:

- `frame_customer_rejection_report.rejection_date SET NOT NULL` — fails on NULL rows
- `CREATE UNIQUE INDEX` on `master_scrap_target(product)` — fails on duplicates

Paste the full contents of:

`tools/sql/08_preflight_fix_migration_blockers.sql`

Every `AFTER:` count it prints must be **0** before continuing.

## Step 2 — Migrate + deploy

```bash
chmod +x tools/run_dataconnect_migration.sh
./tools/run_dataconnect_migration.sh
```

Answer `y` when prompted.

## Step 3 — Re-apply master FKs (required)

Migration drops the master-reference FK constraints. Re-apply them:

```bash
firebase dataconnect:sql:shell --project prabitha-operations --service prabitha-operations-service --location asia-south1
```

Paste:

`tools/sql/03_enforce_master_reference_fks.sql`

Quit with `\q`.

## Step 4 — App

```bash
flutter run
```

Retest:

1. Frames → New Machine Health Report → Submit  
2. Sheets → New Machine Health Report → Submit  
3. Scrap Regrind → New Machine Health Report → Submit  
4. Admin → Reference Tables (weights + targets)

## Files

| File | Purpose |
|------|---------|
| `tools/sql/07_safe_health_report_migration.sql` | Adds maintenance columns/tables safely; archives old rating tables |
| `tools/sql/08_preflight_fix_migration_blockers.sql` | Backfills NULL rejection dates, de-dupes scrap targets |
| `tools/run_dataconnect_migration.sh` | `sql:migrate` + `deploy --only dataconnect` |
| `tools/sql/03_enforce_master_reference_fks.sql` | Re-applies weight/target FK constraints after migrate |

## Notes

- Old rating rows are backfilled with `total_maintenance_duration_hours = 0`.
- Legacy rating-item tables are renamed to `*_legacy` before migrate can drop the originals.
- Migrate may also drop unused tables like `dropdown_config` / `reference_table` if they still exist.
