-- Seed data for factory_app database
-- Run with: firebase dataconnect:sql:shell < tools/seed_data.sql

BEGIN;

-- ═══════════════════════════════════════
-- Users
-- ═══════════════════════════════════════

INSERT INTO "user" (uid, name, phone, password, email, roles, assigned_machines, fixed_salary, is_active)
VALUES
  ('admin-1', 'Admin', '+910000000000', 'admin123', '', '["admin", "plant_manager"]'::jsonb, '[]'::jsonb, 0, true),
  ('op-1', 'Ravi Kumar', '+911111111111', '1234', '', '["machine_operator"]'::jsonb, '["Frame Machine 1"]'::jsonb, 18000, true),
  ('op-2', 'Suresh Yadav', '+912222222222', '1234', '', '["machine_operator"]'::jsonb, '["Frame Machine 2"]'::jsonb, 16000, true),
  ('op-3', 'Amit Sharma', '+913333333333', '1234', '', '["machine_operator"]'::jsonb, '["Sheet Machine 3"]'::jsonb, 17500, true),
  ('op-4', 'Deepak Verma', '+914444444444', '1234', '', '["machine_operator"]'::jsonb, '["Sheet Machine 4"]'::jsonb, 15500, true),
  ('qp-1', 'Vijay Patel', '+915555555555', '1234', '', '["quality_packing_supervisor"]'::jsonb, '["Frame Machine 1", "Frame Machine 2", "Sheet Machine 3", "Sheet Machine 4", "Sheet Machine 5"]'::jsonb, 20000, true)
ON CONFLICT (uid) DO NOTHING;

-- ═══════════════════════════════════════
-- Dropdown Configs
-- ═══════════════════════════════════════

INSERT INTO dropdown_config (category, "values")
VALUES
  ('frameMachines', '["Frame Machine 1", "Frame Machine 2"]'::jsonb),
  ('sheetMachines', '["Sheet Machine 3", "Sheet Machine 4", "Sheet Machine 5"]'::jsonb),
  ('shifts', '["Day Shift", "Night Shift"]'::jsonb),
  ('roles', '["machine_operator", "quality_packing_supervisor", "frames_senior_operator", "sheet_senior_operator", "plant_manager", "admin"]'::jsonb),
  ('frameSections', '["3x2", "4x2", "4x2.5", "5x2.5", "3x2 (HR)", "4x2.5(HR)", "Window Shutter"]'::jsonb),
  ('frameDensities', '["0.75", "0.80", "0.90", "Others"]'::jsonb),
  ('frameColors', '["Brown", "Ivory", "NFC Color"]'::jsonb),
  ('sheetThicknesses', '["6mm", "7mm", "8mm", "9mm", "12mm", "13mm", "16mm", "17mm", "18mm", "19mm", "22mm", "25mm sheet", "25mm Door", "26mm", "27mm", "28mm", "30mm", "31mm", "33mm", "35mm", "36mm"]'::jsonb),
  ('sheetDensities', '["0.45", "0.50", "0.55", "0.60", "0.65", "0.70", "0.80", "Others"]'::jsonb),
  ('sheetColors', '["Brown", "Ivory", "NFC Sanding", "NFC No Sanding", "White"]'::jsonb),
  ('maintenanceItems', '["Die Cleaning", "Die Change", "Generator Maintenance", "Air Compressor Maintenance", "Chiller Maintenance", "Mixer Maintenance", "Main Machine Maintenance", "UPS Maintenance", "Others"]'::jsonb),
  ('scrapMachines', '["Pulverizer 1", "Pulverizer 2", "Pulverizer 3"]'::jsonb),
  ('scrapProducts', '["Frame Regrind", "Sheet Regrind", "Mixed Regrind", "PVC Powder", "Fine Dust"]'::jsonb)
ON CONFLICT (category) DO NOTHING;

-- ═══════════════════════════════════════
-- Reference Tables
-- ═══════════════════════════════════════

INSERT INTO reference_table (table_type, data)
VALUES
  ('frameWeights', '{"3x2|0.75":0.486,"3x2|0.80":0.519,"3x2|0.90":0.584,"4x2|0.75":0.647,"4x2|0.80":0.690,"4x2|0.90":0.777,"4x2.5|0.75":0.810,"4x2.5|0.80":0.864,"4x2.5|0.90":0.972,"5x2.5|0.75":1.012,"5x2.5|0.80":1.080,"5x2.5|0.90":1.215,"3x2 (HR)|0.75":0.486,"3x2 (HR)|0.80":0.519,"3x2 (HR)|0.90":0.584,"4x2.5(HR)|0.75":0.810,"4x2.5(HR)|0.80":0.864,"4x2.5(HR)|0.90":0.972,"Window Shutter|0.75":0.648,"Window Shutter|0.80":0.691,"Window Shutter|0.90":0.778}'),
  ('salaryWeightages', '{"wA":15,"wB":10,"wC":25,"wD":20,"wE":20,"wF":10}'),
  ('scrapSalaryWeightages', '{"wA":20,"wB":15,"wE":25,"wF":15,"wG":25}')
ON CONFLICT (table_type) DO NOTHING;

-- ═══════════════════════════════════════
-- Frame Cleaning Reports
-- ═══════════════════════════════════════

INSERT INTO frame_cleaning_report (date, machine_number, machine_condition, ground_condition, mould_condition, total_score, percentage, created_by, "timestamp")
VALUES
  ('2025-07-14', 'Frame Machine 1', 7, 6, 8, 21, 70.0, 'op-1', NOW()),
  ('2025-07-11', 'Frame Machine 2', 8, 7, 9, 24, 80.0, 'op-2', NOW()),
  ('2025-07-08', 'Frame Machine 1', 9, 8, 10, 27, 90.0, 'op-1', NOW()),
  ('2025-07-05', 'Frame Machine 2', 10, 9, 8, 27, 90.0, 'op-2', NOW()),
  ('2025-07-02', 'Frame Machine 1', 8, 10, 9, 27, 90.0, 'op-1', NOW());

-- ═══════════════════════════════════════
-- Frame Tools Count Reports
-- ═══════════════════════════════════════

INSERT INTO frame_tools_count_report (date, machine_number, tools_condition, tools_availability, tools_organization, total_score, percentage, created_by, "timestamp")
VALUES
  ('2025-07-14', 'Frame Machine 1', 7, 8, 6, 21, 70.0, 'op-1', NOW()),
  ('2025-07-12', 'Frame Machine 2', 8, 9, 7, 24, 80.0, 'op-2', NOW()),
  ('2025-07-10', 'Frame Machine 1', 9, 10, 8, 27, 90.0, 'op-1', NOW()),
  ('2025-07-08', 'Frame Machine 2', 10, 8, 9, 27, 90.0, 'op-2', NOW());

-- ═══════════════════════════════════════
-- Frame Health Reports + Rating Items
-- ═══════════════════════════════════════

DO $$
DECLARE
  r1_id UUID;
  r2_id UUID;
  r3_id UUID;
BEGIN
  INSERT INTO frame_health_report (date, machine_number, shift, total_score, percentage, created_by, submitted_at, "timestamp")
  VALUES ('2025-07-14', 'Frame Machine 1', 'Day Shift', 42, 60.0, 'op-1', '2025-07-14T10:00:00Z', NOW())
  RETURNING id INTO r1_id;

  INSERT INTO frame_health_rating_item (report_id, item, rating) VALUES
    (r1_id, 'Die Cleaning', 7), (r1_id, 'Die Change', 6), (r1_id, 'Generator Maintenance', 5),
    (r1_id, 'Air Compressor Maintenance', 6), (r1_id, 'Chiller Maintenance', 5),
    (r1_id, 'Mixer Maintenance', 4), (r1_id, 'Main Machine Maintenance', 9);

  INSERT INTO frame_health_report (date, machine_number, shift, total_score, percentage, created_by, submitted_at, "timestamp")
  VALUES ('2025-07-12', 'Frame Machine 2', 'Night Shift', 49, 70.0, 'op-2', '2025-07-12T22:00:00Z', NOW())
  RETURNING id INTO r2_id;

  INSERT INTO frame_health_rating_item (report_id, item, rating) VALUES
    (r2_id, 'Die Cleaning', 8), (r2_id, 'Die Change', 7), (r2_id, 'Generator Maintenance', 6),
    (r2_id, 'Air Compressor Maintenance', 7), (r2_id, 'Chiller Maintenance', 7),
    (r2_id, 'Mixer Maintenance', 6), (r2_id, 'Main Machine Maintenance', 8);

  INSERT INTO frame_health_report (date, machine_number, shift, total_score, percentage, created_by, submitted_at, "timestamp")
  VALUES ('2025-07-10', 'Frame Machine 1', 'Day Shift', 56, 80.0, 'op-1', '2025-07-10T10:00:00Z', NOW())
  RETURNING id INTO r3_id;

  INSERT INTO frame_health_rating_item (report_id, item, rating) VALUES
    (r3_id, 'Die Cleaning', 9), (r3_id, 'Die Change', 8), (r3_id, 'Generator Maintenance', 7),
    (r3_id, 'Air Compressor Maintenance', 8), (r3_id, 'Chiller Maintenance', 8),
    (r3_id, 'Mixer Maintenance', 7), (r3_id, 'Main Machine Maintenance', 9);
END $$;

-- ═══════════════════════════════════════
-- Frame Production Weight Reports
-- ═══════════════════════════════════════

INSERT INTO frame_production_weight_report (date, machine_number, shift, production_weight, maintenance_weight, total_production_weight, target_weight, efficiency_percentage, created_by, "timestamp")
VALUES
  ('2025-07-14', 'Frame Machine 1', 'Day Shift', 480.0, 200.0, 680.0, 1200.0, 56.67, 'op-1', NOW()),
  ('2025-07-11', 'Frame Machine 2', 'Night Shift', 530.0, 230.0, 760.0, 1200.0, 63.33, 'op-2', NOW()),
  ('2025-07-08', 'Frame Machine 1', 'Day Shift', 580.0, 260.0, 840.0, 1200.0, 70.0, 'op-1', NOW()),
  ('2025-07-05', 'Frame Machine 2', 'Night Shift', 630.0, 290.0, 920.0, 1200.0, 76.67, 'op-2', NOW());

-- ═══════════════════════════════════════
-- Frame Writing Efficiency
-- ═══════════════════════════════════════

INSERT INTO frame_writing_efficiency (date, machine_number, shift, submitted_at, shift_end_time, score, operator_id, "timestamp")
VALUES
  ('2025-07-14', 'Frame Machine 1', 'Day Shift', '2025-07-14T17:30:00Z', '2025-07-14T18:00:00Z', 5, 'op-1', NOW()),
  ('2025-07-13', 'Frame Machine 2', 'Night Shift', '2025-07-14T05:30:00Z', '2025-07-14T06:00:00Z', 4, 'op-2', NOW()),
  ('2025-07-12', 'Frame Machine 1', 'Day Shift', '2025-07-12T18:10:00Z', '2025-07-12T18:00:00Z', 3, 'op-1', NOW());

-- ═══════════════════════════════════════
-- Sheet Cleaning Reports
-- ═══════════════════════════════════════

INSERT INTO sheet_cleaning_report (date, machine_number, machine_condition, ground_condition, mould_condition, total_score, percentage, created_by, "timestamp")
VALUES
  ('2025-07-14', 'Sheet Machine 3', 8, 7, 9, 24, 80.0, 'op-3', NOW()),
  ('2025-07-12', 'Sheet Machine 4', 9, 8, 10, 27, 90.0, 'op-4', NOW()),
  ('2025-07-10', 'Sheet Machine 5', 10, 9, 9, 28, 93.33, 'op-3', NOW()),
  ('2025-07-08', 'Sheet Machine 3', 9, 10, 10, 29, 96.67, 'op-4', NOW()),
  ('2025-07-06', 'Sheet Machine 4', 10, 10, 9, 29, 96.67, 'op-3', NOW());

-- ═══════════════════════════════════════
-- Sheet Running Feet Reports
-- ═══════════════════════════════════════

INSERT INTO sheet_running_feet_report (date, machine_number, shift, production_running_feet, maintenance_running_feet, total_production_running_feet, target_running_feet, efficiency_percentage, created_by, "timestamp")
VALUES
  ('2025-07-14', 'Sheet Machine 3', 'Day Shift', 520.0, 160.0, 680.0, 1000.0, 68.0, 'op-3', NOW()),
  ('2025-07-12', 'Sheet Machine 4', 'Night Shift', 580.0, 140.0, 720.0, 1000.0, 72.0, 'op-4', NOW()),
  ('2025-07-10', 'Sheet Machine 3', 'Day Shift', 640.0, 180.0, 820.0, 1000.0, 82.0, 'op-3', NOW());

-- ═══════════════════════════════════════
-- Sheet Writing Efficiency
-- ═══════════════════════════════════════

INSERT INTO sheet_writing_efficiency (date, machine_number, shift, submitted_at, shift_end_time, score, operator_id, "timestamp")
VALUES
  ('2025-07-14', 'Sheet Machine 3', 'Day Shift', '2025-07-14T17:45:00Z', '2025-07-14T18:00:00Z', 5, 'op-3', NOW()),
  ('2025-07-13', 'Sheet Machine 4', 'Night Shift', '2025-07-14T05:50:00Z', '2025-07-14T06:00:00Z', 4, 'op-4', NOW());

-- ═══════════════════════════════════════
-- Salary Calculations (July 2025)
-- ═══════════════════════════════════════

INSERT INTO salary_calculation (operator_id, operator_name, year, month, a, b, c, d, e, f, w_a, w_b, w_c, w_d, w_e, w_f, multiplier, fixed_salary, calculated_salary, "timestamp")
VALUES
  ('op-1', 'Ravi Kumar', 2025, 7, 82.0, 75.0, 70.0, 88.0, 78.0, 65.0, 15, 10, 25, 20, 20, 10, 76.4, 18000, 13752.0, NOW()),
  ('op-2', 'Suresh Yadav', 2025, 7, 85.5, 79.0, 75.0, 86.0, 81.0, 71.0, 15, 10, 25, 20, 20, 10, 80.025, 16000, 12804.0, NOW()),
  ('op-3', 'Amit Sharma', 2025, 7, 89.0, 83.0, 80.0, 84.0, 84.0, 77.0, 15, 10, 25, 20, 20, 10, 83.35, 17500, 14586.25, NOW()),
  ('op-4', 'Deepak Verma', 2025, 7, 92.5, 87.0, 85.0, 82.0, 87.0, 83.0, 15, 10, 25, 20, 20, 10, 86.475, 15500, 13403.625, NOW());

-- ═══════════════════════════════════════
-- Scrap/Regrind Operators (add to users if not exists)
-- ═══════════════════════════════════════

INSERT INTO "user" (uid, name, phone, password, email, roles, assigned_machines, fixed_salary, is_active)
VALUES
  ('op-5', 'Rajesh Singh', '+916666666666', '1234', '', '["machine_operator"]'::jsonb, '["Pulverizer 1"]'::jsonb, 15000, true),
  ('op-6', 'Manoj Tiwari', '+917777777777', '1234', '', '["machine_operator"]'::jsonb, '["Pulverizer 2"]'::jsonb, 14500, true)
ON CONFLICT (uid) DO NOTHING;

-- ═══════════════════════════════════════
-- Scrap Cleaning Reports
-- ═══════════════════════════════════════

INSERT INTO scrap_cleaning_report (date, machine_number, machine_condition, ground_condition, total_score, percentage, created_by, "timestamp")
VALUES
  ('2025-07-14', 'Pulverizer 1', 8, 7, 15, 75.0, 'op-5', NOW()),
  ('2025-07-12', 'Pulverizer 2', 9, 8, 17, 85.0, 'op-6', NOW()),
  ('2025-07-10', 'Pulverizer 1', 7, 9, 16, 80.0, 'op-5', NOW()),
  ('2025-07-08', 'Pulverizer 3', 10, 9, 19, 95.0, 'op-6', NOW()),
  ('2025-07-06', 'Pulverizer 2', 8, 8, 16, 80.0, 'op-5', NOW());

-- ═══════════════════════════════════════
-- Scrap Tools Count Reports
-- ═══════════════════════════════════════

INSERT INTO scrap_tools_count_report (date, machine_number, total_tools_given, total_tools_available, percentage_available, created_by, "timestamp")
VALUES
  ('2025-07-14', 'Pulverizer 1', 20, 18, 90.0, 'op-5', NOW()),
  ('2025-07-12', 'Pulverizer 2', 25, 22, 88.0, 'op-6', NOW()),
  ('2025-07-10', 'Pulverizer 1', 20, 19, 95.0, 'op-5', NOW()),
  ('2025-07-08', 'Pulverizer 3', 22, 20, 90.91, 'op-6', NOW());

-- ═══════════════════════════════════════
-- Scrap Machine Health Reports + Maintenance Entries
-- ═══════════════════════════════════════

DO $$
DECLARE
  sr1_id UUID;
  sr2_id UUID;
  sr3_id UUID;
BEGIN
  INSERT INTO scrap_machine_health_report (date, machine_number, shift, total_maintenance_duration_hours, created_by, submitted_at, "timestamp")
  VALUES ('2025-07-14', 'Pulverizer 1', 'Day Shift', 2.5, 'op-5', '2025-07-14T10:00:00Z', NOW())
  RETURNING id INTO sr1_id;

  INSERT INTO scrap_maintenance_entry (report_id, maintenance_item, start_time, end_time, person_doing_maintenance, description, duration_hours) VALUES
    (sr1_id, 'Blade Sharpening', '2025-07-14T08:00:00Z', '2025-07-14T09:30:00Z', 'Rajesh Singh', 'Sharpened all blades', 1.5),
    (sr1_id, 'Screen Replacement', '2025-07-14T10:00:00Z', '2025-07-14T11:00:00Z', 'Rajesh Singh', 'Replaced worn screen', 1.0);

  INSERT INTO scrap_machine_health_report (date, machine_number, shift, total_maintenance_duration_hours, created_by, submitted_at, "timestamp")
  VALUES ('2025-07-12', 'Pulverizer 2', 'Night Shift', 1.75, 'op-6', '2025-07-12T22:00:00Z', NOW())
  RETURNING id INTO sr2_id;

  INSERT INTO scrap_maintenance_entry (report_id, maintenance_item, start_time, end_time, person_doing_maintenance, description, duration_hours) VALUES
    (sr2_id, 'Motor Belt Check', '2025-07-12T20:00:00Z', '2025-07-12T20:45:00Z', 'Manoj Tiwari', 'Checked and tightened belt', 0.75),
    (sr2_id, 'Hopper Cleaning', '2025-07-12T21:00:00Z', '2025-07-12T22:00:00Z', 'Manoj Tiwari', 'Deep cleaned hopper', 1.0);

  INSERT INTO scrap_machine_health_report (date, machine_number, shift, total_maintenance_duration_hours, created_by, submitted_at, "timestamp")
  VALUES ('2025-07-10', 'Pulverizer 1', 'Day Shift', 3.0, 'op-5', '2025-07-10T10:00:00Z', NOW())
  RETURNING id INTO sr3_id;

  INSERT INTO scrap_maintenance_entry (report_id, maintenance_item, start_time, end_time, person_doing_maintenance, description, duration_hours) VALUES
    (sr3_id, 'Blade Replacement', '2025-07-10T08:00:00Z', '2025-07-10T10:00:00Z', 'Rajesh Singh', 'Full blade set replacement', 2.0),
    (sr3_id, 'Bearing Lubrication', '2025-07-10T10:30:00Z', '2025-07-10T11:30:00Z', 'Rajesh Singh', 'Lubricated all bearings', 1.0);
END $$;

-- ═══════════════════════════════════════
-- Scrap Production Details Reports + Line Items
-- ═══════════════════════════════════════

DO $$
DECLARE
  sp1_id UUID;
  sp2_id UUID;
  sp3_id UUID;
BEGIN
  INSERT INTO scrap_production_details_report (date, machine_number, shift, total_production_weight, created_by, submitted_at, "timestamp")
  VALUES ('2025-07-14', 'Pulverizer 1', 'Day Shift', 450.0, 'op-5', '2025-07-14T17:00:00Z', NOW())
  RETURNING id INTO sp1_id;

  INSERT INTO scrap_production_line_item (report_id, product, weight_per_bag, total_bags, total_weight) VALUES
    (sp1_id, 'Frame Regrind', 25.0, 10, 250.0),
    (sp1_id, 'Sheet Regrind', 25.0, 8, 200.0);

  INSERT INTO scrap_production_details_report (date, machine_number, shift, total_production_weight, created_by, submitted_at, "timestamp")
  VALUES ('2025-07-12', 'Pulverizer 2', 'Night Shift', 525.0, 'op-6', '2025-07-13T05:00:00Z', NOW())
  RETURNING id INTO sp2_id;

  INSERT INTO scrap_production_line_item (report_id, product, weight_per_bag, total_bags, total_weight) VALUES
    (sp2_id, 'Mixed Regrind', 30.0, 12, 360.0),
    (sp2_id, 'PVC Powder', 25.0, 5, 125.0),
    (sp2_id, 'Fine Dust', 20.0, 2, 40.0);

  INSERT INTO scrap_production_details_report (date, machine_number, shift, total_production_weight, created_by, submitted_at, "timestamp")
  VALUES ('2025-07-10', 'Pulverizer 1', 'Day Shift', 380.0, 'op-5', '2025-07-10T17:00:00Z', NOW())
  RETURNING id INTO sp3_id;

  INSERT INTO scrap_production_line_item (report_id, product, weight_per_bag, total_bags, total_weight) VALUES
    (sp3_id, 'Frame Regrind', 25.0, 8, 200.0),
    (sp3_id, 'Sheet Regrind', 30.0, 6, 180.0);
END $$;

-- ═══════════════════════════════════════
-- Scrap Production Weight Reports
-- ═══════════════════════════════════════

INSERT INTO scrap_production_weight_report (date, machine_number, shift, total_production_weight, maintenance_weight, total_weight, target_weight, efficiency_percentage, created_by, "timestamp")
VALUES
  ('2025-07-14', 'Pulverizer 1', 'Day Shift', 450.0, 125.0, 575.0, 800.0, 71.88, 'op-5', NOW()),
  ('2025-07-12', 'Pulverizer 2', 'Night Shift', 525.0, 87.5, 612.5, 800.0, 76.56, 'op-6', NOW()),
  ('2025-07-10', 'Pulverizer 1', 'Day Shift', 380.0, 150.0, 530.0, 800.0, 66.25, 'op-5', NOW()),
  ('2025-07-08', 'Pulverizer 3', 'Night Shift', 600.0, 100.0, 700.0, 800.0, 87.5, 'op-6', NOW());

-- ═══════════════════════════════════════
-- Scrap Writing Efficiency
-- ═══════════════════════════════════════

INSERT INTO scrap_writing_efficiency (date, machine_number, shift, submitted_at, shift_end_time, score, operator_id, "timestamp")
VALUES
  ('2025-07-14', 'Pulverizer 1', 'Day Shift', '2025-07-14T17:30:00Z', '2025-07-14T18:00:00Z', 5, 'op-5', NOW()),
  ('2025-07-12', 'Pulverizer 2', 'Night Shift', '2025-07-13T05:45:00Z', '2025-07-13T06:00:00Z', 4, 'op-6', NOW()),
  ('2025-07-10', 'Pulverizer 1', 'Day Shift', '2025-07-10T18:15:00Z', '2025-07-10T18:00:00Z', 3, 'op-5', NOW());

-- ═══════════════════════════════════════
-- Scrap Quality Reports
-- ═══════════════════════════════════════

INSERT INTO scrap_quality_report (date, machine_number, shift, product, quality_rating, created_by, "timestamp")
VALUES
  ('2025-07-14', 'Frame Machine 1', 'Day Shift', 'Frame Regrind', 8, 'op-5', NOW()),
  ('2025-07-14', 'Sheet Machine 3', 'Day Shift', 'Sheet Regrind', 7, 'op-5', NOW()),
  ('2025-07-12', 'Frame Machine 2', 'Night Shift', 'Mixed Regrind', 6, 'op-6', NOW()),
  ('2025-07-10', 'Sheet Machine 4', 'Day Shift', 'PVC Powder', 9, 'op-6', NOW()),
  ('2025-07-08', 'Frame Machine 1', 'Night Shift', 'Frame Regrind', 7, 'op-5', NOW());

-- ═══════════════════════════════════════
-- Scrap Salary Calculations (July 2025)
-- ═══════════════════════════════════════

INSERT INTO scrap_salary_calculation (operator_id, operator_name, year, month, a, b, e, f, g, w_a, w_b, w_e, w_f, w_g, multiplier, fixed_salary, calculated_salary, "timestamp")
VALUES
  ('op-5', 'Rajesh Singh', 2025, 7, 78.33, 91.67, 71.88, 80.0, 75.0, 20, 15, 25, 15, 25, 78.53, 15000, 11779.5, NOW()),
  ('op-6', 'Manoj Tiwari', 2025, 7, 87.5, 89.45, 82.03, 80.0, 73.33, 20, 15, 25, 15, 25, 81.85, 14500, 11868.25, NOW());

COMMIT;
