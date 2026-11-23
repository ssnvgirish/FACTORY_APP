'use strict';

const slug = (s) => String(s).replace(/[^A-Za-z0-9]+/g, '_');

// Keep in sync with lib/features/auth/data/auth_identity.dart
function normalizePhone(phone) {
  const t = String(phone ?? '').trim();
  if (t.startsWith('+')) return t;
  if (t.length === 10) return `+91${t}`;
  return t;
}
const emailFor = (phone) => `${normalizePhone(phone).replace(/[^0-9]/g, '')}@prabitha.app`;
const passwordFor = (raw) => `prb#${raw}`;

/** GraphQL root field name Data Connect generates for a table type. */
function pluralize(typeName) {
  const lower = typeName[0].toLowerCase() + typeName.slice(1);
  if (/[^aeiou]y$/.test(lower)) return lower.slice(0, -1) + 'ies';
  if (/(s|x|ch|sh)$/.test(lower)) return lower + 'es';
  return lower + 's';
}

/**
 * Convert an exported Data Connect row into a Firestore document body.
 * - `id` and any key in opts.drop are removed
 * - fields listed in opts.timestampFields (ISO strings) go through opts.toTimestamp
 * Dates are already `yyyy-MM-dd` strings and are kept as they are.
 */
function convertDoc(row, opts = {}) {
  const drop = new Set(opts.drop || []);
  const timestampFields = opts.timestampFields || new Set();
  const toTimestamp = opts.toTimestamp || ((d) => d);
  const out = {};
  for (const [key, value] of Object.entries(row)) {
    if (key === 'id' || drop.has(key)) continue;
    if (timestampFields.has(key) && typeof value === 'string') {
      out[key] = toTimestamp(new Date(value));
    } else {
      out[key] = value;
    }
  }
  return out;
}

module.exports = { slug, normalizePhone, emailFor, passwordFor, pluralize, convertDoc };
