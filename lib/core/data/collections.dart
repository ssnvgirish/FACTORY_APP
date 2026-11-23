/// Firestore collection names. One per former Data Connect table.
class Col {
  Col._();

  static const users = 'users';

  // Masters
  static const masterMachines = 'master_machines';
  static const masterShifts = 'master_shifts';
  static const masterRoles = 'master_roles';
  static const masterFrameSections = 'master_frame_sections';
  static const masterFrameDensities = 'master_frame_densities';
  static const masterFrameColors = 'master_frame_colors';
  static const masterSheetThicknesses = 'master_sheet_thicknesses';
  static const masterSheetDensities = 'master_sheet_densities';
  static const masterSheetColors = 'master_sheet_colors';
  static const masterMaintenanceItems = 'master_maintenance_items';
  static const masterScrapProducts = 'master_scrap_products';
  static const masterFrameWeights = 'master_frame_weights';
  static const masterSheetWeights = 'master_sheet_weights';
  static const masterFrameTargets = 'master_frame_targets';
  static const masterSheetTargets = 'master_sheet_targets';
  static const masterSalaryWeightages = 'master_salary_weightages';
  static const masterScrapTargets = 'master_scrap_targets';

  // Frames
  static const frameCleaning = 'frame_cleaning_reports';
  static const frameToolsCount = 'frame_tools_count_reports';
  static const frameHealth = 'frame_health_reports';
  static const frameProductionDetails = 'frame_production_details_reports';
  static const frameProductionWeight = 'frame_production_weight_reports';
  static const frameShiftPacking = 'frame_shift_packing_reports';
  static const frameWritingEfficiency = 'frame_writing_efficiencies';
  static const frameCustomerRejection = 'frame_customer_rejection_reports';

  // Sheets
  static const sheetCleaning = 'sheet_cleaning_reports';
  static const sheetToolsCount = 'sheet_tools_count_reports';
  static const sheetHealth = 'sheet_health_reports';
  static const sheetProductionDetails = 'sheet_production_details_reports';
  static const sheetRunningFeet = 'sheet_running_feet_reports';
  static const sheetShiftPacking = 'sheet_shift_packing_reports';
  static const sheetWritingEfficiency = 'sheet_writing_efficiencies';
  static const sheetCustomerRejection = 'sheet_customer_rejection_reports';

  // Scrap / regrind
  static const scrapCleaning = 'scrap_cleaning_reports';
  static const scrapToolsCount = 'scrap_tools_count_reports';
  static const scrapHealth = 'scrap_machine_health_reports';
  static const scrapProductionDetails = 'scrap_production_details_reports';
  static const scrapProductionWeight = 'scrap_production_weight_reports';
  static const scrapWritingEfficiency = 'scrap_writing_efficiencies';
  static const scrapQuality = 'scrap_quality_reports';

  // Salary
  static const salaryCalculations = 'salary_calculations';
  static const scrapSalaryCalculations = 'scrap_salary_calculations';

  // Dashboard counters
  static const stockTotals = 'stock_totals';
  static const stockVariants = 'stock_variants';
}
