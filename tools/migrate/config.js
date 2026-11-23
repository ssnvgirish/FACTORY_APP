'use strict';

// type: GraphQL type in dataconnect/schema/schema.gql
// col:  Firestore collection (must match lib/core/data/collections.dart)
// children: child tables embedded in the parent doc under `key`; each child
//           row references its parent through the `report` relation field.
const masters = [
  ['MasterMachine', 'master_machines'],
  ['MasterShift', 'master_shifts'],
  ['MasterRole', 'master_roles'],
  ['MasterFrameSection', 'master_frame_sections'],
  ['MasterFrameDensity', 'master_frame_densities'],
  ['MasterFrameColor', 'master_frame_colors'],
  ['MasterSheetThickness', 'master_sheet_thicknesses'],
  ['MasterSheetDensity', 'master_sheet_densities'],
  ['MasterSheetColor', 'master_sheet_colors'],
  ['MasterMaintenanceItem', 'master_maintenance_items'],
  ['MasterScrapProduct', 'master_scrap_products'],
  ['MasterFrameWeight', 'master_frame_weights'],
  ['MasterSheetWeight', 'master_sheet_weights'],
  ['MasterFrameTarget', 'master_frame_targets'],
  ['MasterSheetTarget', 'master_sheet_targets'],
  ['MasterSalaryWeightage', 'master_salary_weightages'],
  ['MasterScrapTarget', 'master_scrap_targets'],
].map(([type, col]) => ({ type, col }));

const reports = [
  // frames
  { type: 'FrameCleaningReport', col: 'frame_cleaning_reports' },
  { type: 'FrameToolsCountReport', col: 'frame_tools_count_reports' },
  { type: 'FrameHealthReport', col: 'frame_health_reports',
    children: [{ type: 'FrameMaintenanceEntry', key: 'entries' }] },
  { type: 'FrameProductionDetailsReport', col: 'frame_production_details_reports',
    children: [{ type: 'FrameProductionLineItem', key: 'lineItems' }] },
  { type: 'FrameProductionWeightReport', col: 'frame_production_weight_reports' },
  { type: 'FrameShiftPackingReport', col: 'frame_shift_packing_reports',
    children: [{ type: 'FramePackingLineItem', key: 'lineItems' }] },
  { type: 'FrameWritingEfficiency', col: 'frame_writing_efficiencies' },
  { type: 'FrameCustomerRejectionReport', col: 'frame_customer_rejection_reports',
    children: [{ type: 'FrameCustomerRejectionItem', key: 'rejectedItems' }] },
  // sheets
  { type: 'SheetCleaningReport', col: 'sheet_cleaning_reports' },
  { type: 'SheetToolsCountReport', col: 'sheet_tools_count_reports' },
  { type: 'SheetHealthReport', col: 'sheet_health_reports',
    children: [{ type: 'SheetMaintenanceEntry', key: 'entries' }] },
  { type: 'SheetProductionDetailsReport', col: 'sheet_production_details_reports',
    children: [{ type: 'SheetProductionLineItem', key: 'lineItems' }] },
  { type: 'SheetRunningFeetReport', col: 'sheet_running_feet_reports' },
  { type: 'SheetShiftPackingReport', col: 'sheet_shift_packing_reports',
    children: [{ type: 'SheetPackingLineItem', key: 'lineItems' }] },
  { type: 'SheetWritingEfficiency', col: 'sheet_writing_efficiencies' },
  { type: 'SheetCustomerRejectionReport', col: 'sheet_customer_rejection_reports',
    children: [{ type: 'SheetCustomerRejectionItem', key: 'rejectedItems' }] },
  // scrap / regrind
  { type: 'ScrapCleaningReport', col: 'scrap_cleaning_reports' },
  { type: 'ScrapToolsCountReport', col: 'scrap_tools_count_reports' },
  { type: 'ScrapMachineHealthReport', col: 'scrap_machine_health_reports',
    children: [{ type: 'ScrapMaintenanceEntry', key: 'entries' }] },
  { type: 'ScrapProductionDetailsReport', col: 'scrap_production_details_reports',
    children: [{ type: 'ScrapProductionLineItem', key: 'lineItems' }] },
  { type: 'ScrapProductionWeightReport', col: 'scrap_production_weight_reports' },
  { type: 'ScrapWritingEfficiency', col: 'scrap_writing_efficiencies' },
  { type: 'ScrapQualityReport', col: 'scrap_quality_reports' },
  // salary
  { type: 'SalaryCalculation', col: 'salary_calculations' },
  { type: 'ScrapSalaryCalculation', col: 'scrap_salary_calculations' },
];

const users = { type: 'User', col: 'users' };

module.exports = { users, collections: [...masters, ...reports] };
