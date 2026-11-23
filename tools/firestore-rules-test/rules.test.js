const { test, before, after } = require('node:test');
const fs = require('node:fs');
const path = require('node:path');
const { initializeTestEnvironment, assertSucceeds, assertFails } =
  require('@firebase/rules-unit-testing');

let env;
before(async () => {
  env = await initializeTestEnvironment({
    projectId: 'rules-test',
    firestore: { rules: fs.readFileSync(path.join(__dirname, '../../firestore.rules'), 'utf8') },
  });
  await env.withSecurityRulesDisabled(async (ctx) => {
    const db = ctx.firestore();
    await db.doc('users/admin1').set({ uid: '+911', roles: ['admin'], isActive: true });
    await db.doc('users/op1').set({ uid: '+912', roles: ['machine_operator'], isActive: true });
    await db.doc('master_machines/m1').set({ name: 'Frame Machine 1' });
  });
});
after(async () => env.cleanup());

const as = (uid) => env.authenticatedContext(uid).firestore();
const anon = () => env.unauthenticatedContext().firestore();

test('anonymous cannot read or write anything', async () => {
  await assertFails(anon().doc('master_machines/m1').get());
  await assertFails(anon().doc('frame_cleaning_reports/r1').set({ a: 1 }));
});

test('signed-in operator can read masters and write reports, not masters/users', async () => {
  await assertSucceeds(as('op1').doc('master_machines/m1').get());
  await assertSucceeds(as('op1').doc('frame_cleaning_reports/r1').set({ a: 1 }));
  await assertSucceeds(as('op1').doc('stock_totals/frame').set({ totalProduced: 1 }));
  await assertFails(as('op1').doc('master_machines/m2').set({ name: 'x' }));
  await assertFails(as('op1').doc('users/op1').update({ roles: ['admin'] }));
});

test('admin can write masters and users', async () => {
  await assertSucceeds(as('admin1').doc('master_machines/m3').set({ name: 'y' }));
  await assertSucceeds(as('admin1').doc('users/newuser').set({ uid: '+913', roles: [] }));
});
