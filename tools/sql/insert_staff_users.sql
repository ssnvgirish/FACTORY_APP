-- Insert plant staff users
-- Phone is stored as +91XXXXXXXXXX (login also accepts 10-digit numbers)
-- Default password matches other operators: 1234
-- Raghu: app has no scrap_senior_operator role; use machine_operator + all scrap machines

INSERT INTO "user" (uid, name, phone, password, email, roles, assigned_machines, fixed_salary, is_active)
VALUES
  (
    '+918512033299',
    'Shekar',
    '+918512033299',
    '1234',
    '',
    '["plant_manager"]'::jsonb,
    '[]'::jsonb,
    0,
    true
  ),
  (
    '+919540257569',
    'Sanjeev',
    '+919540257569',
    '1234',
    '',
    '["frames_senior_operator"]'::jsonb,
    '["Frame Machine 1", "Frame Machine 2"]'::jsonb,
    0,
    true
  ),
  (
    '+918105772479',
    'Raghu',
    '+918105772479',
    '1234',
    '',
    '["machine_operator"]'::jsonb,
    '["Crusher Machine 1", "Crusher Machine 2", "Crusher Machine 3", "Pulverizer Machine 1", "Pulverizer Machine 2", "Pulverizer Machine 3", "Shredder"]'::jsonb,
    0,
    true
  ),
  (
    '+919380564735',
    'Pavan',
    '+919380564735',
    '1234',
    '',
    '["quality_packing_supervisor"]'::jsonb,
    '["Frame Machine 1", "Frame Machine 2", "Sheet Machine 3", "Sheet Machine 4", "Sheet Machine 5"]'::jsonb,
    0,
    true
  )
ON CONFLICT (uid) DO NOTHING;

SELECT uid, name, phone, roles, assigned_machines, is_active
FROM "user"
WHERE uid IN ('+918512033299', '+919540257569', '+918105772479', '+919380564735');
