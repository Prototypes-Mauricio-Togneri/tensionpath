## Project

The frontend of Tension Path — a real-time tactical strategy game (Vite + Vue 3, TypeScript, Composition API with `<script setup>`, ESLint + @stylistic + type-aware typescript-eslint via @vue/eslint-config-typescript).

There is no server. The app ships its own authoritative engine and the prototype is single-player against the computer, but the client/authority split is kept so a server can be added later.

## Reference Docs

- `docs/specs.md` — game specs: units, nodes, commands, economy, UI. Read when working on game rules.
- `docs/architecture.md` — client/authority boundary, the `Transport` contract and its invariants, source layout, screen flow. Read when working on related areas.
- `docs/typescript.md` — style, naming, imports, constants. Read when editing TypeScript files.
- `docs/ui.md` — shared styles, colors, CSS units, accessibility stance, frontend-design skill. Read when editing Vue components or CSS.

## Rules

- **After completing code changes**: Run `npm run lint:fix` and fix remaining errors, run `npm run build` (typechecks first) and fix any failures, then run `/delta-review` before responding.
- **Client/engine boundary**: `src/engine/` is authoritative and stays plain TypeScript — no DOM, Vue or storage — so it can run outside a browser. Clients (`src/input/`, `src/renderer/`, `src/components/`, `src/bot/`) hold a `Transport` and must never import `src/engine/`; only `src/session/` imports both sides. `Math.random` is banned in the engine, use `nextRandom`. Enforced in `eslint.config.js`; rationale in `docs/architecture.md`.
- **No accessibility**: Accessibility is not handled for the moment — no ARIA, focus styles, keyboard paths, or reduced-motion handling. Do not add any unless explicitly asked. See `docs/ui.md`.
- **No test suite**: This project has no tests by design. TypeScript and the type-aware lint rules are the safety net — do not weaken `strict` or `noUncheckedIndexedAccess`, and do not add `any` to silence an error.
- **TypeScript projects**: `tsconfig.json` only references `tsconfig.app.json` (browser, `src/`, extends `@vue/tsconfig/tsconfig.dom.json`) and `tsconfig.node.json` (`vite.config.ts`, extends `@tsconfig/node24`). An option the two bases don't already cover must be set in both. See `docs/architecture.md`.
- **Doc Maintenance**: After changes, check if `AGENTS.md`, `docs/architecture.md`, `docs/specs.md`, and `docs/typescript.md` need updating.
