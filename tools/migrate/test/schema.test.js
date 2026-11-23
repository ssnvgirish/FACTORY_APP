const { test } = require('node:test');
const assert = require('node:assert');
const { parseSchema, missingFields, timestampFields } = require('../schema');

const gql = `
type FrameCleaningReport @table {
  date: Date!
  machineNumber: String!
  percentage: Float!
  createdBy: String!
  timestamp: Timestamp @default(expr: "request.time")
}
type FrameMaintenanceEntry @table {
  report: FrameHealthReport!
  maintenanceItem: String!
  durationHours: Float!
}
`;

test('parseSchema lists required scalar fields and skips relations and optional fields', () => {
  const s = parseSchema(gql);
  assert.deepEqual(s.FrameCleaningReport.required, ['date', 'machineNumber', 'percentage', 'createdBy']);
  assert.deepEqual(s.FrameMaintenanceEntry.required, ['maintenanceItem', 'durationHours']);
  assert.deepEqual(s.FrameMaintenanceEntry.all, ['maintenanceItem', 'durationHours']);
});

test('missingFields reports absent or null required fields', () => {
  const s = parseSchema(gql);
  assert.deepEqual(
    missingFields(s, 'FrameCleaningReport', { date: '2026-11-01', machineNumber: 'M', percentage: 1, createdBy: null }),
    ['createdBy'],
  );
});

test('timestampFields finds Timestamp columns', () => {
  assert.deepEqual([...timestampFields(parseSchema(gql), 'FrameCleaningReport')], ['timestamp']);
});
