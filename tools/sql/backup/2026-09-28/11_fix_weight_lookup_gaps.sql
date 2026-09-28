-- ═══════════════════════════════════════════════════════════════
-- 11. Fix frame weight-lookup gaps
--
-- Run 10_weight_mismatch_summary.sql first. This script acts on what
-- that report found:
--
--   * density "1" is active in the dropdown but has NO weight rows,
--     so any operator who picks it gets 0 kg per piece.
--   * density "0.8" has only 1 weight row while "0.75" and "0.90"
--     have 6 each, so 0.8 works for one section and gives 0 kg for
--     every other section.
--   * densities "0.95" and "99" are inactive but still carry weight
--     rows (harmless, but they clutter the table).
--
-- STEP 1 and STEP 2 are read-only. Read their output before running
-- STEP 3, which is the only part that writes.
-- ═══════════════════════════════════════════════════════════════


-- ───────────────────────────────────────────────────────────────
-- STEP 1 (read-only): every section × active-density combination
-- that has no weight row. Each of these silently produces 0 kg.
-- ───────────────────────────────────────────────────────────────
SELECT 'gap: no weight row' AS issue,
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


-- ───────────────────────────────────────────────────────────────
-- STEP 2 (read-only): weight values that look mistyped.
--
-- weight_per_foot should rise smoothly with density for a given
-- section (e.g. 4x2: 0.75 -> 0.647, 0.90 -> 0.777). A row whose
-- weight is suspiciously close to its own density value is usually
-- someone typing the density into the weight field by mistake —
-- this is what happened to 4x2 / 0.8 (weight_per_foot = 0.8).
-- ───────────────────────────────────────────────────────────────
WITH numeric_rows AS (
  SELECT section, density, weight_per_foot, density::numeric AS density_num
  FROM public.master_frame_weight
  WHERE density ~ '^[+-]?[0-9]*\.?[0-9]+$'
)
SELECT 'suspect: weight == density' AS issue,
       section,
       density,
       weight_per_foot,
       weight_per_foot * 12 AS per_piece_at_12ft
FROM numeric_rows
WHERE abs(weight_per_foot - density_num) < 0.0001
ORDER BY section, density;


-- ───────────────────────────────────────────────────────────────
-- STEP 3 (WRITES): hide densities that cannot be calculated.
--
-- Deactivating is reversible and immediately stops operators from
-- selecting a density that yields 0 kg. It does NOT delete the
-- density — flip is_active back to true once weight rows exist.
--
-- This catches density "1". It leaves "0.8" active, because 0.8
-- does have a weight row; see the note after this block.
-- ───────────────────────────────────────────────────────────────
BEGIN;

UPDATE public.master_frame_density d
SET is_active = false
WHERE d.is_active
  AND d.value <> 'Others'
  AND NOT EXISTS (
    SELECT 1 FROM public.master_frame_weight w
    WHERE w.density = d.value
  );

-- Confirm what is still selectable after the update.
SELECT 'still active' AS status,
       d.value AS density,
       (SELECT COUNT(*) FROM public.master_frame_weight w
        WHERE w.density = d.value) AS weight_rows
FROM public.master_frame_density d
WHERE d.is_active
ORDER BY d.value;

COMMIT;


-- ═══════════════════════════════════════════════════════════════
-- REMAINING WORK — needs your input, not a script
--
-- 1. Density 0.8 is only configured for one section. Either add the
--    missing rows (STEP 1 lists them) via Admin > Reference tables,
--    or deactivate 0.8 until they exist.
--
-- 2. The 4x2 / 0.8 row has weight_per_foot = 0.8, which STEP 2
--    flags as mistyped. Interpolating from the neighbouring rows
--    (0.75 -> 0.647, 0.90 -> 0.777) the correct value is ~0.690.
--    Confirm against your spec sheet, then correct it:
--
--      UPDATE public.master_frame_weight
--      SET weight_per_foot = 0.690
--      WHERE section = '4x2' AND density = '0.8';
--
-- 3. Densities 0.95 and 99 are inactive test entries that still own
--    weight rows. Safe to leave. To remove them entirely, delete the
--    weight rows first, then the density row — in that order, or the
--    master-reference FKs will reject it.
-- ═══════════════════════════════════════════════════════════════
