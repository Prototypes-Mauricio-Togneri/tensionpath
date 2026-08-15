# UI Rules

## Shared Styles

Repeated CSS across `.vue` files gets extracted into `src/assets/styles.css`. Component-specific overrides stay in scoped `<style>` blocks.

## Theme

Cold gunmetal instrumentation with amber telemetry. Design tokens are CSS custom properties on `:root` in `src/assets/styles.css`:

| Token                                  | Purpose                               |
| -------------------------------------- | ------------------------------------- |
| `--color-bg-deep` / `--color-bg` / `-raised` / `-surface` | Background depth levels  |
| `--color-text`, `--color-text-rgb`     | Body text                             |
| `--color-text-strong`                  | White — text on faction colour or on `--color-bg-deep` |
| `--color-accent`, `--color-accent-rgb` | Amber — telemetry, warnings, emphasis |
| `--color-border`                       | Hairline separators                   |
| `--color-track`                        | Neutral ground a meter uncovers as it drains |
| `--color-ally`, `--color-ally-rgb`     | The local player's faction            |
| `--color-enemy`, `--color-enemy-rgb`   | The opposing faction                  |

Ally and enemy are never used decoratively — they only ever mean faction ownership, so a glance at the battlefield reads unambiguously.

The canvas obeys the same tokens. It cannot resolve `var()`, so `src/renderer/theme.ts` reads them off `:root` once at startup and `withAlpha()` builds `rgba()` from the `-rgb` variants. Never write a colour literal into the renderer.

## Typography

- **Display/headings**: `Chakra Petch` — weights 600, 700
- **Body/UI**: `Chakra Petch` — weights 400, 500
- **Numeric/data**: `Electrolize` — used for all numeric readouts (health, resources, timers, costs)
- Loaded via Google Fonts `<link>` in `index.html`

## Color Format

Always use `rgba()`. No hex. Opaque colors use alpha `1` (e.g. `rgba(224, 82, 72, 1)`).

## CSS Units

Use `rem` for all `border-radius` values. No `px` (exception: `50%` for circles).

## UI/UX

Always use the `frontend-design` skill when changing the UI.

The match screen is landscape only, and deployment is drag-only — a match needs a pointer.

## Accessibility

Not handled for the moment. The prototype assumes a sighted player with a pointer, so there are no ARIA attributes, focus styles, keyboard paths, reduced-motion handling, or screen-reader affordances anywhere in the app.

Do not add any unless it is explicitly asked for — this overrides the accessibility floor the `frontend-design` skill builds to.

## Comment Conventions

**Section Dividers** — Major sections use decorated block comments:

```css
/* ============================================
   Section Name
   ============================================ */
```

**Rule Comments** — Single-line comment above the rule:

```css
/* Animated background */
.background-element::before {
```

**Guidelines:**

- Place comments above the rule they describe
- Use short, descriptive phrases (not full sentences)
- Focus on visual/functional purpose, not technical implementation
- Group related selectors together (base rule, pseudo-elements, states)
- Place keyframe animations near their corresponding animation properties
