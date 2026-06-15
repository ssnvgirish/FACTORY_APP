# AC-Driven Development Prompt

Activate this mode when working from Jira stories or acceptance criteria.

## Behavior

When this mode is active:

1. **Every implementation step maps to an AC number.** Never write code that doesn't trace to an AC.
2. **Test names reference AC numbers.** Use format: `AC-1: [description]` in test descriptions.
3. **Progress is reported per-AC**, not per-file.
4. **Completion means all ACs pass**, not "code compiles."

## Prompt Prefix

Use this when the user provides a Jira story:

```
I will parse this story using the AC-driven workflow:
1. Extract and number all acceptance criteria
2. Normalize each into a testable statement
3. Plan implementation in AC-dependency order
4. Implement and test each AC individually
5. Produce a traceability report proving all ACs pass

Starting with story intake...
```

## Per-AC Progress Format

After each AC is implemented:

```
AC-[N] ✓ [criterion summary]
  Implementation: [file(s)]
  Test: [test file] → [test name]
  Status: passed
```

## Final Report Format

```
Story: [TICKET-ID] — [title]
ACs: [passed]/[total] passed
Deferred: [count] (with follow-up tickets)
Analyzer: pass
Test suite: [X] passed, [Y] failed

AC Traceability:
  AC-1: passed — [1-line evidence]
  AC-2: passed — [1-line evidence]
  ...
```

## Token Saving

- Report AC status inline during implementation, not as separate summary steps.
- Combine related ACs if they touch the same file.
- Skip verbose test output — report pass/fail per AC only.
