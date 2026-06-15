# AC Traceability Matrix Template

Use this template to track every acceptance criterion from intake through implementation, testing, and validation. This is the single source of truth for proving all ACs are satisfied.

## Story Reference

- Ticket: [KONNECT-XXXX]
- Title: [story title]
- Total ACs: [count]

## Traceability Matrix

| AC # | Acceptance Criterion | Implementation File(s) | Test File(s) | Test Name(s) | Validation Command | Status |
|------|---------------------|----------------------|-------------|-------------|-------------------|--------|
| AC-1 | [criterion text] | [file paths] | [test file paths] | [test names] | [command] | not-started / in-progress / passed / failed / manual-verified |
| AC-2 | [criterion text] | [file paths] | [test file paths] | [test names] | [command] | not-started / in-progress / passed / failed / manual-verified |
| AC-3 | [criterion text] | [file paths] | [test file paths] | [test names] | [command] | not-started / in-progress / passed / failed / manual-verified |

## Status Legend

- **not-started**: AC not yet addressed in code
- **in-progress**: Implementation started, tests not passing yet
- **passed**: Implementation complete, automated test(s) passing
- **failed**: Test(s) failing — requires fix
- **manual-verified**: Cannot be automated; verified manually with evidence
- **deferred**: Explicitly moved to a follow-up ticket (requires justification)

## Coverage Summary

| Metric | Count |
|--------|-------|
| Total ACs | 0 |
| Automated (passed) | 0 |
| Manual (verified) | 0 |
| Failed | 0 |
| Deferred | 0 |
| **Coverage %** | **0%** |

## Deferred ACs (Requires Justification)

| AC # | Reason | Follow-Up Ticket |
|------|--------|-----------------|
| — | — | — |

## Manual Verification Evidence

For ACs marked `manual-verified`, provide evidence:

| AC # | Evidence |
|------|----------|
| — | [screenshot description, log output, or behavioral description] |

## Gate: All ACs Satisfied?

- [ ] Every AC has status `passed`, `manual-verified`, or `deferred`
- [ ] No AC is `failed` or `not-started`
- [ ] Deferred ACs have follow-up tickets
- [ ] Coverage % meets team threshold (recommend ≥90% automated)

**Result**: pass / fail

If fail → do not proceed to PR. Fix failing ACs or get explicit approval to defer.
