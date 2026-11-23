'use strict';
// Exports every table from the live Data Connect service over HTTPS using the
// Firebase CLI's login (no direct database connection or gcloud needed).
//
//   node export.js [--only FrameCleaningReport,User]
//
// Output: tools/migrate/export/<TypeName>.json  (contains clear-text passwords;
// gitignored — delete the folder after migrating).

const fs = require('node:fs');
const path = require('node:path');
const { execFileSync } = require('node:child_process');

const { users, collections } = require('./config');
const { parseSchema } = require('./schema');
const { pluralize } = require('./transform');

const PROJECT = process.env.GOOGLE_CLOUD_PROJECT || 'prabitha-operations';
const SERVICE = 'prabitha-operations-service';
const LOCATION = 'asia-south1';
const PAGE = 500;
const OUT = path.join(__dirname, 'export');
const TMP = path.join(__dirname, '.tmp');

const only = (() => {
  const i = process.argv.indexOf('--only');
  return i === -1 ? null : new Set(process.argv[i + 1].split(','));
})();

const schema = parseSchema(
  fs.readFileSync(path.join(__dirname, '../../dataconnect/schema/schema.gql'), 'utf8'),
);

function execute(gql) {
  fs.mkdirSync(TMP, { recursive: true });
  const file = path.join(TMP, 'q.gql');
  fs.writeFileSync(file, gql);
  const out = execFileSync(
    'firebase',
    ['dataconnect:execute', file, '--service', SERVICE, '--location', LOCATION,
      '--project', PROJECT, '--no-debug-details'],
    { encoding: 'utf8', maxBuffer: 256 * 1024 * 1024, stdio: ['ignore', 'pipe', 'pipe'] },
  );
  const start = out.indexOf('{');
  if (start === -1) throw new Error(`No JSON in CLI output:\n${out.slice(0, 500)}`);
  const parsed = JSON.parse(out.slice(start));
  if (parsed.errors) throw new Error(JSON.stringify(parsed.errors).slice(0, 500));
  return parsed.data;
}

function exportType(type, isChild) {
  const spec = schema[type];
  if (!spec) throw new Error(`Type ${type} not found in schema.gql`);
  const root = pluralize(type);
  const fields = ['id', ...spec.all, ...(isChild ? ['report { id }'] : [])].join(' ');
  const rows = [];
  for (let offset = 0; ; offset += PAGE) {
    const data = execute(
      `query Export { ${root}(orderBy: [{ id: ASC }], limit: ${PAGE}, offset: ${offset}) { ${fields} } }`,
    );
    const page = data[root];
    if (!Array.isArray(page)) throw new Error(`Unexpected response for ${root}: ${JSON.stringify(data).slice(0, 300)}`);
    rows.push(...page);
    if (page.length < PAGE) break;
  }
  fs.mkdirSync(OUT, { recursive: true });
  fs.writeFileSync(path.join(OUT, `${type}.json`), JSON.stringify(rows));
  console.log(`${type.padEnd(34)} ${String(rows.length).padStart(6)} rows`);
}

const jobs = [{ type: users.type }];
for (const c of collections) {
  jobs.push({ type: c.type });
  for (const ch of c.children || []) jobs.push({ type: ch.type, child: true });
}
for (const j of jobs) {
  if (only && !only.has(j.type)) continue;
  exportType(j.type, j.child);
}
console.log(`\nExported to ${OUT}`);
