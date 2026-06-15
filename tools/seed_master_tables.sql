-- ═══════════════════════════════════════════════════════════════
-- Seed Master Tables — Run against fdcdb on Cloud SQL
-- Safe to re-run: ON CONFLICT DO NOTHING skips existing rows.
-- ═══════════════════════════════════════════════════════════════

SET ROLE "firebaseowner_fdcdb_public";

-- ══════════════════════════════════════
-- 1. MACHINES
-- ══════════════════════════════════════
INSERT INTO public.master_machine (id, name, type, sort_order, is_active) VALUES
  (uuid_generate_v4(), 'Frame Machine 1',      'frame', 1,  true),
  (uuid_generate_v4(), 'Frame Machine 2',      'frame', 2,  true),
  (uuid_generate_v4(), 'Sheet Machine 3',      'sheet', 3,  true),
  (uuid_generate_v4(), 'Sheet Machine 4',      'sheet', 4,  true),
  (uuid_generate_v4(), 'Sheet Machine 5',      'sheet', 5,  true),
  (uuid_generate_v4(), 'Crusher Machine 1',    'scrap', 6,  true),
  (uuid_generate_v4(), 'Crusher Machine 2',    'scrap', 7,  true),
  (uuid_generate_v4(), 'Crusher Machine 3',    'scrap', 8,  true),
  (uuid_generate_v4(), 'Pulverizer Machine 1', 'scrap', 9,  true),
  (uuid_generate_v4(), 'Pulverizer Machine 2', 'scrap', 10, true),
  (uuid_generate_v4(), 'Pulverizer Machine 3', 'scrap', 11, true),
  (uuid_generate_v4(), 'Shredder',             'scrap', 12, true)
ON CONFLICT (name) DO NOTHING;

-- ══════════════════════════════════════
-- 2. SHIFTS
-- ══════════════════════════════════════
INSERT INTO public.master_shift (id, name, sort_order, is_active) VALUES
  (uuid_generate_v4(), 'Day Shift',   1, true),
  (uuid_generate_v4(), 'Night Shift', 2, true)
ON CONFLICT (name) DO NOTHING;

-- ══════════════════════════════════════
-- 3. ROLES
-- ══════════════════════════════════════
INSERT INTO public.master_role (id, code, display_name, sort_order, is_active) VALUES
  (uuid_generate_v4(), 'machine_operator',           'Machine Operator',              1, true),
  (uuid_generate_v4(), 'quality_packing_supervisor',  'Quality & Packing Supervisor', 2, true),
  (uuid_generate_v4(), 'frames_senior_operator',      'Frames Senior Operator',       3, true),
  (uuid_generate_v4(), 'sheet_senior_operator',       'Sheet Senior Operator',        4, true),
  (uuid_generate_v4(), 'plant_manager',               'Plant Manager',                5, true),
  (uuid_generate_v4(), 'admin',                       'Admin',                        6, true)
ON CONFLICT (code) DO NOTHING;

-- ══════════════════════════════════════
-- 4. FRAME SECTIONS
-- ══════════════════════════════════════
INSERT INTO public.master_frame_section (id, name, sort_order, is_active) VALUES
  (uuid_generate_v4(), '3x2',            1, true),
  (uuid_generate_v4(), '4x2',            2, true),
  (uuid_generate_v4(), '4x2.5',          3, true),
  (uuid_generate_v4(), '5x2.5',          4, true),
  (uuid_generate_v4(), '3x2 (HR)',       5, true),
  (uuid_generate_v4(), '4x2.5(HR)',      6, true),
  (uuid_generate_v4(), 'Window Shutter', 7, true)
ON CONFLICT (name) DO NOTHING;

-- ══════════════════════════════════════
-- 5. FRAME DENSITIES
-- ══════════════════════════════════════
INSERT INTO public.master_frame_density (id, value, sort_order, is_active) VALUES
  (uuid_generate_v4(), '0.75',   1, true),
  (uuid_generate_v4(), '0.80',   2, true),
  (uuid_generate_v4(), '0.90',   3, true),
  (uuid_generate_v4(), 'Others', 4, true)
ON CONFLICT (value) DO NOTHING;

-- ══════════════════════════════════════
-- 6. FRAME COLORS
-- ══════════════════════════════════════
INSERT INTO public.master_frame_color (id, name, sort_order, is_active) VALUES
  (uuid_generate_v4(), 'Brown',     1, true),
  (uuid_generate_v4(), 'Ivory',     2, true),
  (uuid_generate_v4(), 'NFC Color', 3, true)
ON CONFLICT (name) DO NOTHING;

-- ══════════════════════════════════════
-- 7. SHEET THICKNESSES
-- ══════════════════════════════════════
INSERT INTO public.master_sheet_thickness (id, value, sort_order, is_active) VALUES
  (uuid_generate_v4(), '6mm',        1,  true),
  (uuid_generate_v4(), '7mm',        2,  true),
  (uuid_generate_v4(), '8mm',        3,  true),
  (uuid_generate_v4(), '9mm',        4,  true),
  (uuid_generate_v4(), '12mm',       5,  true),
  (uuid_generate_v4(), '13mm',       6,  true),
  (uuid_generate_v4(), '16mm',       7,  true),
  (uuid_generate_v4(), '17mm',       8,  true),
  (uuid_generate_v4(), '18mm',       9,  true),
  (uuid_generate_v4(), '19mm',       10, true),
  (uuid_generate_v4(), '22mm',       11, true),
  (uuid_generate_v4(), '25mm sheet', 12, true),
  (uuid_generate_v4(), '25mm Door',  13, true),
  (uuid_generate_v4(), '26mm',       14, true),
  (uuid_generate_v4(), '27mm',       15, true),
  (uuid_generate_v4(), '28mm',       16, true),
  (uuid_generate_v4(), '30mm',       17, true),
  (uuid_generate_v4(), '31mm',       18, true),
  (uuid_generate_v4(), '33mm',       19, true),
  (uuid_generate_v4(), '35mm',       20, true),
  (uuid_generate_v4(), '36mm',       21, true)
ON CONFLICT (value) DO NOTHING;

-- ══════════════════════════════════════
-- 8. SHEET DENSITIES
-- ══════════════════════════════════════
INSERT INTO public.master_sheet_density (id, value, sort_order, is_active) VALUES
  (uuid_generate_v4(), '0.45',   1, true),
  (uuid_generate_v4(), '0.50',   2, true),
  (uuid_generate_v4(), '0.55',   3, true),
  (uuid_generate_v4(), '0.60',   4, true),
  (uuid_generate_v4(), '0.65',   5, true),
  (uuid_generate_v4(), '0.70',   6, true),
  (uuid_generate_v4(), '0.80',   7, true),
  (uuid_generate_v4(), 'Others', 8, true)
ON CONFLICT (value) DO NOTHING;

-- ══════════════════════════════════════
-- 9. SHEET COLORS
-- ══════════════════════════════════════
INSERT INTO public.master_sheet_color (id, name, sort_order, is_active) VALUES
  (uuid_generate_v4(), 'Brown',          1, true),
  (uuid_generate_v4(), 'Ivory',          2, true),
  (uuid_generate_v4(), 'NFC Sanding',    3, true),
  (uuid_generate_v4(), 'NFC No Sanding', 4, true),
  (uuid_generate_v4(), 'White',          5, true)
ON CONFLICT (name) DO NOTHING;

-- ══════════════════════════════════════
-- 10. MAINTENANCE ITEMS (frame + scrap)
-- ══════════════════════════════════════
INSERT INTO public.master_maintenance_item (id, name, category, sort_order, is_active) VALUES
  -- Frame maintenance
  (uuid_generate_v4(), 'Die Cleaning',                          'frame', 1,  true),
  (uuid_generate_v4(), 'Die Change',                            'frame', 2,  true),
  (uuid_generate_v4(), 'Generator Maintenance',                 'frame', 3,  true),
  (uuid_generate_v4(), 'Air Compressor Maintenance',            'frame', 4,  true),
  (uuid_generate_v4(), 'Chiller Maintenance',                   'frame', 5,  true),
  (uuid_generate_v4(), 'Mixer Maintenance',                     'frame', 6,  true),
  (uuid_generate_v4(), 'Main Machine Maintenance',              'frame', 7,  true),
  (uuid_generate_v4(), 'UPS Maintenance',                       'frame', 8,  true),
  (uuid_generate_v4(), 'Others',                                'frame', 9,  true),
  -- Scrap maintenance
  (uuid_generate_v4(), 'Blade gap adjustment',                  'scrap', 10, true),
  (uuid_generate_v4(), 'Blade replacement',                     'scrap', 11, true),
  (uuid_generate_v4(), 'Generator maintenance',                 'scrap', 12, true),
  (uuid_generate_v4(), 'Motors maintenance',                    'scrap', 13, true),
  (uuid_generate_v4(), 'Panel Board maintenance',               'scrap', 14, true),
  (uuid_generate_v4(), 'Machine electrical parts maintenance',  'scrap', 15, true),
  (uuid_generate_v4(), 'Machine mechanical parts maintenance',  'scrap', 16, true),
  (uuid_generate_v4(), 'Others',                                'scrap', 17, true)
ON CONFLICT (name) DO NOTHING;

-- ══════════════════════════════════════
-- 11. SCRAP PRODUCTS
-- ══════════════════════════════════════
INSERT INTO public.master_scrap_product (id, name, sort_order, is_active) VALUES
  (uuid_generate_v4(), 'Frames Brown Color Scrap',  1, true),
  (uuid_generate_v4(), 'Sheets Brown Color Scrap',  2, true),
  (uuid_generate_v4(), 'Sheets Ivory Color Scrap',  3, true),
  (uuid_generate_v4(), 'Sheets NFC Color Scrap',    4, true),
  (uuid_generate_v4(), 'Sheets Orange Color Scrap', 5, true),
  (uuid_generate_v4(), 'Mix scrap',                 6, true)
ON CONFLICT (name) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════
-- LOOKUP / REFERENCE TABLES
-- ═══════════════════════════════════════════════════════════════

-- ══════════════════════════════════════
-- 12. FRAME WEIGHTS (section × density → weight per foot)
-- ══════════════════════════════════════
INSERT INTO public.master_frame_weight (id, section, density, weight_per_foot) VALUES
  -- 3x2
  (uuid_generate_v4(), '3x2', '0.75', 0.486),
  (uuid_generate_v4(), '3x2', '0.80', 0.519),
  (uuid_generate_v4(), '3x2', '0.90', 0.584),
  -- 4x2
  (uuid_generate_v4(), '4x2', '0.75', 0.647),
  (uuid_generate_v4(), '4x2', '0.80', 0.690),
  (uuid_generate_v4(), '4x2', '0.90', 0.777),
  -- 4x2.5
  (uuid_generate_v4(), '4x2.5', '0.75', 0.810),
  (uuid_generate_v4(), '4x2.5', '0.80', 0.864),
  (uuid_generate_v4(), '4x2.5', '0.90', 0.972),
  -- 5x2.5
  (uuid_generate_v4(), '5x2.5', '0.75', 1.012),
  (uuid_generate_v4(), '5x2.5', '0.80', 1.080),
  (uuid_generate_v4(), '5x2.5', '0.90', 1.215),
  -- 3x2 (HR)
  (uuid_generate_v4(), '3x2 (HR)', '0.75', 0.486),
  (uuid_generate_v4(), '3x2 (HR)', '0.80', 0.519),
  (uuid_generate_v4(), '3x2 (HR)', '0.90', 0.584),
  -- 4x2.5(HR)
  (uuid_generate_v4(), '4x2.5(HR)', '0.75', 0.810),
  (uuid_generate_v4(), '4x2.5(HR)', '0.80', 0.864),
  (uuid_generate_v4(), '4x2.5(HR)', '0.90', 0.972),
  -- Window Shutter
  (uuid_generate_v4(), 'Window Shutter', '0.75', 0.648),
  (uuid_generate_v4(), 'Window Shutter', '0.80', 0.691),
  (uuid_generate_v4(), 'Window Shutter', '0.90', 0.778);

-- ══════════════════════════════════════
-- 13. SHEET WEIGHTS (thickness × density → weight per sqft)
-- ══════════════════════════════════════
INSERT INTO public.master_sheet_weight (id, thickness, density, weight_per_sqft) VALUES
  -- 6mm
  (uuid_generate_v4(), '6mm', '0.45', 0.199),
  (uuid_generate_v4(), '6mm', '0.50', 0.221),
  (uuid_generate_v4(), '6mm', '0.55', 0.243),
  (uuid_generate_v4(), '6mm', '0.60', 0.265),
  (uuid_generate_v4(), '6mm', '0.65', 0.287),
  (uuid_generate_v4(), '6mm', '0.70', 0.309),
  (uuid_generate_v4(), '6mm', '0.80', 0.354),
  -- 7mm
  (uuid_generate_v4(), '7mm', '0.45', 0.232),
  (uuid_generate_v4(), '7mm', '0.50', 0.258),
  (uuid_generate_v4(), '7mm', '0.55', 0.284),
  (uuid_generate_v4(), '7mm', '0.60', 0.309),
  (uuid_generate_v4(), '7mm', '0.65', 0.335),
  (uuid_generate_v4(), '7mm', '0.70', 0.361),
  (uuid_generate_v4(), '7mm', '0.80', 0.413),
  -- 8mm
  (uuid_generate_v4(), '8mm', '0.45', 0.265),
  (uuid_generate_v4(), '8mm', '0.50', 0.295),
  (uuid_generate_v4(), '8mm', '0.55', 0.324),
  (uuid_generate_v4(), '8mm', '0.60', 0.354),
  (uuid_generate_v4(), '8mm', '0.65', 0.383),
  (uuid_generate_v4(), '8mm', '0.70', 0.413),
  (uuid_generate_v4(), '8mm', '0.80', 0.472),
  -- 9mm
  (uuid_generate_v4(), '9mm', '0.45', 0.298),
  (uuid_generate_v4(), '9mm', '0.50', 0.332),
  (uuid_generate_v4(), '9mm', '0.55', 0.365),
  (uuid_generate_v4(), '9mm', '0.60', 0.398),
  (uuid_generate_v4(), '9mm', '0.65', 0.431),
  (uuid_generate_v4(), '9mm', '0.70', 0.464),
  (uuid_generate_v4(), '9mm', '0.80', 0.531),
  -- 12mm
  (uuid_generate_v4(), '12mm', '0.45', 0.398),
  (uuid_generate_v4(), '12mm', '0.50', 0.442),
  (uuid_generate_v4(), '12mm', '0.55', 0.487),
  (uuid_generate_v4(), '12mm', '0.60', 0.531),
  (uuid_generate_v4(), '12mm', '0.65', 0.575),
  (uuid_generate_v4(), '12mm', '0.70', 0.619),
  (uuid_generate_v4(), '12mm', '0.80', 0.708),
  -- 13mm
  (uuid_generate_v4(), '13mm', '0.45', 0.431),
  (uuid_generate_v4(), '13mm', '0.50', 0.479),
  (uuid_generate_v4(), '13mm', '0.55', 0.527),
  (uuid_generate_v4(), '13mm', '0.60', 0.575),
  (uuid_generate_v4(), '13mm', '0.65', 0.623),
  (uuid_generate_v4(), '13mm', '0.70', 0.671),
  (uuid_generate_v4(), '13mm', '0.80', 0.767),
  -- 16mm
  (uuid_generate_v4(), '16mm', '0.45', 0.531),
  (uuid_generate_v4(), '16mm', '0.50', 0.590),
  (uuid_generate_v4(), '16mm', '0.55', 0.649),
  (uuid_generate_v4(), '16mm', '0.60', 0.708),
  (uuid_generate_v4(), '16mm', '0.65', 0.767),
  (uuid_generate_v4(), '16mm', '0.70', 0.826),
  (uuid_generate_v4(), '16mm', '0.80', 0.944),
  -- 17mm
  (uuid_generate_v4(), '17mm', '0.45', 0.564),
  (uuid_generate_v4(), '17mm', '0.50', 0.627),
  (uuid_generate_v4(), '17mm', '0.55', 0.689),
  (uuid_generate_v4(), '17mm', '0.60', 0.752),
  (uuid_generate_v4(), '17mm', '0.65', 0.815),
  (uuid_generate_v4(), '17mm', '0.70', 0.877),
  (uuid_generate_v4(), '17mm', '0.80', 1.003),
  -- 18mm
  (uuid_generate_v4(), '18mm', '0.45', 0.597),
  (uuid_generate_v4(), '18mm', '0.50', 0.663),
  (uuid_generate_v4(), '18mm', '0.55', 0.730),
  (uuid_generate_v4(), '18mm', '0.60', 0.796),
  (uuid_generate_v4(), '18mm', '0.65', 0.862),
  (uuid_generate_v4(), '18mm', '0.70', 0.929),
  (uuid_generate_v4(), '18mm', '0.80', 1.062),
  -- 19mm
  (uuid_generate_v4(), '19mm', '0.45', 0.630),
  (uuid_generate_v4(), '19mm', '0.50', 0.700),
  (uuid_generate_v4(), '19mm', '0.55', 0.770),
  (uuid_generate_v4(), '19mm', '0.60', 0.840),
  (uuid_generate_v4(), '19mm', '0.65', 0.910),
  (uuid_generate_v4(), '19mm', '0.70', 0.980),
  (uuid_generate_v4(), '19mm', '0.80', 1.121),
  -- 22mm
  (uuid_generate_v4(), '22mm', '0.45', 0.730),
  (uuid_generate_v4(), '22mm', '0.50', 0.811),
  (uuid_generate_v4(), '22mm', '0.55', 0.892),
  (uuid_generate_v4(), '22mm', '0.60', 0.973),
  (uuid_generate_v4(), '22mm', '0.65', 1.054),
  (uuid_generate_v4(), '22mm', '0.70', 1.135),
  (uuid_generate_v4(), '22mm', '0.80', 1.297),
  -- 25mm sheet
  (uuid_generate_v4(), '25mm sheet', '0.45', 0.829),
  (uuid_generate_v4(), '25mm sheet', '0.50', 0.921),
  (uuid_generate_v4(), '25mm sheet', '0.55', 1.013),
  (uuid_generate_v4(), '25mm sheet', '0.60', 1.106),
  (uuid_generate_v4(), '25mm sheet', '0.65', 1.198),
  (uuid_generate_v4(), '25mm sheet', '0.70', 1.290),
  (uuid_generate_v4(), '25mm sheet', '0.80', 1.475),
  -- 25mm Door
  (uuid_generate_v4(), '25mm Door', '0.45', 0.829),
  (uuid_generate_v4(), '25mm Door', '0.50', 0.921),
  (uuid_generate_v4(), '25mm Door', '0.55', 1.013),
  (uuid_generate_v4(), '25mm Door', '0.60', 1.106),
  (uuid_generate_v4(), '25mm Door', '0.65', 1.198),
  (uuid_generate_v4(), '25mm Door', '0.70', 1.290),
  (uuid_generate_v4(), '25mm Door', '0.80', 1.475),
  -- 26mm
  (uuid_generate_v4(), '26mm', '0.45', 0.862),
  (uuid_generate_v4(), '26mm', '0.50', 0.958),
  (uuid_generate_v4(), '26mm', '0.55', 1.054),
  (uuid_generate_v4(), '26mm', '0.60', 1.150),
  (uuid_generate_v4(), '26mm', '0.65', 1.246),
  (uuid_generate_v4(), '26mm', '0.70', 1.341),
  (uuid_generate_v4(), '26mm', '0.80', 1.534),
  -- 27mm
  (uuid_generate_v4(), '27mm', '0.45', 0.895),
  (uuid_generate_v4(), '27mm', '0.50', 0.995),
  (uuid_generate_v4(), '27mm', '0.55', 1.094),
  (uuid_generate_v4(), '27mm', '0.60', 1.194),
  (uuid_generate_v4(), '27mm', '0.65', 1.293),
  (uuid_generate_v4(), '27mm', '0.70', 1.393),
  (uuid_generate_v4(), '27mm', '0.80', 1.593),
  -- 28mm
  (uuid_generate_v4(), '28mm', '0.45', 0.929),
  (uuid_generate_v4(), '28mm', '0.50', 1.032),
  (uuid_generate_v4(), '28mm', '0.55', 1.135),
  (uuid_generate_v4(), '28mm', '0.60', 1.238),
  (uuid_generate_v4(), '28mm', '0.65', 1.341),
  (uuid_generate_v4(), '28mm', '0.70', 1.444),
  (uuid_generate_v4(), '28mm', '0.80', 1.652),
  -- 30mm
  (uuid_generate_v4(), '30mm', '0.45', 0.995),
  (uuid_generate_v4(), '30mm', '0.50', 1.106),
  (uuid_generate_v4(), '30mm', '0.55', 1.216),
  (uuid_generate_v4(), '30mm', '0.60', 1.327),
  (uuid_generate_v4(), '30mm', '0.65', 1.437),
  (uuid_generate_v4(), '30mm', '0.70', 1.548),
  (uuid_generate_v4(), '30mm', '0.80', 1.770),
  -- 31mm
  (uuid_generate_v4(), '31mm', '0.45', 1.028),
  (uuid_generate_v4(), '31mm', '0.50', 1.143),
  (uuid_generate_v4(), '31mm', '0.55', 1.257),
  (uuid_generate_v4(), '31mm', '0.60', 1.371),
  (uuid_generate_v4(), '31mm', '0.65', 1.485),
  (uuid_generate_v4(), '31mm', '0.70', 1.600),
  (uuid_generate_v4(), '31mm', '0.80', 1.829),
  -- 33mm
  (uuid_generate_v4(), '33mm', '0.45', 1.094),
  (uuid_generate_v4(), '33mm', '0.50', 1.216),
  (uuid_generate_v4(), '33mm', '0.55', 1.338),
  (uuid_generate_v4(), '33mm', '0.60', 1.460),
  (uuid_generate_v4(), '33mm', '0.65', 1.581),
  (uuid_generate_v4(), '33mm', '0.70', 1.703),
  (uuid_generate_v4(), '33mm', '0.80', 1.947),
  -- 35mm
  (uuid_generate_v4(), '35mm', '0.45', 1.161),
  (uuid_generate_v4(), '35mm', '0.50', 1.290),
  (uuid_generate_v4(), '35mm', '0.55', 1.419),
  (uuid_generate_v4(), '35mm', '0.60', 1.548),
  (uuid_generate_v4(), '35mm', '0.65', 1.677),
  (uuid_generate_v4(), '35mm', '0.70', 1.806),
  (uuid_generate_v4(), '35mm', '0.80', 2.065),
  -- 36mm
  (uuid_generate_v4(), '36mm', '0.45', 1.194),
  (uuid_generate_v4(), '36mm', '0.50', 1.327),
  (uuid_generate_v4(), '36mm', '0.55', 1.460),
  (uuid_generate_v4(), '36mm', '0.60', 1.593),
  (uuid_generate_v4(), '36mm', '0.65', 1.725),
  (uuid_generate_v4(), '36mm', '0.70', 1.858),
  (uuid_generate_v4(), '36mm', '0.80', 2.124);

-- ══════════════════════════════════════
-- 14. FRAME PRODUCTION TARGETS
-- ══════════════════════════════════════
INSERT INTO public.master_frame_target (id, section, target_kg_per_hour) VALUES
  (uuid_generate_v4(), '3x2',            80.0),
  (uuid_generate_v4(), '4x2',            100.0),
  (uuid_generate_v4(), '4x2.5',          120.0),
  (uuid_generate_v4(), '5x2.5',          140.0),
  (uuid_generate_v4(), '3x2 (HR)',       80.0),
  (uuid_generate_v4(), '4x2.5(HR)',      120.0),
  (uuid_generate_v4(), 'Window Shutter', 90.0)
ON CONFLICT (section) DO NOTHING;

-- ══════════════════════════════════════
-- 15. SHEET PRODUCTION TARGETS
-- ══════════════════════════════════════
INSERT INTO public.master_sheet_target (id, thickness, target_feet_per_hour) VALUES
  (uuid_generate_v4(), '6mm',        250.0),
  (uuid_generate_v4(), '7mm',        230.0),
  (uuid_generate_v4(), '8mm',        210.0),
  (uuid_generate_v4(), '9mm',        200.0),
  (uuid_generate_v4(), '12mm',       170.0),
  (uuid_generate_v4(), '13mm',       160.0),
  (uuid_generate_v4(), '16mm',       140.0),
  (uuid_generate_v4(), '17mm',       130.0),
  (uuid_generate_v4(), '18mm',       125.0),
  (uuid_generate_v4(), '19mm',       120.0),
  (uuid_generate_v4(), '22mm',       100.0),
  (uuid_generate_v4(), '25mm sheet', 85.0),
  (uuid_generate_v4(), '25mm Door',  85.0),
  (uuid_generate_v4(), '26mm',       80.0),
  (uuid_generate_v4(), '27mm',       78.0),
  (uuid_generate_v4(), '28mm',       75.0),
  (uuid_generate_v4(), '30mm',       70.0),
  (uuid_generate_v4(), '31mm',       68.0),
  (uuid_generate_v4(), '33mm',       60.0),
  (uuid_generate_v4(), '35mm',       55.0),
  (uuid_generate_v4(), '36mm',       52.0)
ON CONFLICT (thickness) DO NOTHING;

-- ══════════════════════════════════════
-- 16. SCRAP PRODUCTION TARGETS
-- ══════════════════════════════════════
INSERT INTO public.master_scrap_target (id, product, target_kg_per_hour) VALUES
  (uuid_generate_v4(), 'Frames Brown Color Scrap',  100.0),
  (uuid_generate_v4(), 'Sheets Brown Color Scrap',  100.0),
  (uuid_generate_v4(), 'Sheets Ivory Color Scrap',  100.0),
  (uuid_generate_v4(), 'Sheets NFC Color Scrap',    100.0),
  (uuid_generate_v4(), 'Sheets Orange Color Scrap', 100.0),
  (uuid_generate_v4(), 'Mix scrap',                 100.0)
ON CONFLICT (product) DO NOTHING;

-- ══════════════════════════════════════
-- 17. SALARY WEIGHTAGES (frame_sheet)
-- ══════════════════════════════════════
INSERT INTO public.master_salary_weightage (id, variable, label, category, percentage) VALUES
  (uuid_generate_v4(), 'wA', 'Machine Cleaning',      'frame_sheet', 15.0),
  (uuid_generate_v4(), 'wB', 'Tools Count',            'frame_sheet', 10.0),
  (uuid_generate_v4(), 'wC', 'Machine Health',          'frame_sheet', 25.0),
  (uuid_generate_v4(), 'wD', 'Production Efficiency',  'frame_sheet', 20.0),
  (uuid_generate_v4(), 'wE', 'Report Writing',          'frame_sheet', 20.0),
  (uuid_generate_v4(), 'wF', 'Quality / Packing',      'frame_sheet', 10.0);

-- ══════════════════════════════════════
-- 18. SALARY WEIGHTAGES (scrap)
-- ══════════════════════════════════════
INSERT INTO public.master_salary_weightage (id, variable, label, category, percentage) VALUES
  (uuid_generate_v4(), 'wA', 'Machine Cleaning %',          'scrap', 15.0),
  (uuid_generate_v4(), 'wB', 'Tools Count %',                'scrap', 10.0),
  (uuid_generate_v4(), 'wE', 'Production Efficiency %',      'scrap', 30.0),
  (uuid_generate_v4(), 'wF', 'Report Writing Efficiency %', 'scrap', 20.0),
  (uuid_generate_v4(), 'wG', 'Scrap Quality Rating %',      'scrap', 25.0);

-- ═══════════════════════════════════════════════════════════════
-- VERIFICATION: Count rows in each table
-- ═══════════════════════════════════════════════════════════════
SELECT 'master_machine'           AS table_name, count(*) AS rows FROM public.master_machine
UNION ALL SELECT 'master_shift',                  count(*) FROM public.master_shift
UNION ALL SELECT 'master_role',                   count(*) FROM public.master_role
UNION ALL SELECT 'master_frame_section',          count(*) FROM public.master_frame_section
UNION ALL SELECT 'master_frame_density',          count(*) FROM public.master_frame_density
UNION ALL SELECT 'master_frame_color',            count(*) FROM public.master_frame_color
UNION ALL SELECT 'master_sheet_thickness',        count(*) FROM public.master_sheet_thickness
UNION ALL SELECT 'master_sheet_density',          count(*) FROM public.master_sheet_density
UNION ALL SELECT 'master_sheet_color',            count(*) FROM public.master_sheet_color
UNION ALL SELECT 'master_maintenance_item',       count(*) FROM public.master_maintenance_item
UNION ALL SELECT 'master_scrap_product',          count(*) FROM public.master_scrap_product
UNION ALL SELECT 'master_frame_weight',           count(*) FROM public.master_frame_weight
UNION ALL SELECT 'master_sheet_weight',           count(*) FROM public.master_sheet_weight
UNION ALL SELECT 'master_frame_target',           count(*) FROM public.master_frame_target
UNION ALL SELECT 'master_sheet_target',           count(*) FROM public.master_sheet_target
UNION ALL SELECT 'master_scrap_target',           count(*) FROM public.master_scrap_target
UNION ALL SELECT 'master_salary_weightage',       count(*) FROM public.master_salary_weightage
ORDER BY table_name;
