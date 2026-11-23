const { test } = require('node:test');
const assert = require('node:assert');
const { normalizePhone, emailFor, passwordFor, convertDoc, slug, pluralize } = require('../transform');

test('phone/email/password match the Dart AuthIdentity', () => {
  assert.equal(normalizePhone('9876543210'), '+919876543210');
  assert.equal(normalizePhone(' +919876543210 '), '+919876543210');
  assert.equal(emailFor('9876543210'), '919876543210@prabitha.app');
  assert.equal(passwordFor('1234'), 'prb#1234');
});

test('convertDoc drops id and listed fields, converts only timestamp fields', () => {
  const out = convertDoc(
    { id: 'x', report: { id: 'p' }, machineNumber: 'M1', date: '2026-11-10', submittedAt: '2026-11-10T08:00:00Z', quantity: 3 },
    { drop: ['report'], timestampFields: new Set(['submittedAt']), toTimestamp: (v) => ({ ts: v.toISOString() }) },
  );
  assert.deepEqual(out, {
    machineNumber: 'M1', date: '2026-11-10', submittedAt: { ts: '2026-11-10T08:00:00.000Z' }, quantity: 3,
  });
});

test('slug matches Dart StockLedger._slug', () => {
  assert.equal(slug('3x2 "A"'), '3x2_A_');
  assert.equal(slug('0.8'), '0_8');
});

test('pluralize matches Data Connect root field names', () => {
  assert.equal(pluralize('User'), 'users');
  assert.equal(pluralize('MasterMachine'), 'masterMachines');
  assert.equal(pluralize('FrameWritingEfficiency'), 'frameWritingEfficiencies');
  assert.equal(pluralize('MasterSheetThickness'), 'masterSheetThicknesses');
  assert.equal(pluralize('MasterFrameDensity'), 'masterFrameDensities');
});
