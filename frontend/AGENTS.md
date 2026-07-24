## Project

The frontend of Tension Path — a real-time tactical strategy game (Vite + Vue 3, TypeScript, Composition API with `<script setup>`, ESLint + @stylistic + type-aware typescript-eslint via @vue/eslint-config-typescript).

## Reference Docs

- `docs/specs.md` — game specs: units, nodes, commands, economy, UI. Read when working on game rules.
- `docs/architecture.md` — Input/Engine/Renderer split, source layout, screen flow. Read when working on related areas.
- `docs/typescript.md` — style, naming, imports, constants. Read when editing TypeScript files.
- `docs/ui.md` — shared styles, colors, CSS units, frontend-design skill. Read when editing Vue components or CSS.

## Rules

- **After completing code changes**: Run `npm run lint:fix` and fix remaining errors, run `npm run build` (typechecks first) and fix any failures, then run `/delta-review` before responding.
- **No test suite**: This project has no tests by design. TypeScript and the type-aware lint rules are the safety net — do not weaken `strict` or `noUncheckedIndexedAccess`, and do not add `any` to silence an error.
- **TypeScript projects**: `tsconfig.json` only references `tsconfig.app.json` (browser, `src/`) and `tsconfig.node.json` (`vite.config.ts`). A shared compiler option must be set in both. See `docs/architecture.md`.
- **Doc Maintenance**: After changes, check if `CLAUDE.md`, `docs/architecture.md`, and `docs/specs.md` need updating.
