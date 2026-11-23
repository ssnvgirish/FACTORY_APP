'use strict';
const { slug } = require('./transform');

/**
 * Rebuild stock counters from migrated production/packing documents.
 * Mirrors lib/core/data/stock_ledger.dart and the frame/sheet datasources.
 */
function buildStock(kind, productionDocs, packingDocs) {
  const frame = kind === 'frame';
  const variantKey = frame ? 'section' : 'thickness';
  const producedField = frame ? 'totalWeight' : 'totalRunningFeet';
  const perItemField = frame ? 'perPieceWeight' : 'runningFeetPerItem';

  const totals = { totalProduced: 0, totalPacked: 0, totalRejected: 0 };
  const variants = new Map();
  const variantFor = (li) => {
    const id = `${kind}__${slug(li[variantKey])}__${slug(li.density)}__${slug(li.color)}`;
    if (!variants.has(id)) {
      variants.set(id, {
        id, kind, variant: li[variantKey], density: li.density, color: li.color,
        produced: 0, packed: 0, rejected: 0,
      });
    }
    return variants.get(id);
  };

  for (const doc of productionDocs) {
    totals.totalProduced += doc[producedField] || 0;
    for (const li of doc.lineItems || []) variantFor(li).produced += li.quantity || 0;
  }
  for (const doc of packingDocs) {
    for (const li of doc.lineItems || []) {
      const v = variantFor(li);
      v.packed += li.packed || 0;
      v.rejected += li.rejectedQuality || 0;
      totals.totalPacked += (li.packed || 0) * (li[perItemField] || 0);
      totals.totalRejected += (li.rejectedQuality || 0) * (li[perItemField] || 0);
    }
  }
  return { totals, variants: [...variants.values()] };
}

module.exports = { buildStock };
