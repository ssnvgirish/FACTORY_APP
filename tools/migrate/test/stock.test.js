const { test } = require('node:test');
const assert = require('node:assert');
const { buildStock } = require('../stock');

test('frame stock matches Dart StockLedger semantics', () => {
  const production = [
    { totalWeight: 50, lineItems: [{ section: '3x2', density: '0.8', color: 'White', quantity: 10 }] },
  ];
  const packing = [
    { lineItems: [{ section: '3x2', density: '0.8', color: 'White', packed: 6, rejectedQuality: 1, perPieceWeight: 5 }] },
  ];
  const { totals, variants } = buildStock('frame', production, packing);
  assert.deepEqual(totals, { totalProduced: 50, totalPacked: 30, totalRejected: 5 });
  assert.equal(variants.length, 1);
  assert.deepEqual(variants[0], {
    id: 'frame__3x2__0_8__White', kind: 'frame', variant: '3x2', density: '0.8', color: 'White',
    produced: 10, packed: 6, rejected: 1,
  });
});

test('sheet stock uses thickness, running feet and runningFeetPerItem', () => {
  const production = [
    { totalRunningFeet: 100, lineItems: [{ thickness: '9mm', density: 'D', color: 'C', quantity: 10 }] },
  ];
  const packing = [
    { lineItems: [{ thickness: '9mm', density: 'D', color: 'C', packed: 6, rejectedQuality: 1, runningFeetPerItem: 10 }] },
  ];
  const { totals, variants } = buildStock('sheet', production, packing);
  assert.deepEqual(totals, { totalProduced: 100, totalPacked: 60, totalRejected: 10 });
  assert.equal(variants[0].variant, '9mm');
});
