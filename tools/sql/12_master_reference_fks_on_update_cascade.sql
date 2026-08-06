-- ═══════════════════════════════════════════════════════════════
-- Factory App — Allow renaming master values referenced by lookups
--
-- Run in Cloud SQL Query Editor (PostgreSQL) against database: fdcdb.
-- Safe to re-run.
--
-- Why:
-- The weight/target lookup tables reference master values by their natural
-- key (name/value), not by id. The constraints added in 03/04 only declared
-- ON DELETE RESTRICT, so ON UPDATE defaulted to NO ACTION. Any admin edit of
-- a Frame Section, Frame Density, Sheet Thickness, Sheet Density or Scrap
-- Product that already appeared in a weight or target row was rejected with
-- "update or delete on table ... violates foreign key constraint".
--
-- This script switches every constraint to ON UPDATE CASCADE, so renaming a
-- master value rewrites the referencing lookup rows in the same transaction.
-- ON DELETE RESTRICT is kept: deleting a value that is still in use must stay
-- a deliberate, child-first operation (see 05/06).
-- ═══════════════════════════════════════════════════════════════

BEGIN;

SET ROLE "firebaseowner_fdcdb_public";

ALTER TABLE public.master_frame_weight
  DROP CONSTRAINT IF EXISTS fk_frame_weight_section,
  ADD CONSTRAINT fk_frame_weight_section
    FOREIGN KEY (section)
    REFERENCES public.master_frame_section(name)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_weight
  DROP CONSTRAINT IF EXISTS fk_frame_weight_density,
  ADD CONSTRAINT fk_frame_weight_density
    FOREIGN KEY (density)
    REFERENCES public.master_frame_density(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_weight
  DROP CONSTRAINT IF EXISTS fk_sheet_weight_thickness,
  ADD CONSTRAINT fk_sheet_weight_thickness
    FOREIGN KEY (thickness)
    REFERENCES public.master_sheet_thickness(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_weight
  DROP CONSTRAINT IF EXISTS fk_sheet_weight_density,
  ADD CONSTRAINT fk_sheet_weight_density
    FOREIGN KEY (density)
    REFERENCES public.master_sheet_density(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_target
  DROP CONSTRAINT IF EXISTS fk_frame_target_section,
  ADD CONSTRAINT fk_frame_target_section
    FOREIGN KEY (section)
    REFERENCES public.master_frame_section(name)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_target
  DROP CONSTRAINT IF EXISTS fk_frame_target_density,
  ADD CONSTRAINT fk_frame_target_density
    FOREIGN KEY (density)
    REFERENCES public.master_frame_density(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_target
  DROP CONSTRAINT IF EXISTS fk_sheet_target_thickness,
  ADD CONSTRAINT fk_sheet_target_thickness
    FOREIGN KEY (thickness)
    REFERENCES public.master_sheet_thickness(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_target
  DROP CONSTRAINT IF EXISTS fk_sheet_target_density,
  ADD CONSTRAINT fk_sheet_target_density
    FOREIGN KEY (density)
    REFERENCES public.master_sheet_density(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_scrap_target
  DROP CONSTRAINT IF EXISTS fk_scrap_target_product,
  ADD CONSTRAINT fk_scrap_target_product
    FOREIGN KEY (product)
    REFERENCES public.master_scrap_product(name)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

COMMIT;

-- ---------------------------------------------------------------
-- Verification: every row below must read ON UPDATE CASCADE ON DELETE RESTRICT
-- ---------------------------------------------------------------
SELECT
  conname,
  conrelid::regclass AS table_name,
  pg_get_constraintdef(c.oid) AS constraint_definition
FROM pg_constraint c
WHERE conname IN (
  'fk_frame_weight_section',
  'fk_frame_weight_density',
  'fk_sheet_weight_thickness',
  'fk_sheet_weight_density',
  'fk_frame_target_section',
  'fk_frame_target_density',
  'fk_sheet_target_thickness',
  'fk_sheet_target_density',
  'fk_scrap_target_product'
)
ORDER BY conname;
