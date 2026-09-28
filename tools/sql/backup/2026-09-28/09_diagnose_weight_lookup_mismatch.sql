-- ═══════════════════════════════════════════════════════════════
-- Factory App — Diagnose "Per Piece Weight = 0.000" lookups
-- ═══════════════════════════════════════════════════════════════
-- The app looks up weight with an EXACT STRING match:
--     weightTable[section][density]
-- So '0.8' and '0.80' are different keys. If the density dropdown
-- offers a value that no weight row uses, weight resolves to 0.
--
-- READ-ONLY. Safe to run any time.
-- Run in the Google Cloud SQL query window.
-- ═══════════════════════════════════════════════════════════════

-- 1. Density values offered by the dropdown
SELECT 'A. dropdown densities (master_frame_density)' AS report,
       value AS density,
       is_active,
       sort_order
FROM public.master_frame_density
ORDER BY sort_order, value;

-- 2. Density values actually present in the weight table
SELECT 'B. densities used by weight rows' AS report,
       density,
       COUNT(*) AS weight_rows
FROM public.master_frame_weight
GROUP BY density
ORDER BY density;

-- 3. THE BUG: dropdown densities that have NO weight rows at all
--    Anything listed here produces Per Piece Weight = 0.
--    'Others' is excluded: it is the manual-entry sentinel and is
--    expected to have no weight rows.
SELECT 'C. BROKEN dropdown densities (no weight rows)' AS report,
       d.value AS density
FROM public.master_frame_density d
WHERE d.is_active
  AND d.value <> 'Others'
  AND NOT EXISTS (
    SELECT 1 FROM public.master_frame_weight w
    WHERE w.density = d.value
  )
ORDER BY d.value;

-- 4. Near-miss pairs: same number, different text (e.g. '0.8' vs '0.80')
--    Non-numeric values such as the 'Others' sentinel are excluded first,
--    otherwise the ::numeric cast aborts the whole batch.
WITH numeric_dropdown AS (
  SELECT value, value::numeric AS num
  FROM public.master_frame_density
  WHERE value ~ '^[+-]?[0-9]*\.?[0-9]+$'
),
numeric_weight AS (
  SELECT density, density::numeric AS num
  FROM public.master_frame_weight
  WHERE density ~ '^[+-]?[0-9]*\.?[0-9]+$'
)
SELECT 'D. same value, different formatting' AS report,
       d.value   AS dropdown_density,
       w.density AS weight_table_density,
       COUNT(*)  AS affected_weight_rows
FROM numeric_dropdown d
JOIN numeric_weight w
  ON w.num = d.num
 AND w.density <> d.value
GROUP BY d.value, w.density
ORDER BY d.value;

-- 4b. Non-numeric density values (expected: only the 'Others' sentinel)
SELECT 'D2. non-numeric densities' AS report,
       value AS density,
       is_active
FROM public.master_frame_density
WHERE value !~ '^[+-]?[0-9]*\.?[0-9]+$'
ORDER BY value;

-- 5. The exact combination from the screenshot (4x2 + 0.8)
SELECT 'E. lookup for section 4x2' AS report,
       section,
       density,
       weight_per_foot,
       weight_per_foot * 12 AS per_piece_weight_at_12ft
FROM public.master_frame_weight
WHERE section = '4x2'
ORDER BY density;

-- 6. Every section/density combination the dropdowns allow
--    but the weight table is missing (full gap list)
SELECT 'F. missing section x density combinations' AS report,
       s.name  AS section,
       d.value AS density
FROM public.master_frame_section s
CROSS JOIN public.master_frame_density d
WHERE s.is_active
  AND d.is_active
  AND d.value <> 'Others'
  AND NOT EXISTS (
    SELECT 1 FROM public.master_frame_weight w
    WHERE w.section = s.name
      AND w.density = d.value
  )
ORDER BY s.name, d.value;

-- ── Same checks for SHEETS ─────────────────────────────────────

SELECT 'G. BROKEN sheet dropdown densities' AS report,
       d.value AS density
FROM public.master_sheet_density d
WHERE d.is_active
  AND d.value <> 'Others'
  AND NOT EXISTS (
    SELECT 1 FROM public.master_sheet_weight w
    WHERE w.density = d.value
  )
ORDER BY d.value;

-- Sheet near-miss pairs (numeric-safe, same approach as D)
WITH numeric_dropdown AS (
  SELECT value, value::numeric AS num
  FROM public.master_sheet_density
  WHERE value ~ '^[+-]?[0-9]*\.?[0-9]+$'
),
numeric_weight AS (
  SELECT density, density::numeric AS num
  FROM public.master_sheet_weight
  WHERE density ~ '^[+-]?[0-9]*\.?[0-9]+$'
)
SELECT 'G2. sheet same value, different formatting' AS report,
       d.value   AS dropdown_density,
       w.density AS weight_table_density,
       COUNT(*)  AS affected_weight_rows
FROM numeric_dropdown d
JOIN numeric_weight w
  ON w.num = d.num
 AND w.density <> d.value
GROUP BY d.value, w.density
ORDER BY d.value;

SELECT 'H. BROKEN sheet thicknesses' AS report,
       t.value AS thickness
FROM public.master_sheet_thickness t
WHERE t.is_active
  AND t.value <> 'Others'
  AND NOT EXISTS (
    SELECT 1 FROM public.master_sheet_weight w
    WHERE w.thickness = t.value
  )
ORDER BY t.value;
