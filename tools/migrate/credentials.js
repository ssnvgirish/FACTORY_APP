'use strict';
// Builds a firebase-admin credential from the account you are already signed in
// with in the Firebase CLI (`firebase login`). The refresh token is read from the
// CLI's own config file at run time and is held in memory only — it is never
// copied, logged, or written anywhere by this tool.
//
// Set GOOGLE_APPLICATION_CREDENTIALS to use a service account / ADC instead.

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const admin = require('firebase-admin');

// Public OAuth client of the open-source Firebase CLI (firebase-tools/lib/api.js).
const CLI_CLIENT_ID = '563584335869-fgrhgmd47bqnekij5i8b5pr03ho849e6.apps.googleusercontent.com';
const CLI_CLIENT_SECRET = 'j9iVZfS8kkCEFUPaAeJV0sAi';

function loadCli() {
  const file = path.join(os.homedir(), '.config', 'configstore', 'firebase-tools.json');
  let cfg;
  try { cfg = JSON.parse(fs.readFileSync(file, 'utf8')); } catch {
    throw new Error('Cannot read the Firebase CLI login. Run `firebase login` first.');
  }
  const refresh = cfg.tokens && cfg.tokens.refresh_token;
  if (!refresh) throw new Error('Firebase CLI is not logged in. Run `firebase login` first.');
  console.log(`Using Firebase CLI login: ${cfg.user && cfg.user.email}`);
  return {
    type: 'authorized_user',
    client_id: CLI_CLIENT_ID,
    client_secret: CLI_CLIENT_SECRET,
    refresh_token: refresh,
  };
}

/** Credential for the Firebase Auth admin API. */
function credential() {
  if (process.env.GOOGLE_APPLICATION_CREDENTIALS) return admin.credential.applicationDefault();
  return admin.credential.refreshToken(loadCli());
}

/** Settings for `new Firestore(...)` (firebase-admin refuses user credentials for Firestore). */
function firestoreSettings(projectId) {
  if (process.env.GOOGLE_APPLICATION_CREDENTIALS) return { projectId };
  const { GoogleAuth } = require('google-auth-library');
  return { projectId, auth: new GoogleAuth({ credentials: loadCli() }) };
}

module.exports = { credential, firestoreSettings };
