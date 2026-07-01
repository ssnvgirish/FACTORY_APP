-- ═══════════════════════════════════════════════════════════════
-- Factory App — Enforce Master/Reference FK Constraints
-- Run on an existing database after 01_schema.sql has already been applied.
--
-- Behavior: RESTRICT delete on parent rows when children exist.
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
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_weight
  DROP CONSTRAINT IF EXISTS fk_frame_weight_density,
  ADD CONSTRAINT fk_frame_weight_density
    FOREIGN KEY (density)
    REFERENCES public.master_frame_density(value)
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_weight
  DROP CONSTRAINT IF EXISTS fk_sheet_weight_thickness,
  ADD CONSTRAINT fk_sheet_weight_thickness
    FOREIGN KEY (thickness)
    REFERENCES public.master_sheet_thickness(value)
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_weight
  DROP CONSTRAINT IF EXISTS fk_sheet_weight_density,
  ADD CONSTRAINT fk_sheet_weight_density
    FOREIGN KEY (density)
    REFERENCES public.master_sheet_density(value)
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_target
  DROP CONSTRAINT IF EXISTS fk_frame_target_section,
  ADD CONSTRAINT fk_frame_target_section
    FOREIGN KEY (section)
    REFERENCES public.master_frame_section(name)
    ON DELETE RESTRICT;

ALTER TABLE public.master_frame_target
  DROP CONSTRAINT IF EXISTS fk_frame_target_density,
  ADD CONSTRAINT fk_frame_target_density
    FOREIGN KEY (density)
    REFERENCES public.master_frame_density(value)
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_target
  DROP CONSTRAINT IF EXISTS fk_sheet_target_thickness,
  ADD CONSTRAINT fk_sheet_target_thickness
    FOREIGN KEY (thickness)
    REFERENCES public.master_sheet_thickness(value)
    ON DELETE RESTRICT;

ALTER TABLE public.master_sheet_target
  DROP CONSTRAINT IF EXISTS fk_sheet_target_density,
  ADD CONSTRAINT fk_sheet_target_density
    FOREIGN KEY (density)
    REFERENCES public.master_sheet_density(value)
    ON DELETE RESTRICT;

ALTER TABLE public.master_scrap_target
  DROP CONSTRAINT IF EXISTS fk_scrap_target_product,
  ADD CONSTRAINT fk_scrap_target_product
    FOREIGN KEY (product)
    REFERENCES public.master_scrap_product(name)
    ON DELETE RESTRICT;
