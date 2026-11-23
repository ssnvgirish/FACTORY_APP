'use strict';

const SCALARS = ['String', 'Int', 'Float', 'Boolean', 'Date', 'Timestamp', 'UUID'];

/**
 * Parse `type X @table { ... }` blocks of schema.gql.
 * Returns { TypeName: { fields: {name: baseType}, required: [names], all: [names] } }
 * Relation fields (type is another table) are skipped.
 */
function parseSchema(gql) {
  const out = {};
  const typeRe = /type\s+(\w+)\s+@table\s*\{([\s\S]*?)\n\}/g;
  let m;
  while ((m = typeRe.exec(gql))) {
    const fields = {};
    const required = [];
    for (const line of m[2].split('\n')) {
      const f = line.trim().match(/^(\w+):\s*(\[?\w+!?\]?!?)/);
      if (!f) continue;
      const [, name, type] = f;
      const base = type.replace(/[\[\]!]/g, '');
      if (!SCALARS.includes(base)) continue; // relation
      fields[name] = base;
      if (type.endsWith('!') && !/@default/.test(line)) required.push(name);
    }
    out[m[1]] = { fields, required, all: Object.keys(fields) };
  }
  return out;
}

function missingFields(schema, typeName, doc) {
  const spec = schema[typeName];
  if (!spec) throw new Error(`Unknown schema type ${typeName}`);
  return spec.required.filter((f) => doc[f] === undefined || doc[f] === null);
}

function timestampFields(schema, typeName) {
  const spec = schema[typeName];
  return new Set(Object.entries(spec.fields).filter(([, t]) => t === 'Timestamp').map(([k]) => k));
}

module.exports = { parseSchema, missingFields, timestampFields };
