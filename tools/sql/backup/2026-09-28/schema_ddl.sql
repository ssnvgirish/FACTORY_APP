-- Auto-generated PostgreSQL DDL from dataconnect/schema/schema.gql
-- Generated on: 2026-05-16T13:05:49.186051

CREATE TABLE user (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    uid TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    phone TEXT NOT NULL,
    password TEXT NOT NULL,
    email TEXT NOT NULL,
    roles JSONB NOT NULL,
    assigned_machines JSONB NOT NULL,
    fixed_salary DOUBLE PRECISION NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE dropdown_config (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    category TEXT NOT NULL UNIQUE,
    values JSONB NOT NULL
);

CREATE TABLE reference_table (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    table_type TEXT NOT NULL UNIQUE,
    data TEXT NOT NULL
);

CREATE TABLE frame_cleaning_report (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date DATE NOT NULL,
    machine_number TEXT NOT NULL,
    machine_condition INTEGER NOT NULL,
    ground_condition INTEGER NOT NULL,
    mould_condition INTEGER NOT NULL,
    total_score INTEGER NOT NULL,
    percentage DOUBLE PRECISION NOT NULL,
    created_by TEXT NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE frame_tools_count_report (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date DATE NOT NULL,
    machine_number TEXT NOT NULL,
    tools_condition INTEGER NOT NULL,
    tools_availability INTEGER NOT NULL,
    tools_organization INTEGER NOT NULL,
    total_score INTEGER NOT NULL,
    percentage DOUBLE PRECISION NOT NULL,
    created_by TEXT NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE frame_health_rating_item (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    report UUID NOT NULL REFERENCES frame_health_report(id),
    item TEXT NOT NULL,
    rating INTEGER NOT NULL
);

CREATE TABLE frame_health_report (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date DATE NOT NULL,
    machine_number TEXT NOT NULL,
    shift TEXT NOT NULL,
    total_score INTEGER NOT NULL,
    percentage DOUBLE PRECISION NOT NULL,
    created_by TEXT NOT NULL,
    submitted_at TIMESTAMPTZ,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE frame_production_line_item (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    report UUID NOT NULL REFERENCES frame_production_details_report(id),
    section TEXT NOT NULL,
    density TEXT NOT NULL,
    color TEXT NOT NULL,
    length DOUBLE PRECISION NOT NULL,
    quantity INTEGER NOT NULL,
    per_piece_weight DOUBLE PRECISION NOT NULL,
    total_weight DOUBLE PRECISION NOT NULL,
    manual_weight_per_foot DOUBLE PRECISION
);

CREATE TABLE frame_production_details_report (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date DATE NOT NULL,
    machine_number TEXT NOT NULL,
    shift TEXT NOT NULL,
    total_quantity INTEGER NOT NULL,
    total_weight DOUBLE PRECISION NOT NULL,
    created_by TEXT NOT NULL,
    submitted_at TIMESTAMPTZ,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE frame_production_weight_report (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date DATE NOT NULL,
    machine_number TEXT NOT NULL,
    shift TEXT NOT NULL,
    production_weight DOUBLE PRECISION NOT NULL,
    maintenance_weight DOUBLE PRECISION NOT NULL,
    total_production_weight DOUBLE PRECISION NOT NULL,
    target_weight DOUBLE PRECISION NOT NULL,
    efficiency_percentage DOUBLE PRECISION NOT NULL,
    created_by TEXT NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE frame_packing_line_item (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    report UUID NOT NULL REFERENCES frame_shift_packing_report(id),
    section TEXT NOT NULL,
    density TEXT NOT NULL,
    color TEXT NOT NULL,
    length DOUBLE PRECISION NOT NULL,
    production_quantity INTEGER NOT NULL,
    per_piece_weight DOUBLE PRECISION NOT NULL,
    packed INTEGER NOT NULL,
    rejected_quality INTEGER NOT NULL
);

CREATE TABLE frame_shift_packing_report (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date DATE NOT NULL,
    machine_number TEXT NOT NULL,
    shift TEXT NOT NULL,
    total_rejected_weight DOUBLE PRECISION NOT NULL,
    quality_acceptance_percentage DOUBLE PRECISION NOT NULL,
    packing_efficiency DOUBLE PRECISION NOT NULL,
    created_by TEXT NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE frame_writing_efficiency (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date DATE NOT NULL,
    machine_number TEXT NOT NULL,
    shift TEXT NOT NULL,
    submitted_at TIMESTAMPTZ,
    shift_end_time TIMESTAMPTZ NOT NULL,
    score INTEGER NOT NULL,
    operator_id TEXT NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE frame_customer_rejection_item (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    report UUID NOT NULL REFERENCES frame_customer_rejection_report(id),
    section TEXT NOT NULL,
    density TEXT NOT NULL,
    color TEXT NOT NULL,
    length DOUBLE PRECISION NOT NULL,
    quantity INTEGER NOT NULL,
    per_piece_weight DOUBLE PRECISION NOT NULL,
    total_weight DOUBLE PRECISION NOT NULL
);

CREATE TABLE frame_customer_rejection_report (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    original_production_date DATE NOT NULL,
    machine_number TEXT NOT NULL,
    shift TEXT NOT NULL,
    total_rejected_weight DOUBLE PRECISION NOT NULL,
    created_by TEXT NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE sheet_cleaning_report (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date DATE NOT NULL,
    machine_number TEXT NOT NULL,
    machine_condition INTEGER NOT NULL,
    ground_condition INTEGER NOT NULL,
    mould_condition INTEGER NOT NULL,
    total_score INTEGER NOT NULL,
    percentage DOUBLE PRECISION NOT NULL,
    created_by TEXT NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE sheet_tools_count_report (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date DATE NOT NULL,
    machine_number TEXT NOT NULL,
    tools_condition INTEGER NOT NULL,
    tools_availability INTEGER NOT NULL,
    tools_organization INTEGER NOT NULL,
    total_score INTEGER NOT NULL,
    percentage DOUBLE PRECISION NOT NULL,
    created_by TEXT NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE sheet_health_rating_item (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    report UUID NOT NULL REFERENCES sheet_health_report(id),
    item TEXT NOT NULL,
    rating INTEGER NOT NULL
);

CREATE TABLE sheet_health_report (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date DATE NOT NULL,
    machine_number TEXT NOT NULL,
    shift TEXT NOT NULL,
    total_score INTEGER NOT NULL,
    percentage DOUBLE PRECISION NOT NULL,
    created_by TEXT NOT NULL,
    submitted_at TIMESTAMPTZ,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE sheet_production_line_item (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    report UUID NOT NULL REFERENCES sheet_production_details_report(id),
    thickness TEXT NOT NULL,
    density TEXT NOT NULL,
    color TEXT NOT NULL,
    length DOUBLE PRECISION NOT NULL,
    width DOUBLE PRECISION NOT NULL,
    quantity INTEGER NOT NULL,
    sqft DOUBLE PRECISION NOT NULL,
    per_piece_weight DOUBLE PRECISION NOT NULL,
    total_weight DOUBLE PRECISION NOT NULL,
    total_running_feet DOUBLE PRECISION NOT NULL,
    time_of_change TIMESTAMPTZ,
    manual_weight_per_sqft DOUBLE PRECISION
);

CREATE TABLE sheet_production_details_report (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date DATE NOT NULL,
    machine_number TEXT NOT NULL,
    shift TEXT NOT NULL,
    total_quantity INTEGER NOT NULL,
    total_weight DOUBLE PRECISION NOT NULL,
    total_running_feet DOUBLE PRECISION NOT NULL,
    created_by TEXT NOT NULL,
    submitted_at TIMESTAMPTZ,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE sheet_running_feet_report (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date DATE NOT NULL,
    machine_number TEXT NOT NULL,
    shift TEXT NOT NULL,
    production_running_feet DOUBLE PRECISION NOT NULL,
    maintenance_running_feet DOUBLE PRECISION NOT NULL,
    total_production_running_feet DOUBLE PRECISION NOT NULL,
    target_running_feet DOUBLE PRECISION NOT NULL,
    efficiency_percentage DOUBLE PRECISION NOT NULL,
    created_by TEXT NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE sheet_packing_line_item (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    report UUID NOT NULL REFERENCES sheet_shift_packing_report(id),
    thickness TEXT NOT NULL,
    density TEXT NOT NULL,
    color TEXT NOT NULL,
    length DOUBLE PRECISION NOT NULL,
    width DOUBLE PRECISION NOT NULL,
    production_quantity INTEGER NOT NULL,
    per_piece_weight DOUBLE PRECISION NOT NULL,
    running_feet_per_item DOUBLE PRECISION NOT NULL,
    packed INTEGER NOT NULL,
    only_sanding INTEGER NOT NULL,
    sanding_and_packed INTEGER NOT NULL,
    rejected_quality INTEGER NOT NULL
);

CREATE TABLE sheet_shift_packing_report (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date DATE NOT NULL,
    machine_number TEXT NOT NULL,
    shift TEXT NOT NULL,
    total_rejected_running_feet DOUBLE PRECISION NOT NULL,
    quality_acceptance_percentage DOUBLE PRECISION NOT NULL,
    packing_efficiency DOUBLE PRECISION NOT NULL,
    created_by TEXT NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE sheet_writing_efficiency (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date DATE NOT NULL,
    machine_number TEXT NOT NULL,
    shift TEXT NOT NULL,
    submitted_at TIMESTAMPTZ,
    shift_end_time TIMESTAMPTZ NOT NULL,
    score INTEGER NOT NULL,
    operator_id TEXT NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE sheet_customer_rejection_item (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    report UUID NOT NULL REFERENCES sheet_customer_rejection_report(id),
    thickness TEXT NOT NULL,
    density TEXT NOT NULL,
    color TEXT NOT NULL,
    length DOUBLE PRECISION NOT NULL,
    width DOUBLE PRECISION NOT NULL,
    quantity INTEGER NOT NULL,
    sqft DOUBLE PRECISION NOT NULL,
    per_piece_weight DOUBLE PRECISION NOT NULL,
    total_weight DOUBLE PRECISION NOT NULL,
    total_running_feet DOUBLE PRECISION NOT NULL
);

CREATE TABLE sheet_customer_rejection_report (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    original_production_date DATE NOT NULL,
    machine_number TEXT NOT NULL,
    shift TEXT NOT NULL,
    total_rejected_running_feet DOUBLE PRECISION NOT NULL,
    created_by TEXT NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE salary_calculation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    operator_id TEXT NOT NULL,
    operator_name TEXT NOT NULL,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    a DOUBLE PRECISION NOT NULL,
    b DOUBLE PRECISION NOT NULL,
    c DOUBLE PRECISION NOT NULL,
    d DOUBLE PRECISION NOT NULL,
    e DOUBLE PRECISION NOT NULL,
    f DOUBLE PRECISION NOT NULL,
    w_a DOUBLE PRECISION NOT NULL,
    w_b DOUBLE PRECISION NOT NULL,
    w_c DOUBLE PRECISION NOT NULL,
    w_d DOUBLE PRECISION NOT NULL,
    w_e DOUBLE PRECISION NOT NULL,
    w_f DOUBLE PRECISION NOT NULL,
    multiplier DOUBLE PRECISION NOT NULL,
    fixed_salary DOUBLE PRECISION NOT NULL,
    calculated_salary DOUBLE PRECISION NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);

-- ═══════════════════════════════════════
-- Indexes
-- ═══════════════════════════════════════

CREATE INDEX idx_frame_cleaning_report_date_machine ON frame_cleaning_report(date, machine_number);
CREATE INDEX idx_frame_tools_count_report_date_machine ON frame_tools_count_report(date, machine_number);
CREATE INDEX idx_frame_health_report_date_machine ON frame_health_report(date, machine_number);
CREATE INDEX idx_frame_production_details_report_date_machine ON frame_production_details_report(date, machine_number);
CREATE INDEX idx_frame_production_weight_report_date_machine ON frame_production_weight_report(date, machine_number);
CREATE INDEX idx_frame_shift_packing_report_date_machine ON frame_shift_packing_report(date, machine_number);
CREATE INDEX idx_frame_writing_efficiency_date_machine ON frame_writing_efficiency(date, machine_number);
CREATE INDEX idx_frame_writing_efficiency_operator ON frame_writing_efficiency(operator_id);
CREATE INDEX idx_sheet_cleaning_report_date_machine ON sheet_cleaning_report(date, machine_number);
CREATE INDEX idx_sheet_tools_count_report_date_machine ON sheet_tools_count_report(date, machine_number);
CREATE INDEX idx_sheet_health_report_date_machine ON sheet_health_report(date, machine_number);
CREATE INDEX idx_sheet_production_details_report_date_machine ON sheet_production_details_report(date, machine_number);
CREATE INDEX idx_sheet_running_feet_report_date_machine ON sheet_running_feet_report(date, machine_number);
CREATE INDEX idx_sheet_shift_packing_report_date_machine ON sheet_shift_packing_report(date, machine_number);
CREATE INDEX idx_sheet_writing_efficiency_date_machine ON sheet_writing_efficiency(date, machine_number);
CREATE INDEX idx_sheet_writing_efficiency_operator ON sheet_writing_efficiency(operator_id);
CREATE INDEX idx_salary_calculation_operator ON salary_calculation(operator_id);
