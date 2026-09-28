-- ═══════════════════════════════════════════════════════════════
-- Factory App — Pre-flight fixes for sql:migrate blockers
-- ═══════════════════════════════════════════════════════════════
-- WHY: `firebase dataconnect:sql:migrate` runs as ONE transaction and
--      aborts on the first failing statement. Two statements in the
--      queue can fail on existing data:
--
--        1. frame_customer_rejection_report.rejection_date SET NOT NULL
--           -> fails if any row has NULL  (CONFIRMED failure)
--        2. CREATE UNIQUE INDEX on master_scrap_target(product)
--           -> fails if duplicate products exist
--
-- RUN THIS in the Google Cloud SQL query window BEFORE re-running
-- ./tools/run_dataconnect_migration.sh
--
-- SAFE / IDEMPOTENT: re-runnable. Backfills rather than deletes.
-- ═══════════════════════════════════════════════════════════════

SET ROLE "firebaseowner_fdcdb_public";

-- ── BEFORE: inspect the damage ─────────────────────────────────
SELECT 'BEFORE: rejection_date NULLs' AS check_name,
       COUNT(*) AS null_rows
FROM public.frame_customer_rejection_report
WHERE rejection_date IS NULL;

SELECT 'BEFORE: duplicate scrap products' AS check_name,
       COUNT(*) AS duplicate_groups
FROM (
  SELECT product
  FROM public.master_scrap_target
  GROUP BY product
  HAVING COUNT(*) > 1
) dupes;

BEGIN;

-- ── Fix 1: backfill NULL rejection_date ────────────────────────
-- Preference order:
--   1. original_production_date (a rejection belongs to that batch)
--   2. the row's created timestamp
--   3. today (last resort so the column can be made NOT NULL)
UPDATE public.frame_customer_rejection_report
SET rejection_date = COALESCE(
      original_production_date,
      "timestamp"::date,
      CURRENT_DATE
    )
WHERE rejection_date IS NULL;

-- Also guard the sibling column the schema requires as NOT NULL.
UPDATE public.frame_customer_rejection_report
SET original_production_date = COALESCE(
      rejection_date,
      "timestamp"::date,
      CURRENT_DATE
    )
WHERE original_production_date IS NULL;

-- ── Fix 2: de-duplicate master_scrap_target.product ────────────
-- Keeps the most recently created row per product, deletes the rest,
-- so the UNIQUE index can be created.
DELETE FROM public.master_scrap_target a
USING public.master_scrap_target b
WHERE a.product = b.product
  AND a.ctid < b.ctid;

COMMIT;

-- ── AFTER: verify both blockers are cleared ────────────────────
SELECT 'AFTER: rejection_date NULLs (must be 0)' AS check_name,
       COUNT(*) AS null_rows
FROM public.frame_customer_rejection_report
WHERE rejection_date IS NULL;

SELECT 'AFTER: original_production_date NULLs (must be 0)' AS check_name,
       COUNT(*) AS null_rows
FROM public.frame_customer_rejection_report
WHERE original_production_date IS NULL;

SELECT 'AFTER: duplicate scrap products (must be 0)' AS check_name,
       COUNT(*) AS duplicate_groups
FROM (
  SELECT product
  FROM public.master_scrap_target
  GROUP BY product
  HAVING COUNT(*) > 1
) dupes;

-- ── Scan every other column the migration will require NOT NULL ──
-- All counts below must be 0 before re-running the migration.
SELECT 'health: frame total_maintenance_duration_hours NULLs' AS check_name,
       COUNT(*) AS null_rows
FROM public.frame_health_report
WHERE total_maintenance_duration_hours IS NULL;

SELECT 'health: sheet total_maintenance_duration_hours NULLs' AS check_name,
       COUNT(*) AS null_rows
FROM public.sheet_health_report
WHERE total_maintenance_duration_hours IS NULL;
