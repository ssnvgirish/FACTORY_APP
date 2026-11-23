// Usage: node tools/gen_indexes.js > firestore.indexes.json
const machineDate = [
  'frame_cleaning_reports', 'frame_tools_count_reports', 'frame_health_reports',
  'frame_production_details_reports', 'frame_production_weight_reports', 'frame_shift_packing_reports',
  'sheet_cleaning_reports', 'sheet_tools_count_reports', 'sheet_health_reports',
  'sheet_production_details_reports', 'sheet_running_feet_reports', 'sheet_shift_packing_reports',
  'scrap_cleaning_reports', 'scrap_tools_count_reports', 'scrap_machine_health_reports',
  'scrap_production_details_reports', 'scrap_production_weight_reports',
  'scrap_quality_reports', 'scrap_writing_efficiencies',
].map((c) => [c, 'machineNumber', 'date']);
const operatorDate = ['frame_writing_efficiencies', 'sheet_writing_efficiencies']
  .map((c) => [c, 'operatorId', 'date']);
const rejection = ['frame_customer_rejection_reports', 'sheet_customer_rejection_reports']
  .map((c) => [c, 'machineNumber', 'originalProductionDate']);

const indexes = [...machineDate, ...operatorDate, ...rejection].map(([c, eq, d]) => ({
  collectionGroup: c,
  queryScope: 'COLLECTION',
  fields: [
    { fieldPath: eq, order: 'ASCENDING' },
    { fieldPath: d, order: 'DESCENDING' },
  ],
}));
console.log(JSON.stringify({ indexes, fieldOverrides: [] }, null, 2));
