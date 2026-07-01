-- ===============================================================
-- Factory App - Step-by-step Master/Reference FK enforcement
--
-- Run this in Cloud SQL Query Editor (PostgreSQL) against database: fdcdb
-- Behavior:
-- 1) Validates orphan rows (child values missing in parent master tables)
-- 2) Stops with a clear error if any orphan rows exist
-- 3) Applies all FK constraints with ON DELETE RESTRICT
-- 4) Returns a verification result set
-- ===============================================================

BEGIN;

SET ROLE "firebaseowner_fdcdb_public";

-- ---------------------------------------------------------------
-- Step 1: Validate orphan rows
-- ---------------------------------------------------------------
DO $$
DECLARE
  v_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM public.master_frame_weight fw
  LEFT JOIN public.master_frame_section s ON s.name = fw.section
  WHERE s.name IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_frame_weight.section -> master_frame_section.name (% rows)', v_count;
  END IF;

  SELECT COUNT(*) INTO v_count
  FROM public.master_frame_weight fw
  LEFT JOIN public.master_frame_density d ON d.value = fw.density
  WHERE d.value IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_frame_weight.density -> master_frame_density.value (% rows)', v_count;
  END IF;

  SELECT COUNT(*) INTO v_count
  FROM public.master_sheet_weight sw
  LEFT JOIN public.master_sheet_thickness t ON t.value = sw.thickness
  WHERE t.value IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_sheet_weight.thickness -> master_sheet_thickness.value (% rows)', v_count;
  END IF;

  SELECT COUNT(*) INTO v_count
  FROM public.master_sheet_weight sw
  LEFT JOIN public.master_sheet_density d ON d.value = sw.density
  WHERE d.value IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_sheet_weight.density -> master_sheet_density.value (% rows)', v_count;
  END IF;

  SELECT COUNT(*) INTO v_count
  FROM public.master_frame_target ft
  LEFT JOIN public.master_frame_section s ON s.name = ft.section
  WHERE s.name IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_frame_target.section -> master_frame_section.name (% rows)', v_count;
  END IF;

  SELECT COUNT(*) INTO v_count
  FROM public.master_frame_target ft
  LEFT JOIN public.master_frame_density d ON d.value = ft.density
  WHERE d.value IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_frame_target.density -> master_frame_density.value (% rows)', v_count;
  END IF;

  SELECT COUNT(*) INTO v_count
  FROM public.master_sheet_target st
  LEFT JOIN public.master_sheet_thickness t ON t.value = st.thickness
  WHERE t.value IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_sheet_target.thickness -> master_sheet_thickness.value (% rows)', v_count;
  END IF;

  SELECT COUNT(*) INTO v_count
  FROM public.master_sheet_target st
  LEFT JOIN public.master_sheet_density d ON d.value = st.density
  WHERE d.value IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_sheet_target.density -> master_sheet_density.value (% rows)', v_count;
  END IF;

  SELECT COUNT(*) INTO v_count
  FROM public.master_scrap_target st
  LEFT JOIN public.master_scrap_product p ON p.name = st.product
  WHERE p.name IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_scrap_target.product -> master_scrap_product.name (% rows)', v_count;
  END IF;

  RAISE NOTICE 'Step 1 complete: no orphan rows found';
END
$$;

-- ---------------------------------------------------------------
-- Step 2: Apply FK constraints (manual delete flow via RESTRICT)
-- ---------------------------------------------------------------
ALTER TABLE public.master_frame_weight
  DROP CONSTRAINT IF EXISTS fk_frame_weight_section,
  ADD CONSTRAINT fk_frame_weight_section
    FOREIGN KEY (section)
    REFERENCES public.master_frame_section(name)
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_weight
  DROP CONSTRAINT IF EXISTS fk_frame_weight_density,
  ADD CONSTRAINT fk_frame_weight_density
    FOREIGN KEY (density)
    REFERENCES public.master_frame_density(value)
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_weight
  DROP CONSTRAINT IF EXISTS fk_sheet_weight_thickness,
  ADD CONSTRAINT fk_sheet_weight_thickness
    FOREIGN KEY (thickness)
    REFERENCES public.master_sheet_thickness(value)
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_weight
  DROP CONSTRAINT IF EXISTS fk_sheet_weight_density,
  ADD CONSTRAINT fk_sheet_weight_density
    FOREIGN KEY (density)
    REFERENCES public.master_sheet_density(value)
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_target
  DROP CONSTRAINT IF EXISTS fk_frame_target_section,
  ADD CONSTRAINT fk_frame_target_section
    FOREIGN KEY (section)
    REFERENCES public.master_frame_section(name)
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_target
  DROP CONSTRAINT IF EXISTS fk_frame_target_density,
  ADD CONSTRAINT fk_frame_target_density
    FOREIGN KEY (density)
    REFERENCES public.master_frame_density(value)
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_target
  DROP CONSTRAINT IF EXISTS fk_sheet_target_thickness,
  ADD CONSTRAINT fk_sheet_target_thickness
    FOREIGN KEY (thickness)
    REFERENCES public.master_sheet_thickness(value)
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_target
  DROP CONSTRAINT IF EXISTS fk_sheet_target_density,
  ADD CONSTRAINT fk_sheet_target_density
    FOREIGN KEY (density)
    REFERENCES public.master_sheet_density(value)
    ON DELETE RESTRICT;

ALTER TABLE public.master_scrap_target
  DROP CONSTRAINT IF EXISTS fk_scrap_target_product,
  ADD CONSTRAINT fk_scrap_target_product
    FOREIGN KEY (product)
    REFERENCES public.master_scrap_product(name)
    ON DELETE RESTRICT;

SELECT 'Step 2 complete: FK constraints applied' AS status;

COMMIT;

-- ---------------------------------------------------------------
-- Step 3: Verification output
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
