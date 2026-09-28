-- ═══════════════════════════════════════════════════════════════
-- Factory App — Reference / Lookup Tables Seed Data
-- Run AFTER 01_schema.sql (or against an existing DataConnect schema).
-- Safe to re-run: ON CONFLICT DO NOTHING skips existing rows.
-- ═══════════════════════════════════════════════════════════════

SET ROLE "firebaseowner_fdcdb_public";

-- ══════════════════════════════════════════════════════════════
-- 1. FRAME WEIGHT TABLE
--    section × density → weight per foot (kg)
-- ══════════════════════════════════════════════════════════════
INSERT INTO public.master_frame_weight (id, section, density, weight_per_foot) VALUES
  -- 3x2
  (uuid_generate_v4(), '3x2',            '0.75', 0.486),
  (uuid_generate_v4(), '3x2',            '0.80', 0.519),
  (uuid_generate_v4(), '3x2',            '0.90', 0.584),
  -- 4x2
  (uuid_generate_v4(), '4x2',            '0.75', 0.647),
  (uuid_generate_v4(), '4x2',            '0.80', 0.690),
  (uuid_generate_v4(), '4x2',            '0.90', 0.777),
  -- 4x2.5
  (uuid_generate_v4(), '4x2.5',          '0.75', 0.810),
  (uuid_generate_v4(), '4x2.5',          '0.80', 0.864),
  (uuid_generate_v4(), '4x2.5',          '0.90', 0.972),
  -- 5x2.5
  (uuid_generate_v4(), '5x2.5',          '0.75', 1.012),
  (uuid_generate_v4(), '5x2.5',          '0.80', 1.080),
  (uuid_generate_v4(), '5x2.5',          '0.90', 1.215),
  -- 3x2 (HR)
  (uuid_generate_v4(), '3x2 (HR)',       '0.75', 0.486),
  (uuid_generate_v4(), '3x2 (HR)',       '0.80', 0.519),
  (uuid_generate_v4(), '3x2 (HR)',       '0.90', 0.584),
  -- 4x2.5(HR)
  (uuid_generate_v4(), '4x2.5(HR)',      '0.75', 0.810),
  (uuid_generate_v4(), '4x2.5(HR)',      '0.80', 0.864),
  (uuid_generate_v4(), '4x2.5(HR)',      '0.90', 0.972),
  -- Window Shutter
  (uuid_generate_v4(), 'Window Shutter', '0.75', 0.648),
  (uuid_generate_v4(), 'Window Shutter', '0.80', 0.691),
  (uuid_generate_v4(), 'Window Shutter', '0.90', 0.778)
ON CONFLICT ON CONSTRAINT uq_frame_weight DO NOTHING;

-- ══════════════════════════════════════════════════════════════
-- 2. SHEET WEIGHT TABLE
--    thickness × density → weight per sqft (kg)
-- ══════════════════════════════════════════════════════════════
INSERT INTO public.master_sheet_weight (id, thickness, density, weight_per_sqft) VALUES
  -- 6mm
  (uuid_generate_v4(), '6mm',        '0.45', 0.199),
  (uuid_generate_v4(), '6mm',        '0.50', 0.221),
  (uuid_generate_v4(), '6mm',        '0.55', 0.243),
  (uuid_generate_v4(), '6mm',        '0.60', 0.265),
  (uuid_generate_v4(), '6mm',        '0.65', 0.287),
  (uuid_generate_v4(), '6mm',        '0.70', 0.309),
  (uuid_generate_v4(), '6mm',        '0.80', 0.354),
  -- 7mm
  (uuid_generate_v4(), '7mm',        '0.45', 0.232),
  (uuid_generate_v4(), '7mm',        '0.50', 0.258),
  (uuid_generate_v4(), '7mm',        '0.55', 0.284),
  (uuid_generate_v4(), '7mm',        '0.60', 0.309),
  (uuid_generate_v4(), '7mm',        '0.65', 0.335),
  (uuid_generate_v4(), '7mm',        '0.70', 0.361),
  (uuid_generate_v4(), '7mm',        '0.80', 0.413),
  -- 8mm
  (uuid_generate_v4(), '8mm',        '0.45', 0.265),
  (uuid_generate_v4(), '8mm',        '0.50', 0.295),
  (uuid_generate_v4(), '8mm',        '0.55', 0.324),
  (uuid_generate_v4(), '8mm',        '0.60', 0.354),
  (uuid_generate_v4(), '8mm',        '0.65', 0.383),
  (uuid_generate_v4(), '8mm',        '0.70', 0.413),
  (uuid_generate_v4(), '8mm',        '0.80', 0.472),
  -- 9mm
  (uuid_generate_v4(), '9mm',        '0.45', 0.298),
  (uuid_generate_v4(), '9mm',        '0.50', 0.332),
  (uuid_generate_v4(), '9mm',        '0.55', 0.365),
  (uuid_generate_v4(), '9mm',        '0.60', 0.398),
  (uuid_generate_v4(), '9mm',        '0.65', 0.431),
  (uuid_generate_v4(), '9mm',        '0.70', 0.464),
  (uuid_generate_v4(), '9mm',        '0.80', 0.531),
  -- 12mm
  (uuid_generate_v4(), '12mm',       '0.45', 0.398),
  (uuid_generate_v4(), '12mm',       '0.50', 0.442),
  (uuid_generate_v4(), '12mm',       '0.55', 0.487),
  (uuid_generate_v4(), '12mm',       '0.60', 0.531),
  (uuid_generate_v4(), '12mm',       '0.65', 0.575),
  (uuid_generate_v4(), '12mm',       '0.70', 0.619),
  (uuid_generate_v4(), '12mm',       '0.80', 0.708),
  -- 13mm
  (uuid_generate_v4(), '13mm',       '0.45', 0.431),
  (uuid_generate_v4(), '13mm',       '0.50', 0.479),
  (uuid_generate_v4(), '13mm',       '0.55', 0.527),
  (uuid_generate_v4(), '13mm',       '0.60', 0.575),
  (uuid_generate_v4(), '13mm',       '0.65', 0.623),
  (uuid_generate_v4(), '13mm',       '0.70', 0.671),
  (uuid_generate_v4(), '13mm',       '0.80', 0.767),
  -- 16mm
  (uuid_generate_v4(), '16mm',       '0.45', 0.531),
  (uuid_generate_v4(), '16mm',       '0.50', 0.590),
  (uuid_generate_v4(), '16mm',       '0.55', 0.649),
  (uuid_generate_v4(), '16mm',       '0.60', 0.708),
  (uuid_generate_v4(), '16mm',       '0.65', 0.767),
  (uuid_generate_v4(), '16mm',       '0.70', 0.826),
  (uuid_generate_v4(), '16mm',       '0.80', 0.944),
  -- 17mm
  (uuid_generate_v4(), '17mm',       '0.45', 0.564),
  (uuid_generate_v4(), '17mm',       '0.50', 0.627),
  (uuid_generate_v4(), '17mm',       '0.55', 0.689),
  (uuid_generate_v4(), '17mm',       '0.60', 0.752),
  (uuid_generate_v4(), '17mm',       '0.65', 0.815),
  (uuid_generate_v4(), '17mm',       '0.70', 0.877),
  (uuid_generate_v4(), '17mm',       '0.80', 1.003),
  -- 18mm
  (uuid_generate_v4(), '18mm',       '0.45', 0.597),
  (uuid_generate_v4(), '18mm',       '0.50', 0.663),
  (uuid_generate_v4(), '18mm',       '0.55', 0.730),
  (uuid_generate_v4(), '18mm',       '0.60', 0.796),
  (uuid_generate_v4(), '18mm',       '0.65', 0.862),
  (uuid_generate_v4(), '18mm',       '0.70', 0.929),
  (uuid_generate_v4(), '18mm',       '0.80', 1.062),
  -- 19mm
  (uuid_generate_v4(), '19mm',       '0.45', 0.630),
  (uuid_generate_v4(), '19mm',       '0.50', 0.700),
  (uuid_generate_v4(), '19mm',       '0.55', 0.770),
  (uuid_generate_v4(), '19mm',       '0.60', 0.840),
  (uuid_generate_v4(), '19mm',       '0.65', 0.910),
  (uuid_generate_v4(), '19mm',       '0.70', 0.980),
  (uuid_generate_v4(), '19mm',       '0.80', 1.121),
  -- 22mm
  (uuid_generate_v4(), '22mm',       '0.45', 0.730),
  (uuid_generate_v4(), '22mm',       '0.50', 0.811),
  (uuid_generate_v4(), '22mm',       '0.55', 0.892),
  (uuid_generate_v4(), '22mm',       '0.60', 0.973),
  (uuid_generate_v4(), '22mm',       '0.65', 1.054),
  (uuid_generate_v4(), '22mm',       '0.70', 1.135),
  (uuid_generate_v4(), '22mm',       '0.80', 1.297),
  -- 25mm sheet
  (uuid_generate_v4(), '25mm sheet', '0.45', 0.829),
  (uuid_generate_v4(), '25mm sheet', '0.50', 0.921),
  (uuid_generate_v4(), '25mm sheet', '0.55', 1.013),
  (uuid_generate_v4(), '25mm sheet', '0.60', 1.106),
  (uuid_generate_v4(), '25mm sheet', '0.65', 1.198),
  (uuid_generate_v4(), '25mm sheet', '0.70', 1.290),
  (uuid_generate_v4(), '25mm sheet', '0.80', 1.475),
  -- 25mm Door
  (uuid_generate_v4(), '25mm Door',  '0.45', 0.829),
  (uuid_generate_v4(), '25mm Door',  '0.50', 0.921),
  (uuid_generate_v4(), '25mm Door',  '0.55', 1.013),
  (uuid_generate_v4(), '25mm Door',  '0.60', 1.106),
  (uuid_generate_v4(), '25mm Door',  '0.65', 1.198),
  (uuid_generate_v4(), '25mm Door',  '0.70', 1.290),
  (uuid_generate_v4(), '25mm Door',  '0.80', 1.475),
  -- 26mm
  (uuid_generate_v4(), '26mm',       '0.45', 0.862),
  (uuid_generate_v4(), '26mm',       '0.50', 0.958),
  (uuid_generate_v4(), '26mm',       '0.55', 1.054),
  (uuid_generate_v4(), '26mm',       '0.60', 1.150),
  (uuid_generate_v4(), '26mm',       '0.65', 1.246),
  (uuid_generate_v4(), '26mm',       '0.70', 1.341),
  (uuid_generate_v4(), '26mm',       '0.80', 1.534),
  -- 27mm
  (uuid_generate_v4(), '27mm',       '0.45', 0.895),
  (uuid_generate_v4(), '27mm',       '0.50', 0.995),
  (uuid_generate_v4(), '27mm',       '0.55', 1.094),
  (uuid_generate_v4(), '27mm',       '0.60', 1.194),
  (uuid_generate_v4(), '27mm',       '0.65', 1.293),
  (uuid_generate_v4(), '27mm',       '0.70', 1.393),
  (uuid_generate_v4(), '27mm',       '0.80', 1.593),
  -- 28mm
  (uuid_generate_v4(), '28mm',       '0.45', 0.929),
  (uuid_generate_v4(), '28mm',       '0.50', 1.032),
  (uuid_generate_v4(), '28mm',       '0.55', 1.135),
  (uuid_generate_v4(), '28mm',       '0.60', 1.238),
  (uuid_generate_v4(), '28mm',       '0.65', 1.341),
  (uuid_generate_v4(), '28mm',       '0.70', 1.444),
  (uuid_generate_v4(), '28mm',       '0.80', 1.652),
  -- 30mm
  (uuid_generate_v4(), '30mm',       '0.45', 0.995),
  (uuid_generate_v4(), '30mm',       '0.50', 1.106),
  (uuid_generate_v4(), '30mm',       '0.55', 1.216),
  (uuid_generate_v4(), '30mm',       '0.60', 1.327),
  (uuid_generate_v4(), '30mm',       '0.65', 1.437),
  (uuid_generate_v4(), '30mm',       '0.70', 1.548),
  (uuid_generate_v4(), '30mm',       '0.80', 1.770),
  -- 31mm
  (uuid_generate_v4(), '31mm',       '0.45', 1.028),
  (uuid_generate_v4(), '31mm',       '0.50', 1.143),
  (uuid_generate_v4(), '31mm',       '0.55', 1.257),
  (uuid_generate_v4(), '31mm',       '0.60', 1.371),
  (uuid_generate_v4(), '31mm',       '0.65', 1.485),
  (uuid_generate_v4(), '31mm',       '0.70', 1.600),
  (uuid_generate_v4(), '31mm',       '0.80', 1.829),
  -- 33mm
  (uuid_generate_v4(), '33mm',       '0.45', 1.094),
  (uuid_generate_v4(), '33mm',       '0.50', 1.216),
  (uuid_generate_v4(), '33mm',       '0.55', 1.338),
  (uuid_generate_v4(), '33mm',       '0.60', 1.460),
  (uuid_generate_v4(), '33mm',       '0.65', 1.581),
  (uuid_generate_v4(), '33mm',       '0.70', 1.703),
  (uuid_generate_v4(), '33mm',       '0.80', 1.947),
  -- 35mm
  (uuid_generate_v4(), '35mm',       '0.45', 1.161),
  (uuid_generate_v4(), '35mm',       '0.50', 1.290),
  (uuid_generate_v4(), '35mm',       '0.55', 1.419),
  (uuid_generate_v4(), '35mm',       '0.60', 1.548),
  (uuid_generate_v4(), '35mm',       '0.65', 1.677),
  (uuid_generate_v4(), '35mm',       '0.70', 1.806),
  (uuid_generate_v4(), '35mm',       '0.80', 2.065),
  -- 36mm
  (uuid_generate_v4(), '36mm',       '0.45', 1.194),
  (uuid_generate_v4(), '36mm',       '0.50', 1.327),
  (uuid_generate_v4(), '36mm',       '0.55', 1.460),
  (uuid_generate_v4(), '36mm',       '0.60', 1.593),
  (uuid_generate_v4(), '36mm',       '0.65', 1.725),
  (uuid_generate_v4(), '36mm',       '0.70', 1.858),
  (uuid_generate_v4(), '36mm',       '0.80', 2.124)
ON CONFLICT ON CONSTRAINT uq_sheet_weight DO NOTHING;

-- ══════════════════════════════════════════════════════════════
-- 3. FRAME PRODUCTION TARGETS
--    section × density → target kg per hour
--    One row per section-density combination so the admin can tune
--    targets independently for each density grade.
-- ══════════════════════════════════════════════════════════════
INSERT INTO public.master_frame_target (id, section, density, target_kg_per_hour) VALUES
  -- 3x2
  (uuid_generate_v4(), '3x2',            '0.75',  80.0),
  (uuid_generate_v4(), '3x2',            '0.80',  80.0),
  (uuid_generate_v4(), '3x2',            '0.90',  80.0),
  -- 4x2
  (uuid_generate_v4(), '4x2',            '0.75', 100.0),
  (uuid_generate_v4(), '4x2',            '0.80', 100.0),
  (uuid_generate_v4(), '4x2',            '0.90', 100.0),
  -- 4x2.5
  (uuid_generate_v4(), '4x2.5',          '0.75', 120.0),
  (uuid_generate_v4(), '4x2.5',          '0.80', 120.0),
  (uuid_generate_v4(), '4x2.5',          '0.90', 120.0),
  -- 5x2.5
  (uuid_generate_v4(), '5x2.5',          '0.75', 140.0),
  (uuid_generate_v4(), '5x2.5',          '0.80', 140.0),
  (uuid_generate_v4(), '5x2.5',          '0.90', 140.0),
  -- 3x2 (HR)
  (uuid_generate_v4(), '3x2 (HR)',       '0.75',  80.0),
  (uuid_generate_v4(), '3x2 (HR)',       '0.80',  80.0),
  (uuid_generate_v4(), '3x2 (HR)',       '0.90',  80.0),
  -- 4x2.5(HR)
  (uuid_generate_v4(), '4x2.5(HR)',      '0.75', 120.0),
  (uuid_generate_v4(), '4x2.5(HR)',      '0.80', 120.0),
  (uuid_generate_v4(), '4x2.5(HR)',      '0.90', 120.0),
  -- Window Shutter
  (uuid_generate_v4(), 'Window Shutter', '0.75',  90.0),
  (uuid_generate_v4(), 'Window Shutter', '0.80',  90.0),
  (uuid_generate_v4(), 'Window Shutter', '0.90',  90.0)
ON CONFLICT ON CONSTRAINT uq_frame_target DO NOTHING;

-- ══════════════════════════════════════════════════════════════
-- 4. SHEET PRODUCTION TARGETS
--    thickness × density → target running feet per hour
-- ══════════════════════════════════════════════════════════════
INSERT INTO public.master_sheet_target (id, thickness, density, target_feet_per_hour) VALUES
  -- 6mm
  (uuid_generate_v4(), '6mm',        '0.45', 250.0),
  (uuid_generate_v4(), '6mm',        '0.50', 250.0),
  (uuid_generate_v4(), '6mm',        '0.55', 250.0),
  (uuid_generate_v4(), '6mm',        '0.60', 250.0),
  (uuid_generate_v4(), '6mm',        '0.65', 250.0),
  (uuid_generate_v4(), '6mm',        '0.70', 250.0),
  (uuid_generate_v4(), '6mm',        '0.80', 250.0),
  -- 7mm
  (uuid_generate_v4(), '7mm',        '0.45', 230.0),
  (uuid_generate_v4(), '7mm',        '0.50', 230.0),
  (uuid_generate_v4(), '7mm',        '0.55', 230.0),
  (uuid_generate_v4(), '7mm',        '0.60', 230.0),
  (uuid_generate_v4(), '7mm',        '0.65', 230.0),
  (uuid_generate_v4(), '7mm',        '0.70', 230.0),
  (uuid_generate_v4(), '7mm',        '0.80', 230.0),
  -- 8mm
  (uuid_generate_v4(), '8mm',        '0.45', 210.0),
  (uuid_generate_v4(), '8mm',        '0.50', 210.0),
  (uuid_generate_v4(), '8mm',        '0.55', 210.0),
  (uuid_generate_v4(), '8mm',        '0.60', 210.0),
  (uuid_generate_v4(), '8mm',        '0.65', 210.0),
  (uuid_generate_v4(), '8mm',        '0.70', 210.0),
  (uuid_generate_v4(), '8mm',        '0.80', 210.0),
  -- 9mm
  (uuid_generate_v4(), '9mm',        '0.45', 200.0),
  (uuid_generate_v4(), '9mm',        '0.50', 200.0),
  (uuid_generate_v4(), '9mm',        '0.55', 200.0),
  (uuid_generate_v4(), '9mm',        '0.60', 200.0),
  (uuid_generate_v4(), '9mm',        '0.65', 200.0),
  (uuid_generate_v4(), '9mm',        '0.70', 200.0),
  (uuid_generate_v4(), '9mm',        '0.80', 200.0),
  -- 12mm
  (uuid_generate_v4(), '12mm',       '0.45', 170.0),
  (uuid_generate_v4(), '12mm',       '0.50', 170.0),
  (uuid_generate_v4(), '12mm',       '0.55', 170.0),
  (uuid_generate_v4(), '12mm',       '0.60', 170.0),
  (uuid_generate_v4(), '12mm',       '0.65', 170.0),
  (uuid_generate_v4(), '12mm',       '0.70', 170.0),
  (uuid_generate_v4(), '12mm',       '0.80', 170.0),
  -- 13mm
  (uuid_generate_v4(), '13mm',       '0.45', 160.0),
  (uuid_generate_v4(), '13mm',       '0.50', 160.0),
  (uuid_generate_v4(), '13mm',       '0.55', 160.0),
  (uuid_generate_v4(), '13mm',       '0.60', 160.0),
  (uuid_generate_v4(), '13mm',       '0.65', 160.0),
  (uuid_generate_v4(), '13mm',       '0.70', 160.0),
  (uuid_generate_v4(), '13mm',       '0.80', 160.0),
  -- 16mm
  (uuid_generate_v4(), '16mm',       '0.45', 140.0),
  (uuid_generate_v4(), '16mm',       '0.50', 140.0),
  (uuid_generate_v4(), '16mm',       '0.55', 140.0),
  (uuid_generate_v4(), '16mm',       '0.60', 140.0),
  (uuid_generate_v4(), '16mm',       '0.65', 140.0),
  (uuid_generate_v4(), '16mm',       '0.70', 140.0),
  (uuid_generate_v4(), '16mm',       '0.80', 140.0),
  -- 17mm
  (uuid_generate_v4(), '17mm',       '0.45', 130.0),
  (uuid_generate_v4(), '17mm',       '0.50', 130.0),
  (uuid_generate_v4(), '17mm',       '0.55', 130.0),
  (uuid_generate_v4(), '17mm',       '0.60', 130.0),
  (uuid_generate_v4(), '17mm',       '0.65', 130.0),
  (uuid_generate_v4(), '17mm',       '0.70', 130.0),
  (uuid_generate_v4(), '17mm',       '0.80', 130.0),
  -- 18mm
  (uuid_generate_v4(), '18mm',       '0.45', 125.0),
  (uuid_generate_v4(), '18mm',       '0.50', 125.0),
  (uuid_generate_v4(), '18mm',       '0.55', 125.0),
  (uuid_generate_v4(), '18mm',       '0.60', 125.0),
  (uuid_generate_v4(), '18mm',       '0.65', 125.0),
  (uuid_generate_v4(), '18mm',       '0.70', 125.0),
  (uuid_generate_v4(), '18mm',       '0.80', 125.0),
  -- 19mm
  (uuid_generate_v4(), '19mm',       '0.45', 120.0),
  (uuid_generate_v4(), '19mm',       '0.50', 120.0),
  (uuid_generate_v4(), '19mm',       '0.55', 120.0),
  (uuid_generate_v4(), '19mm',       '0.60', 120.0),
  (uuid_generate_v4(), '19mm',       '0.65', 120.0),
  (uuid_generate_v4(), '19mm',       '0.70', 120.0),
  (uuid_generate_v4(), '19mm',       '0.80', 120.0),
  -- 22mm
  (uuid_generate_v4(), '22mm',       '0.45', 100.0),
  (uuid_generate_v4(), '22mm',       '0.50', 100.0),
  (uuid_generate_v4(), '22mm',       '0.55', 100.0),
  (uuid_generate_v4(), '22mm',       '0.60', 100.0),
  (uuid_generate_v4(), '22mm',       '0.65', 100.0),
  (uuid_generate_v4(), '22mm',       '0.70', 100.0),
  (uuid_generate_v4(), '22mm',       '0.80', 100.0),
  -- 25mm sheet
  (uuid_generate_v4(), '25mm sheet', '0.45',  85.0),
  (uuid_generate_v4(), '25mm sheet', '0.50',  85.0),
  (uuid_generate_v4(), '25mm sheet', '0.55',  85.0),
  (uuid_generate_v4(), '25mm sheet', '0.60',  85.0),
  (uuid_generate_v4(), '25mm sheet', '0.65',  85.0),
  (uuid_generate_v4(), '25mm sheet', '0.70',  85.0),
  (uuid_generate_v4(), '25mm sheet', '0.80',  85.0),
  -- 25mm Door
  (uuid_generate_v4(), '25mm Door',  '0.45',  85.0),
  (uuid_generate_v4(), '25mm Door',  '0.50',  85.0),
  (uuid_generate_v4(), '25mm Door',  '0.55',  85.0),
  (uuid_generate_v4(), '25mm Door',  '0.60',  85.0),
  (uuid_generate_v4(), '25mm Door',  '0.65',  85.0),
  (uuid_generate_v4(), '25mm Door',  '0.70',  85.0),
  (uuid_generate_v4(), '25mm Door',  '0.80',  85.0),
  -- 26mm
  (uuid_generate_v4(), '26mm',       '0.45',  80.0),
  (uuid_generate_v4(), '26mm',       '0.50',  80.0),
  (uuid_generate_v4(), '26mm',       '0.55',  80.0),
  (uuid_generate_v4(), '26mm',       '0.60',  80.0),
  (uuid_generate_v4(), '26mm',       '0.65',  80.0),
  (uuid_generate_v4(), '26mm',       '0.70',  80.0),
  (uuid_generate_v4(), '26mm',       '0.80',  80.0),
  -- 27mm
  (uuid_generate_v4(), '27mm',       '0.45',  78.0),
  (uuid_generate_v4(), '27mm',       '0.50',  78.0),
  (uuid_generate_v4(), '27mm',       '0.55',  78.0),
  (uuid_generate_v4(), '27mm',       '0.60',  78.0),
  (uuid_generate_v4(), '27mm',       '0.65',  78.0),
  (uuid_generate_v4(), '27mm',       '0.70',  78.0),
  (uuid_generate_v4(), '27mm',       '0.80',  78.0),
  -- 28mm
  (uuid_generate_v4(), '28mm',       '0.45',  75.0),
  (uuid_generate_v4(), '28mm',       '0.50',  75.0),
  (uuid_generate_v4(), '28mm',       '0.55',  75.0),
  (uuid_generate_v4(), '28mm',       '0.60',  75.0),
  (uuid_generate_v4(), '28mm',       '0.65',  75.0),
  (uuid_generate_v4(), '28mm',       '0.70',  75.0),
  (uuid_generate_v4(), '28mm',       '0.80',  75.0),
  -- 30mm
  (uuid_generate_v4(), '30mm',       '0.45',  70.0),
  (uuid_generate_v4(), '30mm',       '0.50',  70.0),
  (uuid_generate_v4(), '30mm',       '0.55',  70.0),
  (uuid_generate_v4(), '30mm',       '0.60',  70.0),
  (uuid_generate_v4(), '30mm',       '0.65',  70.0),
  (uuid_generate_v4(), '30mm',       '0.70',  70.0),
  (uuid_generate_v4(), '30mm',       '0.80',  70.0),
  -- 31mm
  (uuid_generate_v4(), '31mm',       '0.45',  68.0),
  (uuid_generate_v4(), '31mm',       '0.50',  68.0),
  (uuid_generate_v4(), '31mm',       '0.55',  68.0),
  (uuid_generate_v4(), '31mm',       '0.60',  68.0),
  (uuid_generate_v4(), '31mm',       '0.65',  68.0),
  (uuid_generate_v4(), '31mm',       '0.70',  68.0),
  (uuid_generate_v4(), '31mm',       '0.80',  68.0),
  -- 33mm
  (uuid_generate_v4(), '33mm',       '0.45',  60.0),
  (uuid_generate_v4(), '33mm',       '0.50',  60.0),
  (uuid_generate_v4(), '33mm',       '0.55',  60.0),
  (uuid_generate_v4(), '33mm',       '0.60',  60.0),
  (uuid_generate_v4(), '33mm',       '0.65',  60.0),
  (uuid_generate_v4(), '33mm',       '0.70',  60.0),
  (uuid_generate_v4(), '33mm',       '0.80',  60.0),
  -- 35mm
  (uuid_generate_v4(), '35mm',       '0.45',  55.0),
  (uuid_generate_v4(), '35mm',       '0.50',  55.0),
  (uuid_generate_v4(), '35mm',       '0.55',  55.0),
  (uuid_generate_v4(), '35mm',       '0.60',  55.0),
  (uuid_generate_v4(), '35mm',       '0.65',  55.0),
  (uuid_generate_v4(), '35mm',       '0.70',  55.0),
  (uuid_generate_v4(), '35mm',       '0.80',  55.0),
  -- 36mm
  (uuid_generate_v4(), '36mm',       '0.45',  52.0),
  (uuid_generate_v4(), '36mm',       '0.50',  52.0),
  (uuid_generate_v4(), '36mm',       '0.55',  52.0),
  (uuid_generate_v4(), '36mm',       '0.60',  52.0),
  (uuid_generate_v4(), '36mm',       '0.65',  52.0),
  (uuid_generate_v4(), '36mm',       '0.70',  52.0),
  (uuid_generate_v4(), '36mm',       '0.80',  52.0)
ON CONFLICT ON CONSTRAINT uq_sheet_target DO NOTHING;

-- ══════════════════════════════════════════════════════════════
-- 5. SCRAP PRODUCTION TARGETS
--    product → target kg per hour
-- ══════════════════════════════════════════════════════════════
INSERT INTO public.master_scrap_target (id, product, target_kg_per_hour) VALUES
  (uuid_generate_v4(), 'Frames Brown Color Scrap',  100.0),
  (uuid_generate_v4(), 'Sheets Brown Color Scrap',  100.0),
  (uuid_generate_v4(), 'Sheets Ivory Color Scrap',  100.0),
  (uuid_generate_v4(), 'Sheets NFC Color Scrap',    100.0),
  (uuid_generate_v4(), 'Sheets Orange Color Scrap', 100.0),
  (uuid_generate_v4(), 'Mix scrap',                 100.0)
ON CONFLICT (product) DO NOTHING;

-- ══════════════════════════════════════════════════════════════
-- 6. SALARY WEIGHTAGES
--    variable × category → percentage (per category must sum to 100)
-- ══════════════════════════════════════════════════════════════

-- Frame/Sheet operators
INSERT INTO public.master_salary_weightage (id, variable, label, category, percentage) VALUES
  (uuid_generate_v4(), 'wA', 'Machine Cleaning',     'frame_sheet', 15.0),
  (uuid_generate_v4(), 'wB', 'Tools Count',           'frame_sheet', 10.0),
  (uuid_generate_v4(), 'wC', 'Machine Health',         'frame_sheet', 25.0),
  (uuid_generate_v4(), 'wD', 'Production Efficiency', 'frame_sheet', 20.0),
  (uuid_generate_v4(), 'wE', 'Report Writing',         'frame_sheet', 20.0),
  (uuid_generate_v4(), 'wF', 'Quality / Packing',     'frame_sheet', 10.0);

-- Scrap/Regrind operators
INSERT INTO public.master_salary_weightage (id, variable, label, category, percentage) VALUES
  (uuid_generate_v4(), 'wA', 'Machine Cleaning %',         'scrap', 15.0),
  (uuid_generate_v4(), 'wB', 'Tools Count %',               'scrap', 10.0),
  (uuid_generate_v4(), 'wE', 'Production Efficiency %',     'scrap', 30.0),
  (uuid_generate_v4(), 'wF', 'Report Writing Efficiency %', 'scrap', 20.0),
  (uuid_generate_v4(), 'wG', 'Scrap Quality Rating %',      'scrap', 25.0);

-- ══════════════════════════════════════════════════════════════
-- VERIFICATION: Row counts per reference table
-- ══════════════════════════════════════════════════════════════
SELECT 'master_frame_weight'     AS table_name, count(*) AS rows FROM public.master_frame_weight
UNION ALL SELECT 'master_sheet_weight',    count(*) FROM public.master_sheet_weight
UNION ALL SELECT 'master_frame_target',   count(*) FROM public.master_frame_target
UNION ALL SELECT 'master_sheet_target',   count(*) FROM public.master_sheet_target
UNION ALL SELECT 'master_scrap_target',   count(*) FROM public.master_scrap_target
UNION ALL SELECT 'master_salary_weightage', count(*) FROM public.master_salary_weightage
ORDER BY table_name;
