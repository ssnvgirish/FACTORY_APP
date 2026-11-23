# Firestore cutover checklist

Status as of 2026-11-23 (branch `feat/firestore-migration`)

- [x] Firestore database `(default)` in asia-south1, rules + 23 composite indexes deployed, rules tests pass
- [x] Authentication initialised, Email/Password sign-in enabled
- [x] All data migrated and count-verified: 7 users (Auth + profiles), 17 master tables, 25 report types, stock counters
- [x] App rewritten on Firestore/Auth; Data Connect SDK, seed tooling and the password-bypass flag removed
- [x] `flutter analyze` clean of errors, `flutter test` 435 passing, macOS debug build OK
- [x] Live check: migrated admin signs in with phone + original password, reads profile/masters/stock; unauthenticated reads denied

## Before releasing to operators
- [ ] Run the app (`flutter run`) and log in as an operator and as an admin; compare dashboard totals with the old app
- [ ] Submit one report per family; delete a production report and confirm dashboard stock moves back
- [ ] Admin: create a test user and log in as them; rename a test master value and confirm weights follow
- [ ] Salary page for a frame, sheet and scrap operator
- [ ] Because operators may still write to the old database until they update, re-run at release time:
      `cd tools/migrate && node export.js && node index.js` (idempotent), then `rm -rf export .tmp`
- [ ] Watch Firestore usage (console -> Firestore -> Usage) for a week; Spark limits are 50K reads / 20K writes per day

## Decommission (only when the above is done and you say so)
- [ ] Final SQL export into `tools/sql/backup/<date>/`
- [ ] Delete the Cloud SQL instance and the Data Connect service, remove `dataconnect/` and the `dataconnect` key in `firebase.json`
- [ ] Confirm the billing page shows no Cloud SQL charges
