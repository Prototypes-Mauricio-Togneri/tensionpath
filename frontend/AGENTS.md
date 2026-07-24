## Project

The frontend of Tension Path — a real-time tactical strategy game (Vite + Vue 3, TypeScript, Composition API with `<script setup>`, ESLint + @stylistic + typescript-eslint).

## Reference Docs

- `docs/specs.md` — game specs: units, nodes, commands, economy, UI. Read when working on game rules.
- `docs/architecture.md` — Input/Engine/Renderer split, source layout, screen flow. Read when working on related areas.
- `docs/typescript.md` — style, naming, imports, constants. Read when editing TypeScript files.
- `docs/ui.md` — shared styles, colors, CSS units, frontend-design skill. Read when editing Vue components or CSS.

## Rules

- **After completing code changes**: Run `npm run lint:fix` and fix remaining errors, run `npm run build` (typechecks first) and fix any failures, then run `/delta-review` before responding.
- **No test suite**: This project has no tests by design. TypeScript is the safety net — do not weaken `strict` or add `any` to silence an error.
- **Doc Maintenance**: After changes, check if `CLAUDE.md`, `docs/architecture.md`, and `docs/specs.md` need updating.
