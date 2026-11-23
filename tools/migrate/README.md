# Data Connect (Cloud SQL) → Firestore + Auth migration

Two steps, no direct database connection and no gcloud needed (the Cloud SQL
ports are blocked on many networks; this uses HTTPS only):

1. `export.js` reads every table through `firebase dataconnect:execute`.
2. `index.js` converts, validates against `dataconnect/schema/schema.gql`, creates
   Firebase Auth users, writes Firestore, rebuilds the stock counters and
   verifies counts.

Passwords are used only to create Auth accounts (`prb#<password>`) and are never
written to Firestore.

## Prerequisites
- `firebase login` as an Owner/Editor of `prabitha-operations`. The scripts use that
  stored login in memory only (see `credentials.js`); nothing is copied or logged.
  Alternatively set `GOOGLE_APPLICATION_CREDENTIALS`.
- Firestore database created.
- **Firebase console → Authentication → Get started → enable Email/Password.**
- `npm install` in this folder.

## Run
```bash
node export.js                 # -> export/*.json (clear-text passwords! gitignored)
node index.js --dry-run        # validate everything, write nothing
node index.js                  # migrate, then verify counts
node index.js --verify-only    # compare Firestore counts with the export
rm -rf export .tmp             # when done
```
Re-running is safe: documents keep their original ids and Auth users are matched
by email. Exit code is 1 on any validation problem or count mismatch.
