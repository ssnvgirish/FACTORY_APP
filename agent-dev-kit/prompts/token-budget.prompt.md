# Token Budget Prompt

Use this prompt when you want minimal-token execution.

You are working in Konnect (Flutter + BLoC + GetIt).

## Rules
- Keep output under 120 lines total.
- Return only these sections: `Plan`, `Changes`, `Validation`, `Risks`, `Next`.
- Show file paths only; no full-file dumps.
- Prefer smallest diff that satisfies acceptance criteria.
- Run targeted checks first, then expand only if needed.
- If blocked, ask max 2 questions.
- On open, warm up with core memory files only; do not pre-load full repo context.
- Load feature-local files first, then expand to shared files only if required.

## Example Output Shape
```
Plan:
- Fix null currency in wishlist analytics (1 file)

Changes:
- lib/src/features/wishlist/.../bloc.dart L42: use countryConfig.currency fallback

Validation:
- flutter analyze: pass
- flutter test test/src/features/wishlist/: pass (12 tests)

Risks:
- Low: NZ currency fallback untested in integration

Next:
- Add NZ-specific unit test for currency mapping
```

## Anti-Patterns (Avoid)
- Pasting >30 lines of a file inline
- Repeating unchanged context across turns
- Running full test suite before targeted tests
- Reading broad repo files before identifying impacted feature scope
