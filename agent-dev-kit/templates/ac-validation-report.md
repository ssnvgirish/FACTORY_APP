# AC Validation Report Template

Final deliverable proving all acceptance criteria from the Jira story are satisfied. Include this in the PR description or as a PR comment.

---

## Story Reference

- **Ticket**: [KONNECT-XXXX]
- **Title**: [story title]
- **Story Type**: feature / bug / refactor

## Acceptance Criteria Results

| AC # | Criterion | Evidence | Result |
|------|-----------|----------|--------|
| AC-1 | [criterion text] | [test name + pass, or manual evidence] | PASS / FAIL / DEFERRED |
| AC-2 | [criterion text] | [test name + pass, or manual evidence] | PASS / FAIL / DEFERRED |
| AC-3 | [criterion text] | [test name + pass, or manual evidence] | PASS / FAIL / DEFERRED |

## Validation Commands Run

```
flutter analyze                                    → pass / fail
flutter test test/src/features/<feature>/          → X passed, Y failed
flutter pub run build_runner build                 → pass / N/A
```

## Test Summary

| Category | Count |
|----------|-------|
| New tests added | 0 |
| Existing tests modified | 0 |
| Total tests run | 0 |
| Passed | 0 |
| Failed | 0 |

## AC Coverage

| Metric | Value |
|--------|-------|
| Total ACs | 0 |
| ACs with automated tests | 0 |
| ACs manually verified | 0 |
| ACs deferred | 0 |
| **AC Pass Rate** | **0%** |

## Deferred Items

| AC # | Reason | Follow-Up Ticket |
|------|--------|-----------------|
| — | — | — |

## Residual Risks

- [risk and mitigation]

## Verdict

**All acceptance criteria satisfied**: YES / NO

If NO → list blockers and required actions.
