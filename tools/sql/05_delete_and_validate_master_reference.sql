-- ===============================================================
-- Factory App - Child-first delete + validation script
--
-- Usage:
-- 1) Set values in the input CTE (entity_type + entity_value)
-- 2) Run in Cloud SQL Query Editor (PostgreSQL / fdcdb)
--
-- entity_type allowed values:
--   frame_section | frame_density | sheet_thickness | sheet_density | scrap_product
--
-- Behavior:
-- 1) Shows child usage counts before delete
-- 2) Deletes child rows first
-- 3) Deletes selected master row
-- 4) Validates master row removed and no child rows remain for the value
-- ===============================================================

BEGIN;

SET ROLE "firebaseowner_fdcdb_public";

-- -------------------------
-- Input: change here
-- -------------------------
WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
SELECT entity_type, entity_value FROM input;

-- -------------------------
-- Pre-delete usage report
-- -------------------------
WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
SELECT
  i.entity_type,
  i.entity_value,
  CASE WHEN i.entity_type = 'frame_section'
    THEN (SELECT COUNT(*) FROM public.master_frame_weight fw WHERE fw.section = i.entity_value)
    ELSE NULL END AS frame_weight_refs,
  CASE WHEN i.entity_type = 'frame_section'
    THEN (SELECT COUNT(*) FROM public.master_frame_target ft WHERE ft.section = i.entity_value)
    ELSE NULL END AS frame_target_refs,
  CASE WHEN i.entity_type = 'frame_density'
    THEN (SELECT COUNT(*) FROM public.master_frame_weight fw WHERE fw.density = i.entity_value)
    ELSE NULL END AS frame_weight_density_refs,
  CASE WHEN i.entity_type = 'frame_density'
    THEN (SELECT COUNT(*) FROM public.master_frame_target ft WHERE ft.density = i.entity_value)
    ELSE NULL END AS frame_target_density_refs,
  CASE WHEN i.entity_type = 'sheet_thickness'
    THEN (SELECT COUNT(*) FROM public.master_sheet_weight sw WHERE sw.thickness = i.entity_value)
    ELSE NULL END AS sheet_weight_thickness_refs,
  CASE WHEN i.entity_type = 'sheet_thickness'
    THEN (SELECT COUNT(*) FROM public.master_sheet_target st WHERE st.thickness = i.entity_value)
    ELSE NULL END AS sheet_target_thickness_refs,
  CASE WHEN i.entity_type = 'sheet_density'
    THEN (SELECT COUNT(*) FROM public.master_sheet_weight sw WHERE sw.density = i.entity_value)
    ELSE NULL END AS sheet_weight_density_refs,
  CASE WHEN i.entity_type = 'sheet_density'
    THEN (SELECT COUNT(*) FROM public.master_sheet_target st WHERE st.density = i.entity_value)
    ELSE NULL END AS sheet_target_density_refs,
  CASE WHEN i.entity_type = 'scrap_product'
    THEN (SELECT COUNT(*) FROM public.master_scrap_target st WHERE st.product = i.entity_value)
    ELSE NULL END AS scrap_target_refs
FROM input i;

-- -------------------------
-- Step 1: child-first delete
-- -------------------------
WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_frame_weight fw
USING input i
WHERE i.entity_type = 'frame_section'
  AND fw.section = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_frame_target ft
USING input i
WHERE i.entity_type = 'frame_section'
  AND ft.section = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_frame_weight fw
USING input i
WHERE i.entity_type = 'frame_density'
  AND fw.density = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_frame_target ft
USING input i
WHERE i.entity_type = 'frame_density'
  AND ft.density = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_sheet_weight sw
USING input i
WHERE i.entity_type = 'sheet_thickness'
  AND sw.thickness = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_sheet_target st
USING input i
WHERE i.entity_type = 'sheet_thickness'
  AND st.thickness = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_sheet_weight sw
USING input i
WHERE i.entity_type = 'sheet_density'
  AND sw.density = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_sheet_target st
USING input i
WHERE i.entity_type = 'sheet_density'
  AND st.density = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_scrap_target st
USING input i
WHERE i.entity_type = 'scrap_product'
  AND st.product = i.entity_value;

-- -------------------------
-- Step 2: delete master row
-- -------------------------
WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_frame_section s
USING input i
WHERE i.entity_type = 'frame_section'
  AND s.name = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_frame_density d
USING input i
WHERE i.entity_type = 'frame_density'
  AND d.value = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_sheet_thickness t
USING input i
WHERE i.entity_type = 'sheet_thickness'
  AND t.value = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_sheet_density d
USING input i
WHERE i.entity_type = 'sheet_density'
  AND d.value = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_scrap_product p
USING input i
WHERE i.entity_type = 'scrap_product'
  AND p.name = i.entity_value;

-- -------------------------
-- Step 3: validation report
-- -------------------------
WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
SELECT
  i.entity_type,
  i.entity_value,
  CASE WHEN i.entity_type = 'frame_section'
    THEN (SELECT COUNT(*) FROM public.master_frame_section s WHERE s.name = i.entity_value)
    WHEN i.entity_type = 'frame_density'
      THEN (SELECT COUNT(*) FROM public.master_frame_density d WHERE d.value = i.entity_value)
    WHEN i.entity_type = 'sheet_thickness'
      THEN (SELECT COUNT(*) FROM public.master_sheet_thickness t WHERE t.value = i.entity_value)
    WHEN i.entity_type = 'sheet_density'
      THEN (SELECT COUNT(*) FROM public.master_sheet_density d WHERE d.value = i.entity_value)
    WHEN i.entity_type = 'scrap_product'
      THEN (SELECT COUNT(*) FROM public.master_scrap_product p WHERE p.name = i.entity_value)
    ELSE NULL
  END AS master_rows_remaining,
  CASE WHEN i.entity_type = 'frame_section'
    THEN (SELECT COUNT(*) FROM public.master_frame_weight fw WHERE fw.section = i.entity_value)
    WHEN i.entity_type = 'frame_density'
      THEN (SELECT COUNT(*) FROM public.master_frame_weight fw WHERE fw.density = i.entity_value)
    WHEN i.entity_type = 'sheet_thickness'
      THEN (SELECT COUNT(*) FROM public.master_sheet_weight sw WHERE sw.thickness = i.entity_value)
    WHEN i.entity_type = 'sheet_density'
      THEN (SELECT COUNT(*) FROM public.master_sheet_weight sw WHERE sw.density = i.entity_value)
    WHEN i.entity_type = 'scrap_product'
      THEN (SELECT COUNT(*) FROM public.master_scrap_target st WHERE st.product = i.entity_value)
    ELSE NULL
  END AS child_refs_primary_remaining,
  CASE WHEN i.entity_type = 'frame_section'
    THEN (SELECT COUNT(*) FROM public.master_frame_target ft WHERE ft.section = i.entity_value)
    WHEN i.entity_type = 'frame_density'
      THEN (SELECT COUNT(*) FROM public.master_frame_target ft WHERE ft.density = i.entity_value)
    WHEN i.entity_type = 'sheet_thickness'
      THEN (SELECT COUNT(*) FROM public.master_sheet_target st WHERE st.thickness = i.entity_value)
    WHEN i.entity_type = 'sheet_density'
      THEN (SELECT COUNT(*) FROM public.master_sheet_target st WHERE st.density = i.entity_value)
    ELSE 0
  END AS child_refs_secondary_remaining
FROM input i;

COMMIT;

SELECT 'Delete and validation script completed' AS status;
