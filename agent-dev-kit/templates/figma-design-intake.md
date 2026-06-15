# Figma Design Intake Template

Use this template when the user provides Figma screens, design specs, screenshots, or UI mockups as input for implementation.

---

## Instructions

When the user provides Figma designs (links, screenshots, or descriptions):
1. Extract all visual and interaction specs below.
2. Map each screen/component to a widget in the feature structure.
3. Identify design tokens (colors, typography, spacing) and map to existing theme/tokens.
4. Produce a widget tree plan before implementing.

---

## Design Reference

| Field | Value |
|-------|-------|
| Figma Link | [URL or "screenshot provided"] |
| Screen Name(s) | [e.g. "Saved Items — Empty", "Saved Items — List"] |
| Platform | iOS / Android / both |
| Variant/State | default / loading / empty / error / [custom] |
| Design System Version | [if known] |

## Screen Inventory

List every distinct screen or state shown in the design:

| # | Screen / State | Description | Priority |
|---|---------------|-------------|----------|
| S-1 | [name] | [what is shown] | must-have / nice-to-have |
| S-2 | [name] | [what is shown] | must-have / nice-to-have |

## Component Breakdown

Break each screen into components/widgets:

### Screen: [Screen Name]

```
[ScreenName]Page
├── AppBar (title, actions)
├── Body
│   ├── [ComponentA]Widget
│   │   ├── [element: icon/text/image]
│   │   └── [element: button/action]
│   ├── [ComponentB]Widget
│   │   ├── [element]
│   │   └── [element]
│   └── [ComponentC]Widget
└── BottomAction (if any)
```

## Design Tokens Mapping

Map design values to existing app theme or note new tokens needed:

| Design Element | Figma Value | Maps To (Existing) | New Token Needed? |
|---------------|-------------|--------------------|--------------------|
| Primary button color | #XXXX | `AppColors.primary` | no |
| Title font | [font/size/weight] | `AppTextStyles.heading2` | no |
| Card spacing | 16px | `AppSpacing.md` | no |
| [element] | [value] | [existing or TBD] | yes/no |

### Rules for Token Mapping
- Always prefer existing theme tokens over hardcoded values.
- If a design value has no existing token match, check if it's close enough to an existing token (within 2px/1 shade).
- Only create new tokens if explicitly required and the value is reused across multiple components.
- Note deviations from existing design system for reviewer awareness.

## Interaction Specs

| # | Trigger | Action | Animation/Transition | Notes |
|---|---------|--------|---------------------|-------|
| I-1 | Tap [element] | [navigate / dispatch event / show dialog] | [fade / slide / none] | |
| I-2 | Swipe [element] | [dismiss / reveal action] | [slide] | |
| I-3 | Long press [element] | [show menu / select] | [none] | |
| I-4 | Pull down | [refresh] | [indicator] | |

## Responsive / Adaptive Behavior

| Breakpoint | Behavior |
|-----------|----------|
| Mobile (default) | [layout description] |
| Tablet (if applicable) | [layout changes] |
| Landscape (if applicable) | [layout changes] |

## Accessibility Specs (From Design)

- [ ] Sufficient color contrast (4.5:1 for text)
- [ ] Touch targets ≥ 44x44 logical pixels
- [ ] Semantic labels provided for icons/images
- [ ] Focus order logical (top-to-bottom, left-to-right)
- [ ] Any motion/animation respects `reduceMotion`

## Widget-to-File Mapping

Map extracted components to the feature file structure:

| Widget | File Path | New/Existing |
|--------|-----------|-------------|
| [FeatureName]Page | `lib/src/features/[feature]/ui/pages/[feature]_page.dart` | new / existing |
| [Component]Widget | `lib/src/features/[feature]/ui/widgets/[component]_widget.dart` | new / existing |
| [Component]Widget | `lib/src/features/[feature]/ui/widgets/[component]_widget.dart` | new / existing |

## State-to-Screen Mapping

Map BLoC states to the screens/variants shown in the design:

| BLoC State | Screen / Variant | Key UI Elements |
|-----------|-----------------|-----------------|
| `Initial[Feature]State` | — (not rendered, transitions immediately) | — |
| `Loading[Feature]State` | Loading skeleton / spinner | [describe] |
| `[Feature]LoadedState` | Main content | [list elements] |
| `[Feature]EmptyState` | Empty illustration + message | [describe] |
| `[Feature]ErrorState` | Error message + retry button | [describe] |

## Design QA Checklist (Post-Implementation)

- [ ] All screens from design are implemented
- [ ] All states (loading, empty, error, loaded) match design
- [ ] Colors/typography match design tokens (no hardcoded values)
- [ ] Spacing/padding matches design specs
- [ ] Interactions match interaction specs
- [ ] Accessibility requirements met
- [ ] Widget tests cover each state's visual output

## Integration With AC Workflow

When Figma designs accompany a Jira story:
1. Map each AC to the specific screen/component it describes.
2. Use the widget test to prove UI-related ACs.
3. Reference screen # (S-1, S-2) in the AC traceability matrix.

| AC # | Related Screen(s) | Widget(s) to Test |
|------|-------------------|-------------------|
| AC-X | S-1 | [Widget]_test.dart → "renders [element]" |
| AC-Y | S-2 | [Widget]_test.dart → "shows empty state" |
