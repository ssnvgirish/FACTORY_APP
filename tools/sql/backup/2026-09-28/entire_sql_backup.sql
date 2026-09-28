-- PP Production Tracking — full SQL backup
-- Taken: 2026-09-28
-- This file joins every SQL script in the project. Run pieces separately; do not execute this file as one script.


-- ═══════════════════════════════════════════════════════════════
-- SOURCE: tools/sql/00_complete_setup.sql
-- ═══════════════════════════════════════════════════════════════

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

-- Drop reference tables if they exist to ensure clean schema
DROP TABLE IF EXISTS public.master_salary_weightage;
DROP TABLE IF EXISTS public.master_scrap_target;
DROP TABLE IF EXISTS public.master_sheet_target;
DROP TABLE IF EXISTS public.master_frame_target;
DROP TABLE IF EXISTS public.master_sheet_weight;
DROP TABLE IF EXISTS public.master_frame_weight;

-- Frame Weight Table
-- Replaces Firestore doc referenceTables/frameWeights
-- Key: section × density → weight per foot (kg)
CREATE TABLE public.master_frame_weight (
    id              UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    section         VARCHAR NOT NULL,
    density         VARCHAR NOT NULL,
    weight_per_foot FLOAT   NOT NULL,
    CONSTRAINT fk_frame_weight_section FOREIGN KEY (section)
        REFERENCES public.master_frame_section(name)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_frame_weight_density FOREIGN KEY (density)
        REFERENCES public.master_frame_density(value)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT uq_frame_weight UNIQUE (section, density)
);

-- Sheet Weight Table
-- Replaces Firestore doc referenceTables/sheetWeights
-- Key: thickness × density → weight per sqft (kg)
CREATE TABLE public.master_sheet_weight (
    id               UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    thickness        VARCHAR NOT NULL,
    density          VARCHAR NOT NULL,
    weight_per_sqft  FLOAT   NOT NULL,
    CONSTRAINT fk_sheet_weight_thickness FOREIGN KEY (thickness)
        REFERENCES public.master_sheet_thickness(value)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_sheet_weight_density FOREIGN KEY (density)
        REFERENCES public.master_sheet_density(value)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT uq_sheet_weight UNIQUE (thickness, density)
);

-- Frame Production Target Table
-- Replaces Firestore doc referenceTables/frameTargets
-- Key: section × density → target kg per hour
CREATE TABLE public.master_frame_target (
    id                UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    section           VARCHAR NOT NULL,
    density           VARCHAR NOT NULL,
    target_kg_per_hour FLOAT  NOT NULL,
    CONSTRAINT fk_frame_target_section FOREIGN KEY (section)
        REFERENCES public.master_frame_section(name)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_frame_target_density FOREIGN KEY (density)
        REFERENCES public.master_frame_density(value)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT uq_frame_target UNIQUE (section, density)
);

-- Sheet Production Target Table
-- Replaces Firestore doc referenceTables/sheetTargets
-- Key: thickness × density → target running feet per hour
CREATE TABLE public.master_sheet_target (
    id                    UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    thickness             VARCHAR NOT NULL,
    density               VARCHAR NOT NULL,
    target_feet_per_hour  FLOAT   NOT NULL,
    CONSTRAINT fk_sheet_target_thickness FOREIGN KEY (thickness)
        REFERENCES public.master_sheet_thickness(value)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_sheet_target_density FOREIGN KEY (density)
        REFERENCES public.master_sheet_density(value)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT uq_sheet_target UNIQUE (thickness, density)
);

-- Scrap Production Target Table
-- Replaces Firestore doc referenceTables/scrapTargets
-- Key: product → target kg per hour
CREATE TABLE public.master_scrap_target (
    id                UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    product           VARCHAR NOT NULL UNIQUE,
    target_kg_per_hour FLOAT  NOT NULL,
    CONSTRAINT fk_scrap_target_product FOREIGN KEY (product)
        REFERENCES public.master_scrap_product(name)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Salary Weightage Table
-- Replaces Firestore docs referenceTables/salaryWeightages and
-- referenceTables/scrapSalaryWeightages
-- Key: category × variable → percentage (all variables per category sum to 100)
CREATE TABLE public.master_salary_weightage (
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
ON CONFLICT (section, density) DO NOTHING;

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
ON CONFLICT (thickness, density) DO NOTHING;

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
ON CONFLICT (section, density) DO NOTHING;

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
ON CONFLICT (thickness, density) DO NOTHING;

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


-- ═══════════════════════════════════════════════════════════════
-- SOURCE: tools/sql/01_schema.sql
-- ═══════════════════════════════════════════════════════════════

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
    CONSTRAINT fk_frame_weight_section FOREIGN KEY (section)
        REFERENCES public.master_frame_section(name)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_frame_weight_density FOREIGN KEY (density)
        REFERENCES public.master_frame_density(value)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
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
    CONSTRAINT fk_sheet_weight_thickness FOREIGN KEY (thickness)
        REFERENCES public.master_sheet_thickness(value)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_sheet_weight_density FOREIGN KEY (density)
        REFERENCES public.master_sheet_density(value)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
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
    CONSTRAINT fk_frame_target_section FOREIGN KEY (section)
        REFERENCES public.master_frame_section(name)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_frame_target_density FOREIGN KEY (density)
        REFERENCES public.master_frame_density(value)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
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
    CONSTRAINT fk_sheet_target_thickness FOREIGN KEY (thickness)
        REFERENCES public.master_sheet_thickness(value)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_sheet_target_density FOREIGN KEY (density)
        REFERENCES public.master_sheet_density(value)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT uq_sheet_target UNIQUE (thickness, density)
);

-- Scrap Production Target Table
-- Replaces Firestore doc referenceTables/scrapTargets
-- Key: product → target kg per hour
CREATE TABLE IF NOT EXISTS public.master_scrap_target (
    id                UUID    PRIMARY KEY DEFAULT uuid_generate_v4(),
    product           VARCHAR NOT NULL UNIQUE,
    target_kg_per_hour FLOAT  NOT NULL,
    CONSTRAINT fk_scrap_target_product FOREIGN KEY (product)
        REFERENCES public.master_scrap_product(name)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
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


-- ═══════════════════════════════════════════════════════════════
-- SOURCE: tools/sql/02_seed_reference_tables.sql
-- ═══════════════════════════════════════════════════════════════

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


-- ═══════════════════════════════════════════════════════════════
-- SOURCE: tools/sql/03_enforce_master_reference_fks.sql
-- ═══════════════════════════════════════════════════════════════

-- ═══════════════════════════════════════════════════════════════
-- Factory App — Enforce Master/Reference FK Constraints
-- Run on an existing database after 01_schema.sql has already been applied.
--
-- Behavior: CASCADE renames of parent values down to the lookup rows, and
-- RESTRICT delete on parent rows when children exist.
-- This gives a clear FK error instead of allowing inconsistent data.
-- ═══════════════════════════════════════════════════════════════

SET ROLE "firebaseowner_fdcdb_public";

-- Optional: inspect potential orphan rows before validating constraints.
-- SELECT fw.* FROM public.master_frame_weight fw
-- LEFT JOIN public.master_frame_section s ON s.name = fw.section
-- WHERE s.id IS NULL;

ALTER TABLE public.master_frame_weight
  DROP CONSTRAINT IF EXISTS fk_frame_weight_section,
  ADD CONSTRAINT fk_frame_weight_section
    FOREIGN KEY (section)
    REFERENCES public.master_frame_section(name)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_weight
  DROP CONSTRAINT IF EXISTS fk_frame_weight_density,
  ADD CONSTRAINT fk_frame_weight_density
    FOREIGN KEY (density)
    REFERENCES public.master_frame_density(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_weight
  DROP CONSTRAINT IF EXISTS fk_sheet_weight_thickness,
  ADD CONSTRAINT fk_sheet_weight_thickness
    FOREIGN KEY (thickness)
    REFERENCES public.master_sheet_thickness(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_weight
  DROP CONSTRAINT IF EXISTS fk_sheet_weight_density,
  ADD CONSTRAINT fk_sheet_weight_density
    FOREIGN KEY (density)
    REFERENCES public.master_sheet_density(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_target
  DROP CONSTRAINT IF EXISTS fk_frame_target_section,
  ADD CONSTRAINT fk_frame_target_section
    FOREIGN KEY (section)
    REFERENCES public.master_frame_section(name)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_target
  DROP CONSTRAINT IF EXISTS fk_frame_target_density,
  ADD CONSTRAINT fk_frame_target_density
    FOREIGN KEY (density)
    REFERENCES public.master_frame_density(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_target
  DROP CONSTRAINT IF EXISTS fk_sheet_target_thickness,
  ADD CONSTRAINT fk_sheet_target_thickness
    FOREIGN KEY (thickness)
    REFERENCES public.master_sheet_thickness(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_target
  DROP CONSTRAINT IF EXISTS fk_sheet_target_density,
  ADD CONSTRAINT fk_sheet_target_density
    FOREIGN KEY (density)
    REFERENCES public.master_sheet_density(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_scrap_target
  DROP CONSTRAINT IF EXISTS fk_scrap_target_product,
  ADD CONSTRAINT fk_scrap_target_product
    FOREIGN KEY (product)
    REFERENCES public.master_scrap_product(name)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;


-- ═══════════════════════════════════════════════════════════════
-- SOURCE: tools/sql/04_apply_master_reference_fks_step_by_step.sql
-- ═══════════════════════════════════════════════════════════════

-- ===============================================================
-- Factory App - Step-by-step Master/Reference FK enforcement
--
-- Run this in Cloud SQL Query Editor (PostgreSQL) against database: fdcdb
-- Behavior:
-- 1) Validates orphan rows (child values missing in parent master tables)
-- 2) Stops with a clear error if any orphan rows exist
-- 3) Applies all FK constraints with ON UPDATE CASCADE / ON DELETE RESTRICT
-- 4) Returns a verification result set
-- ===============================================================

BEGIN;

SET ROLE "firebaseowner_fdcdb_public";

-- ---------------------------------------------------------------
-- Step 1: Validate orphan rows
-- ---------------------------------------------------------------
DO $$
DECLARE
  v_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM public.master_frame_weight fw
  LEFT JOIN public.master_frame_section s ON s.name = fw.section
  WHERE s.name IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_frame_weight.section -> master_frame_section.name (% rows)', v_count;
  END IF;

  SELECT COUNT(*) INTO v_count
  FROM public.master_frame_weight fw
  LEFT JOIN public.master_frame_density d ON d.value = fw.density
  WHERE d.value IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_frame_weight.density -> master_frame_density.value (% rows)', v_count;
  END IF;

  SELECT COUNT(*) INTO v_count
  FROM public.master_sheet_weight sw
  LEFT JOIN public.master_sheet_thickness t ON t.value = sw.thickness
  WHERE t.value IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_sheet_weight.thickness -> master_sheet_thickness.value (% rows)', v_count;
  END IF;

  SELECT COUNT(*) INTO v_count
  FROM public.master_sheet_weight sw
  LEFT JOIN public.master_sheet_density d ON d.value = sw.density
  WHERE d.value IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_sheet_weight.density -> master_sheet_density.value (% rows)', v_count;
  END IF;

  SELECT COUNT(*) INTO v_count
  FROM public.master_frame_target ft
  LEFT JOIN public.master_frame_section s ON s.name = ft.section
  WHERE s.name IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_frame_target.section -> master_frame_section.name (% rows)', v_count;
  END IF;

  SELECT COUNT(*) INTO v_count
  FROM public.master_frame_target ft
  LEFT JOIN public.master_frame_density d ON d.value = ft.density
  WHERE d.value IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_frame_target.density -> master_frame_density.value (% rows)', v_count;
  END IF;

  SELECT COUNT(*) INTO v_count
  FROM public.master_sheet_target st
  LEFT JOIN public.master_sheet_thickness t ON t.value = st.thickness
  WHERE t.value IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_sheet_target.thickness -> master_sheet_thickness.value (% rows)', v_count;
  END IF;

  SELECT COUNT(*) INTO v_count
  FROM public.master_sheet_target st
  LEFT JOIN public.master_sheet_density d ON d.value = st.density
  WHERE d.value IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_sheet_target.density -> master_sheet_density.value (% rows)', v_count;
  END IF;

  SELECT COUNT(*) INTO v_count
  FROM public.master_scrap_target st
  LEFT JOIN public.master_scrap_product p ON p.name = st.product
  WHERE p.name IS NULL;
  IF v_count > 0 THEN
    RAISE EXCEPTION 'Orphan rows found: master_scrap_target.product -> master_scrap_product.name (% rows)', v_count;
  END IF;

  RAISE NOTICE 'Step 1 complete: no orphan rows found';
END
$$;

-- ---------------------------------------------------------------
-- Step 2: Apply FK constraints
-- Renames cascade to the lookup rows; deletes stay a manual child-first flow.
-- ---------------------------------------------------------------
ALTER TABLE public.master_frame_weight
  DROP CONSTRAINT IF EXISTS fk_frame_weight_section,
  ADD CONSTRAINT fk_frame_weight_section
    FOREIGN KEY (section)
    REFERENCES public.master_frame_section(name)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_weight
  DROP CONSTRAINT IF EXISTS fk_frame_weight_density,
  ADD CONSTRAINT fk_frame_weight_density
    FOREIGN KEY (density)
    REFERENCES public.master_frame_density(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_weight
  DROP CONSTRAINT IF EXISTS fk_sheet_weight_thickness,
  ADD CONSTRAINT fk_sheet_weight_thickness
    FOREIGN KEY (thickness)
    REFERENCES public.master_sheet_thickness(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_weight
  DROP CONSTRAINT IF EXISTS fk_sheet_weight_density,
  ADD CONSTRAINT fk_sheet_weight_density
    FOREIGN KEY (density)
    REFERENCES public.master_sheet_density(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_target
  DROP CONSTRAINT IF EXISTS fk_frame_target_section,
  ADD CONSTRAINT fk_frame_target_section
    FOREIGN KEY (section)
    REFERENCES public.master_frame_section(name)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_target
  DROP CONSTRAINT IF EXISTS fk_frame_target_density,
  ADD CONSTRAINT fk_frame_target_density
    FOREIGN KEY (density)
    REFERENCES public.master_frame_density(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_target
  DROP CONSTRAINT IF EXISTS fk_sheet_target_thickness,
  ADD CONSTRAINT fk_sheet_target_thickness
    FOREIGN KEY (thickness)
    REFERENCES public.master_sheet_thickness(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_target
  DROP CONSTRAINT IF EXISTS fk_sheet_target_density,
  ADD CONSTRAINT fk_sheet_target_density
    FOREIGN KEY (density)
    REFERENCES public.master_sheet_density(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_scrap_target
  DROP CONSTRAINT IF EXISTS fk_scrap_target_product,
  ADD CONSTRAINT fk_scrap_target_product
    FOREIGN KEY (product)
    REFERENCES public.master_scrap_product(name)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

SELECT 'Step 2 complete: FK constraints applied' AS status;

COMMIT;

-- ---------------------------------------------------------------
-- Step 3: Verification output
-- ---------------------------------------------------------------
SELECT
  conname,
  conrelid::regclass AS table_name,
  pg_get_constraintdef(c.oid) AS constraint_definition
FROM pg_constraint c
WHERE conname IN (
  'fk_frame_weight_section',
  'fk_frame_weight_density',
  'fk_sheet_weight_thickness',
  'fk_sheet_weight_density',
  'fk_frame_target_section',
  'fk_frame_target_density',
  'fk_sheet_target_thickness',
  'fk_sheet_target_density',
  'fk_scrap_target_product'
)
ORDER BY conname;


-- ═══════════════════════════════════════════════════════════════
-- SOURCE: tools/sql/05_delete_and_validate_master_reference.sql
-- ═══════════════════════════════════════════════════════════════

-- ===============================================================
-- Factory App - Child-first delete + validation script
--
-- Usage:
-- 1) Set values in the input CTE (entity_type + entity_value)
-- 2) Run in Cloud SQL Query Editor (PostgreSQL / fdcdb)
--
-- entity_type allowed values:
--   frame_section | frame_density | sheet_thickness | sheet_density | scrap_product
--
-- Behavior:
-- 1) Shows child usage counts before delete
-- 2) Deletes child rows first
-- 3) Deletes selected master row
-- 4) Validates master row removed and no child rows remain for the value
-- ===============================================================

BEGIN;

SET ROLE "firebaseowner_fdcdb_public";

-- -------------------------
-- Input: change here
-- -------------------------
WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
SELECT entity_type, entity_value FROM input;

-- -------------------------
-- Pre-delete usage report
-- -------------------------
WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
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
FROM input i;

-- -------------------------
-- Step 1: child-first delete
-- -------------------------
WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_frame_weight fw
USING input i
WHERE i.entity_type = 'frame_section'
  AND fw.section = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_frame_target ft
USING input i
WHERE i.entity_type = 'frame_section'
  AND ft.section = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_frame_weight fw
USING input i
WHERE i.entity_type = 'frame_density'
  AND fw.density = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_frame_target ft
USING input i
WHERE i.entity_type = 'frame_density'
  AND ft.density = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_sheet_weight sw
USING input i
WHERE i.entity_type = 'sheet_thickness'
  AND sw.thickness = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_sheet_target st
USING input i
WHERE i.entity_type = 'sheet_thickness'
  AND st.thickness = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_sheet_weight sw
USING input i
WHERE i.entity_type = 'sheet_density'
  AND sw.density = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_sheet_target st
USING input i
WHERE i.entity_type = 'sheet_density'
  AND st.density = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_scrap_target st
USING input i
WHERE i.entity_type = 'scrap_product'
  AND st.product = i.entity_value;

-- -------------------------
-- Step 2: delete master row
-- -------------------------
WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_frame_section s
USING input i
WHERE i.entity_type = 'frame_section'
  AND s.name = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_frame_density d
USING input i
WHERE i.entity_type = 'frame_density'
  AND d.value = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_sheet_thickness t
USING input i
WHERE i.entity_type = 'sheet_thickness'
  AND t.value = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_sheet_density d
USING input i
WHERE i.entity_type = 'sheet_density'
  AND d.value = i.entity_value;

WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
DELETE FROM public.master_scrap_product p
USING input i
WHERE i.entity_type = 'scrap_product'
  AND p.name = i.entity_value;

-- -------------------------
-- Step 3: validation report
-- -------------------------
WITH input(entity_type, entity_value) AS (
  VALUES ('frame_section', '3x2')
)
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
FROM input i;

COMMIT;

SELECT 'Delete and validation script completed' AS status;


-- ═══════════════════════════════════════════════════════════════
-- SOURCE: tools/sql/06_delete_and_validate_master_reference_single_input.sql
-- ═══════════════════════════════════════════════════════════════

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


-- ═══════════════════════════════════════════════════════════════
-- SOURCE: tools/sql/07_safe_health_report_migration.sql
-- ═══════════════════════════════════════════════════════════════

-- ═══════════════════════════════════════════════════════════════
-- Factory App — Safe health-report schema migration
-- ═══════════════════════════════════════════════════════════════
-- WHY: Live DB still has old rating columns (total_score / percentage)
--      and rating-item tables. The app now writes maintenance entries
--      and total_maintenance_duration_hours. Without this, Frame/Sheet
--      "New Machine Health Report" submit fails.
--
-- HOW TO RUN:
--   1. From project root:
--        firebase dataconnect:sql:shell --project prabitha-operations
--   2. Paste this entire file into the shell and press Enter
--   3. Then run:  ./tools/run_dataconnect_migration.sh
--
-- SAFE / IDEMPOTENT: safe to re-run. Does NOT drop old rating data —
-- it renames legacy tables so history is kept.
-- ═══════════════════════════════════════════════════════════════

SET ROLE "firebaseowner_fdcdb_public";

BEGIN;

-- ── Frame health report ────────────────────────────────────────
ALTER TABLE public.frame_health_report
  ALTER COLUMN total_score DROP NOT NULL;

ALTER TABLE public.frame_health_report
  ALTER COLUMN percentage DROP NOT NULL;

ALTER TABLE public.frame_health_report
  ADD COLUMN IF NOT EXISTS total_maintenance_duration_hours double precision;

UPDATE public.frame_health_report
SET total_maintenance_duration_hours = 0
WHERE total_maintenance_duration_hours IS NULL;

ALTER TABLE public.frame_health_report
  ALTER COLUMN total_maintenance_duration_hours SET DEFAULT 0,
  ALTER COLUMN total_maintenance_duration_hours SET NOT NULL;

-- ── Sheet health report ────────────────────────────────────────
ALTER TABLE public.sheet_health_report
  ALTER COLUMN total_score DROP NOT NULL;

ALTER TABLE public.sheet_health_report
  ALTER COLUMN percentage DROP NOT NULL;

ALTER TABLE public.sheet_health_report
  ADD COLUMN IF NOT EXISTS total_maintenance_duration_hours double precision;

UPDATE public.sheet_health_report
SET total_maintenance_duration_hours = 0
WHERE total_maintenance_duration_hours IS NULL;

ALTER TABLE public.sheet_health_report
  ALTER COLUMN total_maintenance_duration_hours SET DEFAULT 0,
  ALTER COLUMN total_maintenance_duration_hours SET NOT NULL;

-- ── Maintenance entry tables (new model) ───────────────────────
CREATE TABLE IF NOT EXISTS public.frame_maintenance_entry (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  report_id uuid NOT NULL,
  description text NOT NULL,
  duration_hours double precision NOT NULL,
  end_time timestamptz NOT NULL,
  maintenance_item text NOT NULL,
  person_doing_maintenance text NOT NULL,
  start_time timestamptz NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT frame_maintenance_entry_report_id_fkey
    FOREIGN KEY (report_id)
    REFERENCES public.frame_health_report (id)
    ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS "frame_maintenance_entry_reportId_idx"
  ON public.frame_maintenance_entry (report_id);

CREATE TABLE IF NOT EXISTS public.sheet_maintenance_entry (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  report_id uuid NOT NULL,
  description text NOT NULL,
  duration_hours double precision NOT NULL,
  end_time timestamptz NOT NULL,
  maintenance_item text NOT NULL,
  person_doing_maintenance text NOT NULL,
  start_time timestamptz NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT sheet_maintenance_entry_report_id_fkey
    FOREIGN KEY (report_id)
    REFERENCES public.sheet_health_report (id)
    ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS "sheet_maintenance_entry_reportId_idx"
  ON public.sheet_maintenance_entry (report_id);

-- ── Archive legacy rating tables (keep history; migrate may drop originals) ──
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'public' AND table_name = 'frame_health_rating_item'
  ) AND NOT EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'public' AND table_name = 'frame_health_rating_item_legacy'
  ) THEN
    EXECUTE 'ALTER TABLE public.frame_health_rating_item RENAME TO frame_health_rating_item_legacy';
  END IF;

  IF EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'public' AND table_name = 'sheet_health_rating_item'
  ) AND NOT EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'public' AND table_name = 'sheet_health_rating_item_legacy'
  ) THEN
    EXECUTE 'ALTER TABLE public.sheet_health_rating_item RENAME TO sheet_health_rating_item_legacy';
  END IF;
END $$;

COMMIT;

-- ── Verify ─────────────────────────────────────────────────────
SELECT 'frame_health_report columns' AS check_name,
       column_name, is_nullable, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'frame_health_report'
  AND column_name IN (
    'total_score', 'percentage', 'total_maintenance_duration_hours'
  )
ORDER BY column_name;

SELECT 'sheet_health_report columns' AS check_name,
       column_name, is_nullable, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'sheet_health_report'
  AND column_name IN (
    'total_score', 'percentage', 'total_maintenance_duration_hours'
  )
ORDER BY column_name;

SELECT 'frame_maintenance_entry exists' AS check_name,
       COUNT(*) AS table_count
FROM information_schema.tables
WHERE table_schema = 'public' AND table_name = 'frame_maintenance_entry';

SELECT 'sheet_maintenance_entry exists' AS check_name,
       COUNT(*) AS table_count
FROM information_schema.tables
WHERE table_schema = 'public' AND table_name = 'sheet_maintenance_entry';


-- ═══════════════════════════════════════════════════════════════
-- SOURCE: tools/sql/08_preflight_fix_migration_blockers.sql
-- ═══════════════════════════════════════════════════════════════

-- ═══════════════════════════════════════════════════════════════
-- Factory App — Pre-flight fixes for sql:migrate blockers
-- ═══════════════════════════════════════════════════════════════
-- WHY: `firebase dataconnect:sql:migrate` runs as ONE transaction and
--      aborts on the first failing statement. Two statements in the
--      queue can fail on existing data:
--
--        1. frame_customer_rejection_report.rejection_date SET NOT NULL
--           -> fails if any row has NULL  (CONFIRMED failure)
--        2. CREATE UNIQUE INDEX on master_scrap_target(product)
--           -> fails if duplicate products exist
--
-- RUN THIS in the Google Cloud SQL query window BEFORE re-running
-- ./tools/run_dataconnect_migration.sh
--
-- SAFE / IDEMPOTENT: re-runnable. Backfills rather than deletes.
-- ═══════════════════════════════════════════════════════════════

SET ROLE "firebaseowner_fdcdb_public";

-- ── BEFORE: inspect the damage ─────────────────────────────────
SELECT 'BEFORE: rejection_date NULLs' AS check_name,
       COUNT(*) AS null_rows
FROM public.frame_customer_rejection_report
WHERE rejection_date IS NULL;

SELECT 'BEFORE: duplicate scrap products' AS check_name,
       COUNT(*) AS duplicate_groups
FROM (
  SELECT product
  FROM public.master_scrap_target
  GROUP BY product
  HAVING COUNT(*) > 1
) dupes;

BEGIN;

-- ── Fix 1: backfill NULL rejection_date ────────────────────────
-- Preference order:
--   1. original_production_date (a rejection belongs to that batch)
--   2. the row's created timestamp
--   3. today (last resort so the column can be made NOT NULL)
UPDATE public.frame_customer_rejection_report
SET rejection_date = COALESCE(
      original_production_date,
      "timestamp"::date,
      CURRENT_DATE
    )
WHERE rejection_date IS NULL;

-- Also guard the sibling column the schema requires as NOT NULL.
UPDATE public.frame_customer_rejection_report
SET original_production_date = COALESCE(
      rejection_date,
      "timestamp"::date,
      CURRENT_DATE
    )
WHERE original_production_date IS NULL;

-- ── Fix 2: de-duplicate master_scrap_target.product ────────────
-- Keeps the most recently created row per product, deletes the rest,
-- so the UNIQUE index can be created.
DELETE FROM public.master_scrap_target a
USING public.master_scrap_target b
WHERE a.product = b.product
  AND a.ctid < b.ctid;

COMMIT;

-- ── AFTER: verify both blockers are cleared ────────────────────
SELECT 'AFTER: rejection_date NULLs (must be 0)' AS check_name,
       COUNT(*) AS null_rows
FROM public.frame_customer_rejection_report
WHERE rejection_date IS NULL;

SELECT 'AFTER: original_production_date NULLs (must be 0)' AS check_name,
       COUNT(*) AS null_rows
FROM public.frame_customer_rejection_report
WHERE original_production_date IS NULL;

SELECT 'AFTER: duplicate scrap products (must be 0)' AS check_name,
       COUNT(*) AS duplicate_groups
FROM (
  SELECT product
  FROM public.master_scrap_target
  GROUP BY product
  HAVING COUNT(*) > 1
) dupes;

-- ── Scan every other column the migration will require NOT NULL ──
-- All counts below must be 0 before re-running the migration.
SELECT 'health: frame total_maintenance_duration_hours NULLs' AS check_name,
       COUNT(*) AS null_rows
FROM public.frame_health_report
WHERE total_maintenance_duration_hours IS NULL;

SELECT 'health: sheet total_maintenance_duration_hours NULLs' AS check_name,
       COUNT(*) AS null_rows
FROM public.sheet_health_report
WHERE total_maintenance_duration_hours IS NULL;


-- ═══════════════════════════════════════════════════════════════
-- SOURCE: tools/sql/09_diagnose_weight_lookup_mismatch.sql
-- ═══════════════════════════════════════════════════════════════

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


-- ═══════════════════════════════════════════════════════════════
-- SOURCE: tools/sql/10_weight_mismatch_summary.sql
-- ═══════════════════════════════════════════════════════════════

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


-- ═══════════════════════════════════════════════════════════════
-- SOURCE: tools/sql/11_fix_weight_lookup_gaps.sql
-- ═══════════════════════════════════════════════════════════════

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


-- ═══════════════════════════════════════════════════════════════
-- SOURCE: tools/sql/12_master_reference_fks_on_update_cascade.sql
-- ═══════════════════════════════════════════════════════════════

-- ═══════════════════════════════════════════════════════════════
-- Factory App — Allow renaming master values referenced by lookups
--
-- Run in Cloud SQL Query Editor (PostgreSQL) against database: fdcdb.
-- Safe to re-run.
--
-- Why:
-- The weight/target lookup tables reference master values by their natural
-- key (name/value), not by id. The constraints added in 03/04 only declared
-- ON DELETE RESTRICT, so ON UPDATE defaulted to NO ACTION. Any admin edit of
-- a Frame Section, Frame Density, Sheet Thickness, Sheet Density or Scrap
-- Product that already appeared in a weight or target row was rejected with
-- "update or delete on table ... violates foreign key constraint".
--
-- This script switches every constraint to ON UPDATE CASCADE, so renaming a
-- master value rewrites the referencing lookup rows in the same transaction.
-- ON DELETE RESTRICT is kept: deleting a value that is still in use must stay
-- a deliberate, child-first operation (see 05/06).
-- ═══════════════════════════════════════════════════════════════

BEGIN;

SET ROLE "firebaseowner_fdcdb_public";

ALTER TABLE public.master_frame_weight
  DROP CONSTRAINT IF EXISTS fk_frame_weight_section,
  ADD CONSTRAINT fk_frame_weight_section
    FOREIGN KEY (section)
    REFERENCES public.master_frame_section(name)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_weight
  DROP CONSTRAINT IF EXISTS fk_frame_weight_density,
  ADD CONSTRAINT fk_frame_weight_density
    FOREIGN KEY (density)
    REFERENCES public.master_frame_density(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_weight
  DROP CONSTRAINT IF EXISTS fk_sheet_weight_thickness,
  ADD CONSTRAINT fk_sheet_weight_thickness
    FOREIGN KEY (thickness)
    REFERENCES public.master_sheet_thickness(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_weight
  DROP CONSTRAINT IF EXISTS fk_sheet_weight_density,
  ADD CONSTRAINT fk_sheet_weight_density
    FOREIGN KEY (density)
    REFERENCES public.master_sheet_density(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_target
  DROP CONSTRAINT IF EXISTS fk_frame_target_section,
  ADD CONSTRAINT fk_frame_target_section
    FOREIGN KEY (section)
    REFERENCES public.master_frame_section(name)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_target
  DROP CONSTRAINT IF EXISTS fk_frame_target_density,
  ADD CONSTRAINT fk_frame_target_density
    FOREIGN KEY (density)
    REFERENCES public.master_frame_density(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_target
  DROP CONSTRAINT IF EXISTS fk_sheet_target_thickness,
  ADD CONSTRAINT fk_sheet_target_thickness
    FOREIGN KEY (thickness)
    REFERENCES public.master_sheet_thickness(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_target
  DROP CONSTRAINT IF EXISTS fk_sheet_target_density,
  ADD CONSTRAINT fk_sheet_target_density
    FOREIGN KEY (density)
    REFERENCES public.master_sheet_density(value)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE public.master_scrap_target
  DROP CONSTRAINT IF EXISTS fk_scrap_target_product,
  ADD CONSTRAINT fk_scrap_target_product
    FOREIGN KEY (product)
    REFERENCES public.master_scrap_product(name)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

COMMIT;

-- ---------------------------------------------------------------
-- Verification: every row below must read ON UPDATE CASCADE ON DELETE RESTRICT
-- ---------------------------------------------------------------
SELECT
  conname,
  conrelid::regclass AS table_name,
  pg_get_constraintdef(c.oid) AS constraint_definition
FROM pg_constraint c
WHERE conname IN (
  'fk_frame_weight_section',
  'fk_frame_weight_density',
  'fk_sheet_weight_thickness',
  'fk_sheet_weight_density',
  'fk_frame_target_section',
  'fk_frame_target_density',
  'fk_sheet_target_thickness',
  'fk_sheet_target_density',
  'fk_scrap_target_product'
)
ORDER BY conname;


-- ═══════════════════════════════════════════════════════════════
-- SOURCE: tools/sql/insert_staff_users.sql
-- ═══════════════════════════════════════════════════════════════

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


-- ═══════════════════════════════════════════════════════════════
-- SOURCE: tools/seed_master_tables.sql
-- ═══════════════════════════════════════════════════════════════

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
  (uuid_generate_v4(), 'Window Shutter', '0.90', 0.778)
ON CONFLICT ON CONSTRAINT uq_frame_weight DO NOTHING;

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
  (uuid_generate_v4(), '36mm', '0.80', 2.124)
ON CONFLICT ON CONSTRAINT uq_sheet_weight DO NOTHING;

-- ══════════════════════════════════════
-- 14. FRAME PRODUCTION TARGETS (section × density → kg/hr)
-- ══════════════════════════════════════
INSERT INTO public.master_frame_target (id, section, density, target_kg_per_hour) VALUES
  (uuid_generate_v4(), '3x2',            '0.75',  80.0),
  (uuid_generate_v4(), '3x2',            '0.80',  80.0),
  (uuid_generate_v4(), '3x2',            '0.90',  80.0),
  (uuid_generate_v4(), '4x2',            '0.75', 100.0),
  (uuid_generate_v4(), '4x2',            '0.80', 100.0),
  (uuid_generate_v4(), '4x2',            '0.90', 100.0),
  (uuid_generate_v4(), '4x2.5',          '0.75', 120.0),
  (uuid_generate_v4(), '4x2.5',          '0.80', 120.0),
  (uuid_generate_v4(), '4x2.5',          '0.90', 120.0),
  (uuid_generate_v4(), '5x2.5',          '0.75', 140.0),
  (uuid_generate_v4(), '5x2.5',          '0.80', 140.0),
  (uuid_generate_v4(), '5x2.5',          '0.90', 140.0),
  (uuid_generate_v4(), '3x2 (HR)',       '0.75',  80.0),
  (uuid_generate_v4(), '3x2 (HR)',       '0.80',  80.0),
  (uuid_generate_v4(), '3x2 (HR)',       '0.90',  80.0),
  (uuid_generate_v4(), '4x2.5(HR)',      '0.75', 120.0),
  (uuid_generate_v4(), '4x2.5(HR)',      '0.80', 120.0),
  (uuid_generate_v4(), '4x2.5(HR)',      '0.90', 120.0),
  (uuid_generate_v4(), 'Window Shutter', '0.75',  90.0),
  (uuid_generate_v4(), 'Window Shutter', '0.80',  90.0),
  (uuid_generate_v4(), 'Window Shutter', '0.90',  90.0)
ON CONFLICT ON CONSTRAINT uq_frame_target DO NOTHING;

-- ══════════════════════════════════════
-- 15. SHEET PRODUCTION TARGETS (thickness × density → ft/hr)
-- ══════════════════════════════════════
INSERT INTO public.master_sheet_target (id, thickness, density, target_feet_per_hour) VALUES
  (uuid_generate_v4(), '6mm',        '0.45', 250.0), (uuid_generate_v4(), '6mm',        '0.50', 250.0), (uuid_generate_v4(), '6mm',        '0.55', 250.0), (uuid_generate_v4(), '6mm',        '0.60', 250.0), (uuid_generate_v4(), '6mm',        '0.65', 250.0), (uuid_generate_v4(), '6mm',        '0.70', 250.0), (uuid_generate_v4(), '6mm',        '0.80', 250.0),
  (uuid_generate_v4(), '7mm',        '0.45', 230.0), (uuid_generate_v4(), '7mm',        '0.50', 230.0), (uuid_generate_v4(), '7mm',        '0.55', 230.0), (uuid_generate_v4(), '7mm',        '0.60', 230.0), (uuid_generate_v4(), '7mm',        '0.65', 230.0), (uuid_generate_v4(), '7mm',        '0.70', 230.0), (uuid_generate_v4(), '7mm',        '0.80', 230.0),
  (uuid_generate_v4(), '8mm',        '0.45', 210.0), (uuid_generate_v4(), '8mm',        '0.50', 210.0), (uuid_generate_v4(), '8mm',        '0.55', 210.0), (uuid_generate_v4(), '8mm',        '0.60', 210.0), (uuid_generate_v4(), '8mm',        '0.65', 210.0), (uuid_generate_v4(), '8mm',        '0.70', 210.0), (uuid_generate_v4(), '8mm',        '0.80', 210.0),
  (uuid_generate_v4(), '9mm',        '0.45', 200.0), (uuid_generate_v4(), '9mm',        '0.50', 200.0), (uuid_generate_v4(), '9mm',        '0.55', 200.0), (uuid_generate_v4(), '9mm',        '0.60', 200.0), (uuid_generate_v4(), '9mm',        '0.65', 200.0), (uuid_generate_v4(), '9mm',        '0.70', 200.0), (uuid_generate_v4(), '9mm',        '0.80', 200.0),
  (uuid_generate_v4(), '12mm',       '0.45', 170.0), (uuid_generate_v4(), '12mm',       '0.50', 170.0), (uuid_generate_v4(), '12mm',       '0.55', 170.0), (uuid_generate_v4(), '12mm',       '0.60', 170.0), (uuid_generate_v4(), '12mm',       '0.65', 170.0), (uuid_generate_v4(), '12mm',       '0.70', 170.0), (uuid_generate_v4(), '12mm',       '0.80', 170.0),
  (uuid_generate_v4(), '13mm',       '0.45', 160.0), (uuid_generate_v4(), '13mm',       '0.50', 160.0), (uuid_generate_v4(), '13mm',       '0.55', 160.0), (uuid_generate_v4(), '13mm',       '0.60', 160.0), (uuid_generate_v4(), '13mm',       '0.65', 160.0), (uuid_generate_v4(), '13mm',       '0.70', 160.0), (uuid_generate_v4(), '13mm',       '0.80', 160.0),
  (uuid_generate_v4(), '16mm',       '0.45', 140.0), (uuid_generate_v4(), '16mm',       '0.50', 140.0), (uuid_generate_v4(), '16mm',       '0.55', 140.0), (uuid_generate_v4(), '16mm',       '0.60', 140.0), (uuid_generate_v4(), '16mm',       '0.65', 140.0), (uuid_generate_v4(), '16mm',       '0.70', 140.0), (uuid_generate_v4(), '16mm',       '0.80', 140.0),
  (uuid_generate_v4(), '17mm',       '0.45', 130.0), (uuid_generate_v4(), '17mm',       '0.50', 130.0), (uuid_generate_v4(), '17mm',       '0.55', 130.0), (uuid_generate_v4(), '17mm',       '0.60', 130.0), (uuid_generate_v4(), '17mm',       '0.65', 130.0), (uuid_generate_v4(), '17mm',       '0.70', 130.0), (uuid_generate_v4(), '17mm',       '0.80', 130.0),
  (uuid_generate_v4(), '18mm',       '0.45', 125.0), (uuid_generate_v4(), '18mm',       '0.50', 125.0), (uuid_generate_v4(), '18mm',       '0.55', 125.0), (uuid_generate_v4(), '18mm',       '0.60', 125.0), (uuid_generate_v4(), '18mm',       '0.65', 125.0), (uuid_generate_v4(), '18mm',       '0.70', 125.0), (uuid_generate_v4(), '18mm',       '0.80', 125.0),
  (uuid_generate_v4(), '19mm',       '0.45', 120.0), (uuid_generate_v4(), '19mm',       '0.50', 120.0), (uuid_generate_v4(), '19mm',       '0.55', 120.0), (uuid_generate_v4(), '19mm',       '0.60', 120.0), (uuid_generate_v4(), '19mm',       '0.65', 120.0), (uuid_generate_v4(), '19mm',       '0.70', 120.0), (uuid_generate_v4(), '19mm',       '0.80', 120.0),
  (uuid_generate_v4(), '22mm',       '0.45', 100.0), (uuid_generate_v4(), '22mm',       '0.50', 100.0), (uuid_generate_v4(), '22mm',       '0.55', 100.0), (uuid_generate_v4(), '22mm',       '0.60', 100.0), (uuid_generate_v4(), '22mm',       '0.65', 100.0), (uuid_generate_v4(), '22mm',       '0.70', 100.0), (uuid_generate_v4(), '22mm',       '0.80', 100.0),
  (uuid_generate_v4(), '25mm sheet', '0.45',  85.0), (uuid_generate_v4(), '25mm sheet', '0.50',  85.0), (uuid_generate_v4(), '25mm sheet', '0.55',  85.0), (uuid_generate_v4(), '25mm sheet', '0.60',  85.0), (uuid_generate_v4(), '25mm sheet', '0.65',  85.0), (uuid_generate_v4(), '25mm sheet', '0.70',  85.0), (uuid_generate_v4(), '25mm sheet', '0.80',  85.0),
  (uuid_generate_v4(), '25mm Door',  '0.45',  85.0), (uuid_generate_v4(), '25mm Door',  '0.50',  85.0), (uuid_generate_v4(), '25mm Door',  '0.55',  85.0), (uuid_generate_v4(), '25mm Door',  '0.60',  85.0), (uuid_generate_v4(), '25mm Door',  '0.65',  85.0), (uuid_generate_v4(), '25mm Door',  '0.70',  85.0), (uuid_generate_v4(), '25mm Door',  '0.80',  85.0),
  (uuid_generate_v4(), '26mm',       '0.45',  80.0), (uuid_generate_v4(), '26mm',       '0.50',  80.0), (uuid_generate_v4(), '26mm',       '0.55',  80.0), (uuid_generate_v4(), '26mm',       '0.60',  80.0), (uuid_generate_v4(), '26mm',       '0.65',  80.0), (uuid_generate_v4(), '26mm',       '0.70',  80.0), (uuid_generate_v4(), '26mm',       '0.80',  80.0),
  (uuid_generate_v4(), '27mm',       '0.45',  78.0), (uuid_generate_v4(), '27mm',       '0.50',  78.0), (uuid_generate_v4(), '27mm',       '0.55',  78.0), (uuid_generate_v4(), '27mm',       '0.60',  78.0), (uuid_generate_v4(), '27mm',       '0.65',  78.0), (uuid_generate_v4(), '27mm',       '0.70',  78.0), (uuid_generate_v4(), '27mm',       '0.80',  78.0),
  (uuid_generate_v4(), '28mm',       '0.45',  75.0), (uuid_generate_v4(), '28mm',       '0.50',  75.0), (uuid_generate_v4(), '28mm',       '0.55',  75.0), (uuid_generate_v4(), '28mm',       '0.60',  75.0), (uuid_generate_v4(), '28mm',       '0.65',  75.0), (uuid_generate_v4(), '28mm',       '0.70',  75.0), (uuid_generate_v4(), '28mm',       '0.80',  75.0),
  (uuid_generate_v4(), '30mm',       '0.45',  70.0), (uuid_generate_v4(), '30mm',       '0.50',  70.0), (uuid_generate_v4(), '30mm',       '0.55',  70.0), (uuid_generate_v4(), '30mm',       '0.60',  70.0), (uuid_generate_v4(), '30mm',       '0.65',  70.0), (uuid_generate_v4(), '30mm',       '0.70',  70.0), (uuid_generate_v4(), '30mm',       '0.80',  70.0),
  (uuid_generate_v4(), '31mm',       '0.45',  68.0), (uuid_generate_v4(), '31mm',       '0.50',  68.0), (uuid_generate_v4(), '31mm',       '0.55',  68.0), (uuid_generate_v4(), '31mm',       '0.60',  68.0), (uuid_generate_v4(), '31mm',       '0.65',  68.0), (uuid_generate_v4(), '31mm',       '0.70',  68.0), (uuid_generate_v4(), '31mm',       '0.80',  68.0),
  (uuid_generate_v4(), '33mm',       '0.45',  60.0), (uuid_generate_v4(), '33mm',       '0.50',  60.0), (uuid_generate_v4(), '33mm',       '0.55',  60.0), (uuid_generate_v4(), '33mm',       '0.60',  60.0), (uuid_generate_v4(), '33mm',       '0.65',  60.0), (uuid_generate_v4(), '33mm',       '0.70',  60.0), (uuid_generate_v4(), '33mm',       '0.80',  60.0),
  (uuid_generate_v4(), '35mm',       '0.45',  55.0), (uuid_generate_v4(), '35mm',       '0.50',  55.0), (uuid_generate_v4(), '35mm',       '0.55',  55.0), (uuid_generate_v4(), '35mm',       '0.60',  55.0), (uuid_generate_v4(), '35mm',       '0.65',  55.0), (uuid_generate_v4(), '35mm',       '0.70',  55.0), (uuid_generate_v4(), '35mm',       '0.80',  55.0),
  (uuid_generate_v4(), '36mm',       '0.45',  52.0), (uuid_generate_v4(), '36mm',       '0.50',  52.0), (uuid_generate_v4(), '36mm',       '0.55',  52.0), (uuid_generate_v4(), '36mm',       '0.60',  52.0), (uuid_generate_v4(), '36mm',       '0.65',  52.0), (uuid_generate_v4(), '36mm',       '0.70',  52.0), (uuid_generate_v4(), '36mm',       '0.80',  52.0)
ON CONFLICT ON CONSTRAINT uq_sheet_target DO NOTHING;

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


-- ═══════════════════════════════════════════════════════════════
-- SOURCE: tools/seed_data.sql
-- ═══════════════════════════════════════════════════════════════

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


-- ═══════════════════════════════════════════════════════════════
-- SOURCE: tools/output/schema_ddl.sql
-- ═══════════════════════════════════════════════════════════════

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

