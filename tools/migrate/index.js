'use strict';
// Imports the Data Connect export (see export.js) into Firestore + Firebase Auth.
//
//   node index.js --dry-run      read export, validate against schema.gql, write nothing
//   node index.js                migrate, then verify counts against the export
//   node index.js --verify-only  compare Firestore counts with the export only
//
// Exit code is 1 on any validation problem or count mismatch.

const fs = require('node:fs');
const path = require('node:path');
const admin = require('firebase-admin');

const { users, collections } = require('./config');
const { convertDoc, normalizePhone, emailFor, passwordFor } = require('./transform');
const { parseSchema, missingFields, timestampFields } = require('./schema');
const { buildStock } = require('./stock');
const { Firestore, Timestamp } = require('@google-cloud/firestore');
const { credential, firestoreSettings } = require('./credentials');

const dryRun = process.argv.includes('--dry-run');
const verifyOnly = process.argv.includes('--verify-only');
const EXPORT = path.join(__dirname, 'export');
const PROJECT = process.env.GOOGLE_CLOUD_PROJECT || 'prabitha-operations';

const schema = parseSchema(
  fs.readFileSync(path.join(__dirname, '../../dataconnect/schema/schema.gql'), 'utf8'),
);
const load = (type) => JSON.parse(fs.readFileSync(path.join(EXPORT, `${type}.json`), 'utf8'));

async function main() {
  const needAdmin = !dryRun;
  let db; let auth; let toTimestamp = (d) => d;
  if (needAdmin) {
    admin.initializeApp({ projectId: PROJECT, credential: credential() });
    db = new Firestore(firestoreSettings(PROJECT));
    auth = admin.auth();
    toTimestamp = (d) => Timestamp.fromDate(d);
  }
  const problems = [];
  const migrated = {}; // collection -> converted docs (for the stock rebuild)
  const expected = {}; // collection -> row count in the export

  if (!verifyOnly) {
    const writer = needAdmin ? db.bulkWriter() : null;
    if (writer) {
      writer.onWriteError((e) => {
        problems.push(`write failed ${e.documentRef.path}: ${e.message}`);
        return false;
      });
    }

    // ── users + Auth accounts ──
    const userRows = load(users.type);
    expected.users = userRows.length;
    const seenEmails = new Set();
    for (const u of userRows) {
      const phone = normalizePhone(u.phone);
      const email = emailFor(phone);
      if (seenEmails.has(email)) problems.push(`users ${u.id}: duplicate login email ${email}`);
      seenEmails.add(email);
      let authUid = `dry-${u.id}`;
      if (!dryRun) {
        try {
          authUid = (await auth.createUser({ email, password: passwordFor(u.password), displayName: u.name })).uid;
        } catch (e) {
          if (e.code !== 'auth/email-already-exists') throw e;
          authUid = (await auth.getUserByEmail(email)).uid;
          await auth.updateUser(authUid, { password: passwordFor(u.password) });
        }
      }
      const body = convertDoc(u, {
        drop: ['password'],
        timestampFields: timestampFields(schema, users.type),
        toTimestamp,
      });
      body.phone = phone;
      body.email = body.email || '';
      body.roles = u.roles || [];
      body.assignedMachines = u.assignedMachines || [];
      const missing = missingFields(schema, users.type, { ...body, password: 'x' });
      if (missing.length) problems.push(`users ${u.id}: missing ${missing.join(',')}`);
      if (!dryRun) writer.set(db.collection(users.col).doc(authUid), body);
    }
    console.log(`users: ${userRows.length}`);

    // ── masters + reports (children embedded) ──
    for (const c of collections) {
      const rows = load(c.type);
      expected[c.col] = rows.length;
      const tsFields = timestampFields(schema, c.type);
      const childData = (c.children || []).map((ch) => ({
        ...ch,
        rows: load(ch.type),
        tsFields: timestampFields(schema, ch.type),
        used: 0,
      }));
      const parentIds = new Set(rows.map((r) => r.id));
      for (const ch of childData) {
        for (const x of ch.rows) {
          if (!x.report || !parentIds.has(x.report.id)) problems.push(`${ch.type} ${x.id}: orphan (no parent report)`);
        }
      }
      migrated[c.col] = [];
      for (const r of rows) {
        const body = convertDoc(r, { timestampFields: tsFields, toTimestamp });
        for (const ch of childData) {
          const mine = ch.rows.filter((x) => x.report && x.report.id === r.id);
          ch.used += mine.length;
          body[ch.key] = mine.map((x) => {
            const item = convertDoc(x, { drop: ['report'], timestampFields: ch.tsFields, toTimestamp });
            const miss = missingFields(schema, ch.type, item);
            if (miss.length) problems.push(`${ch.type} ${x.id}: missing ${miss.join(',')}`);
            return item;
          });
        }
        const miss = missingFields(schema, c.type, body);
        if (miss.length) problems.push(`${c.type} ${r.id}: missing ${miss.join(',')}`);
        migrated[c.col].push(body);
        if (!dryRun) writer.set(db.collection(c.col).doc(r.id), body);
      }
      for (const ch of childData) {
        if (ch.used !== ch.rows.length) {
          problems.push(`${ch.type}: embedded ${ch.used} of ${ch.rows.length} rows`);
        }
      }
      console.log(`${c.col}: ${rows.length}${childData.map((ch) => ` (+${ch.used} ${ch.key})`).join('')}`);
    }

    // ── stock counters ──
    for (const [kind, prod, pack] of [
      ['frame', 'frame_production_details_reports', 'frame_shift_packing_reports'],
      ['sheet', 'sheet_production_details_reports', 'sheet_shift_packing_reports'],
    ]) {
      const { totals, variants } = buildStock(kind, migrated[prod] || [], migrated[pack] || []);
      console.log(`stock ${kind}:`, JSON.stringify(totals), `${variants.length} variants`);
      if (!dryRun) {
        writer.set(db.collection('stock_totals').doc(kind), totals);
        for (const v of variants) {
          const { id, ...rest } = v;
          writer.set(db.collection('stock_variants').doc(id), rest);
        }
      }
    }
    if (writer) await writer.close();
  } else {
    expected.users = load(users.type).length;
    for (const c of collections) expected[c.col] = load(c.type).length;
  }

  // ── verification ──
  if (!dryRun) {
    for (const [col, n] of Object.entries(expected)) {
      const got = (await db.collection(col).count().get()).data().count;
      const ok = got === n;
      console.log(`${ok ? 'OK ' : 'BAD'} ${col}: export=${n} firestore=${got}`);
      if (!ok) problems.push(`count mismatch ${col}: export ${n} vs firestore ${got}`);
    }
    if (!verifyOnly) {
      const authCount = (await auth.listUsers(1000)).users.length;
      console.log(`auth users: ${authCount} (export users: ${expected.users})`);
    }
  }

  if (problems.length) {
    console.error('\nPROBLEMS:\n' + problems.slice(0, 50).join('\n'));
    process.exit(1);
  }
  console.log(dryRun ? '\nDry run OK (nothing written).' : '\nMigration verified.');
}

main().catch((e) => { console.error(e); process.exit(1); });
