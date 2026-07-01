-- ===============================================================
-- Factory App - Single-input child-first delete + validation
--
-- Run in Cloud SQL Query Editor (PostgreSQL / fdcdb)
-- Change input only once in the INSERT line below.
--
-- Allowed entity_type values:
--   frame_section | frame_density | sheet_thickness | sheet_density | scrap_product
-- ===============================================================

BEGIN;

SET ROLE "firebaseowner_fdcdb_public";

CREATE TEMP TABLE _input (
  entity_type TEXT NOT NULL,
  entity_value TEXT NOT NULL
) ON COMMIT DROP;

-- Change only this one line:
INSERT INTO _input (entity_type, entity_value)
VALUES ('frame_section', '3x2');

DO $$
DECLARE
  t TEXT;
BEGIN
  SELECT entity_type INTO t FROM _input LIMIT 1;
  IF t NOT IN ('frame_section', 'frame_density', 'sheet_thickness', 'sheet_density', 'scrap_product') THEN
    RAISE EXCEPTION 'Invalid entity_type: %. Allowed: frame_section, frame_density, sheet_thickness, sheet_density, scrap_product', t;
  END IF;
END
$$;

-- ---------------------------------------------------------------
-- Pre-delete usage report
-- ---------------------------------------------------------------
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
FROM _input i;

-- ---------------------------------------------------------------
-- Step 1: Delete child rows first
-- ---------------------------------------------------------------
DELETE FROM public.master_frame_weight fw
USING _input i
WHERE i.entity_type = 'frame_section'
  AND fw.section = i.entity_value;

DELETE FROM public.master_frame_target ft
USING _input i
WHERE i.entity_type = 'frame_section'
  AND ft.section = i.entity_value;

DELETE FROM public.master_frame_weight fw
USING _input i
WHERE i.entity_type = 'frame_density'
  AND fw.density = i.entity_value;

DELETE FROM public.master_frame_target ft
USING _input i
WHERE i.entity_type = 'frame_density'
  AND ft.density = i.entity_value;

DELETE FROM public.master_sheet_weight sw
USING _input i
WHERE i.entity_type = 'sheet_thickness'
  AND sw.thickness = i.entity_value;

DELETE FROM public.master_sheet_target st
USING _input i
WHERE i.entity_type = 'sheet_thickness'
  AND st.thickness = i.entity_value;

DELETE FROM public.master_sheet_weight sw
USING _input i
WHERE i.entity_type = 'sheet_density'
  AND sw.density = i.entity_value;

DELETE FROM public.master_sheet_target st
USING _input i
WHERE i.entity_type = 'sheet_density'
  AND st.density = i.entity_value;

DELETE FROM public.master_scrap_target st
USING _input i
WHERE i.entity_type = 'scrap_product'
  AND st.product = i.entity_value;

-- ---------------------------------------------------------------
-- Step 2: Delete master row
-- ---------------------------------------------------------------
DELETE FROM public.master_frame_section s
USING _input i
WHERE i.entity_type = 'frame_section'
  AND s.name = i.entity_value;

DELETE FROM public.master_frame_density d
USING _input i
WHERE i.entity_type = 'frame_density'
  AND d.value = i.entity_value;

DELETE FROM public.master_sheet_thickness t
USING _input i
WHERE i.entity_type = 'sheet_thickness'
  AND t.value = i.entity_value;

DELETE FROM public.master_sheet_density d
USING _input i
WHERE i.entity_type = 'sheet_density'
  AND d.value = i.entity_value;

DELETE FROM public.master_scrap_product p
USING _input i
WHERE i.entity_type = 'scrap_product'
  AND p.name = i.entity_value;

-- ---------------------------------------------------------------
-- Step 3: Validation
-- ---------------------------------------------------------------
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
FROM _input i;

COMMIT;

SELECT 'Delete and validation completed' AS status;
