-- ═══════════════════════════════════════════════════════════════
-- Factory App — Full Schema (Cloud SQL / PostgreSQL)
-- Firebase DataConnect uses Cloud SQL under the hood.
-- Run against the fdcdb database as the firebaseowner role.
-- ═══════════════════════════════════════════════════════════════

SET ROLE "firebaseowner_fdcdb_public";

-- Enable uuid generation if not already available.
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ═══════════════════════════════════════
-- MASTER / DROPDOWN TABLES
-- ═══════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.master_machine (
    id          UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR NOT NULL UNIQUE,
    type        VARCHAR NOT NULL,          -- 'frame' | 'sheet' | 'scrap'
    sort_order  INTEGER NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS public.master_shift (
    id          UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR NOT NULL UNIQUE,
    sort_order  INTEGER NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS public.master_role (
    id           UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    code         VARCHAR NOT NULL UNIQUE,
    display_name VARCHAR NOT NULL,
    sort_order   INTEGER NOT NULL DEFAULT 0,
    is_active    BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS public.master_frame_section (
    id          UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR NOT NULL UNIQUE,
    sort_order  INTEGER NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS public.master_frame_density (
    id          UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    value       VARCHAR NOT NULL UNIQUE,
    sort_order  INTEGER NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS public.master_frame_color (
    id          UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR NOT NULL UNIQUE,
    sort_order  INTEGER NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS public.master_sheet_thickness (
    id          UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    value       VARCHAR NOT NULL UNIQUE,
    sort_order  INTEGER NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS public.master_sheet_density (
    id          UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    value       VARCHAR NOT NULL UNIQUE,
    sort_order  INTEGER NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS public.master_sheet_color (
    id          UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR NOT NULL UNIQUE,
    sort_order  INTEGER NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS public.master_maintenance_item (
    id          UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR NOT NULL UNIQUE,
    category    VARCHAR NOT NULL,          -- 'frame' | 'scrap'
    sort_order  INTEGER NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS public.master_scrap_product (
    id          UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR NOT NULL UNIQUE,
    sort_order  INTEGER NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

-- ═══════════════════════════════════════
-- REFERENCE / LOOKUP TABLES
-- (formerly stored as Firestore document flat-maps)
-- Each table replaces one Firestore document in the `referenceTables`
-- collection where data was stored as {"section|density": value} blobs.
-- ═══════════════════════════════════════

-- Frame Weight Table
-- Replaces Firestore doc referenceTables/frameWeights
-- Key: section × density → weight per foot (kg)
CREATE TABLE IF NOT EXISTS public.master_frame_weight (
    id              UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    section         VARCHAR NOT NULL,
    density         VARCHAR NOT NULL,
    weight_per_foot FLOAT   NOT NULL,
    CONSTRAINT uq_frame_weight UNIQUE (section, density)
);

-- Sheet Weight Table
-- Replaces Firestore doc referenceTables/sheetWeights
-- Key: thickness × density → weight per sqft (kg)
CREATE TABLE IF NOT EXISTS public.master_sheet_weight (
    id               UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    thickness        VARCHAR NOT NULL,
    density          VARCHAR NOT NULL,
    weight_per_sqft  FLOAT   NOT NULL,
    CONSTRAINT uq_sheet_weight UNIQUE (thickness, density)
);

-- Frame Production Target Table
-- Replaces Firestore doc referenceTables/frameTargets
-- Key: section × density → target kg per hour
CREATE TABLE IF NOT EXISTS public.master_frame_target (
    id                UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    section           VARCHAR NOT NULL,
    density           VARCHAR NOT NULL,
    target_kg_per_hour FLOAT  NOT NULL,
    CONSTRAINT uq_frame_target UNIQUE (section, density)
);

-- Sheet Production Target Table
-- Replaces Firestore doc referenceTables/sheetTargets
-- Key: thickness × density → target running feet per hour
CREATE TABLE IF NOT EXISTS public.master_sheet_target (
    id                    UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    thickness             VARCHAR NOT NULL,
    density               VARCHAR NOT NULL,
    target_feet_per_hour  FLOAT   NOT NULL,
    CONSTRAINT uq_sheet_target UNIQUE (thickness, density)
);

-- Scrap Production Target Table
-- Replaces Firestore doc referenceTables/scrapTargets
-- Key: product → target kg per hour
CREATE TABLE IF NOT EXISTS public.master_scrap_target (
    id                UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    product           VARCHAR NOT NULL UNIQUE,
    target_kg_per_hour FLOAT  NOT NULL
);

-- Salary Weightage Table
-- Replaces Firestore docs referenceTables/salaryWeightages and
-- referenceTables/scrapSalaryWeightages
-- Key: category × variable → percentage (all variables per category sum to 100)
CREATE TABLE IF NOT EXISTS public.master_salary_weightage (
    id          UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    variable    VARCHAR NOT NULL,        -- wA, wB, wC …
    label       VARCHAR NOT NULL,
    category    VARCHAR NOT NULL,        -- 'frame_sheet' | 'scrap'
    percentage  FLOAT   NOT NULL
);

-- ═══════════════════════════════════════
-- INDEXES
-- ═══════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_frame_weight_section   ON public.master_frame_weight  (section);
CREATE INDEX IF NOT EXISTS idx_frame_weight_density   ON public.master_frame_weight  (density);
CREATE INDEX IF NOT EXISTS idx_sheet_weight_thickness ON public.master_sheet_weight  (thickness);
CREATE INDEX IF NOT EXISTS idx_sheet_weight_density   ON public.master_sheet_weight  (density);
CREATE INDEX IF NOT EXISTS idx_frame_target_section   ON public.master_frame_target  (section);
CREATE INDEX IF NOT EXISTS idx_sheet_target_thickness ON public.master_sheet_target  (thickness);
CREATE INDEX IF NOT EXISTS idx_salary_category        ON public.master_salary_weightage (category);
