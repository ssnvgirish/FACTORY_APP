-- ═══════════════════════════════════════════════════════════════
-- Factory App — Weight lookup mismatch, single-result summary
-- ═══════════════════════════════════════════════════════════════
-- Returns ONE result grid so it is easy to read/copy out of the
-- Google Cloud SQL query window.
--
-- READ-ONLY. Safe to run any time.
--
-- How to read the output:
--   A  every density the dropdown offers
--   B  every density the weight table actually uses (+ row count)
--   C  densities that produce Per Piece Weight = 0   <-- THE BUG
--   D  same number stored two ways, e.g. '0.8' vs '0.80'
--   E  the weight rows for section 4x2 (screenshot case)
-- ═══════════════════════════════════════════════════════════════

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

SELECT 'A. dropdown density' AS report,
       value                 AS value_1,
       CASE WHEN is_active THEN 'active' ELSE 'inactive' END AS value_2,
       ''                    AS detail
FROM public.master_frame_density

UNION ALL
SELECT 'B. weight-table density',
       density,
       COUNT(*)::text,
       'weight rows'
FROM public.master_frame_weight
GROUP BY density

UNION ALL
SELECT 'C. BROKEN -> gives 0 kg',
       d.value,
       '',
       'no weight rows for this density'
FROM public.master_frame_density d
WHERE d.is_active
  AND d.value <> 'Others'
  AND NOT EXISTS (
    SELECT 1 FROM public.master_frame_weight w
    WHERE w.density = d.value
  )

UNION ALL
SELECT 'D. near-miss formatting',
       d.value,
       w.density,
       COUNT(*)::text || ' weight rows use the right-hand form'
FROM numeric_dropdown d
JOIN numeric_weight w
  ON w.num = d.num
 AND w.density <> d.value
GROUP BY d.value, w.density

UNION ALL
SELECT 'E. section 4x2 rows',
       density,
       weight_per_foot::text,
       'per piece @12ft = ' || (weight_per_foot * 12)::text
FROM public.master_frame_weight
WHERE section = '4x2'

ORDER BY report, value_1;
