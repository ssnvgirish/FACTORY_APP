-- ═══════════════════════════════════════════════════════════════
-- Factory App — Safe health-report schema migration
-- ═══════════════════════════════════════════════════════════════
-- WHY: Live DB still has old rating columns (total_score / percentage)
--      and rating-item tables. The app now writes maintenance entries
--      and total_maintenance_duration_hours. Without this, Frame/Sheet
--      "New Machine Health Report" submit fails.
--
-- HOW TO RUN:
--   1. From project root:
--        firebase dataconnect:sql:shell --project prabitha-operations
--   2. Paste this entire file into the shell and press Enter
--   3. Then run:  ./tools/run_dataconnect_migration.sh
--
-- SAFE / IDEMPOTENT: safe to re-run. Does NOT drop old rating data —
-- it renames legacy tables so history is kept.
-- ═══════════════════════════════════════════════════════════════

SET ROLE "firebaseowner_fdcdb_public";

BEGIN;

-- ── Frame health report ────────────────────────────────────────
ALTER TABLE public.frame_health_report
  ALTER COLUMN total_score DROP NOT NULL;

ALTER TABLE public.frame_health_report
  ALTER COLUMN percentage DROP NOT NULL;

ALTER TABLE public.frame_health_report
  ADD COLUMN IF NOT EXISTS total_maintenance_duration_hours double precision;

UPDATE public.frame_health_report
SET total_maintenance_duration_hours = 0
WHERE total_maintenance_duration_hours IS NULL;

ALTER TABLE public.frame_health_report
  ALTER COLUMN total_maintenance_duration_hours SET DEFAULT 0,
  ALTER COLUMN total_maintenance_duration_hours SET NOT NULL;

-- ── Sheet health report ────────────────────────────────────────
ALTER TABLE public.sheet_health_report
  ALTER COLUMN total_score DROP NOT NULL;

ALTER TABLE public.sheet_health_report
  ALTER COLUMN percentage DROP NOT NULL;

ALTER TABLE public.sheet_health_report
  ADD COLUMN IF NOT EXISTS total_maintenance_duration_hours double precision;

UPDATE public.sheet_health_report
SET total_maintenance_duration_hours = 0
WHERE total_maintenance_duration_hours IS NULL;

ALTER TABLE public.sheet_health_report
  ALTER COLUMN total_maintenance_duration_hours SET DEFAULT 0,
  ALTER COLUMN total_maintenance_duration_hours SET NOT NULL;

-- ── Maintenance entry tables (new model) ───────────────────────
CREATE TABLE IF NOT EXISTS public.frame_maintenance_entry (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  report_id uuid NOT NULL,
  description text NOT NULL,
  duration_hours double precision NOT NULL,
  end_time timestamptz NOT NULL,
  maintenance_item text NOT NULL,
  person_doing_maintenance text NOT NULL,
  start_time timestamptz NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT frame_maintenance_entry_report_id_fkey
    FOREIGN KEY (report_id)
    REFERENCES public.frame_health_report (id)
    ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS "frame_maintenance_entry_reportId_idx"
  ON public.frame_maintenance_entry (report_id);

CREATE TABLE IF NOT EXISTS public.sheet_maintenance_entry (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  report_id uuid NOT NULL,
  description text NOT NULL,
  duration_hours double precision NOT NULL,
  end_time timestamptz NOT NULL,
  maintenance_item text NOT NULL,
  person_doing_maintenance text NOT NULL,
  start_time timestamptz NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT sheet_maintenance_entry_report_id_fkey
    FOREIGN KEY (report_id)
    REFERENCES public.sheet_health_report (id)
    ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS "sheet_maintenance_entry_reportId_idx"
  ON public.sheet_maintenance_entry (report_id);

-- ── Archive legacy rating tables (keep history; migrate may drop originals) ──
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'public' AND table_name = 'frame_health_rating_item'
  ) AND NOT EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'public' AND table_name = 'frame_health_rating_item_legacy'
  ) THEN
    EXECUTE 'ALTER TABLE public.frame_health_rating_item RENAME TO frame_health_rating_item_legacy';
  END IF;

  IF EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'public' AND table_name = 'sheet_health_rating_item'
  ) AND NOT EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'public' AND table_name = 'sheet_health_rating_item_legacy'
  ) THEN
    EXECUTE 'ALTER TABLE public.sheet_health_rating_item RENAME TO sheet_health_rating_item_legacy';
  END IF;
END $$;

COMMIT;

-- ── Verify ─────────────────────────────────────────────────────
SELECT 'frame_health_report columns' AS check_name,
       column_name, is_nullable, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'frame_health_report'
  AND column_name IN (
    'total_score', 'percentage', 'total_maintenance_duration_hours'
  )
ORDER BY column_name;

SELECT 'sheet_health_report columns' AS check_name,
       column_name, is_nullable, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'sheet_health_report'
  AND column_name IN (
    'total_score', 'percentage', 'total_maintenance_duration_hours'
  )
ORDER BY column_name;

SELECT 'frame_maintenance_entry exists' AS check_name,
       COUNT(*) AS table_count
FROM information_schema.tables
WHERE table_schema = 'public' AND table_name = 'frame_maintenance_entry';

SELECT 'sheet_maintenance_entry exists' AS check_name,
       COUNT(*) AS table_count
FROM information_schema.tables
WHERE table_schema = 'public' AND table_name = 'sheet_maintenance_entry';
