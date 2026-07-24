# Architecture & Design

Vite + Vue 3 single-page application using Composition API (`<script setup>`) and TypeScript. Screens are routed with Vue Router in history mode.

## Server-authoritative model

The Dart match server (`../server`) owns the simulation. This app is a client:

```
player input ──▶ Input ──▶ Engine ──▶ Renderer ──▶ screen
                             ▲
                             └── websocket state updates from ../server
```

- **Input** (`src/input/`) — captures player interaction and turns it into commands sent to the server.
- **Engine** (`src/engine/`) — owns the connection and the current match state, applies incoming updates, and drives the frame loop.
- **Renderer** (`src/renderer/`) — draws the current state. Vector graphics; the specific technique is not yet chosen.

## Source layout

| Path                      | Contents                                                        |
| ------------------------- | --------------------------------------------------------------- |
| `src/main.ts`             | Entry point — creates the app, installs the router, mounts      |
| `src/app.vue`             | Root shell, renders `<RouterView />`                            |
| `src/router.ts`           | Route table                                                     |
| `src/components/screens/` | One component per screen                                        |
| `src/domain/entities/`    | Game entities, mirroring `../server/lib/domain/entities/`       |
| `src/domain/json/`        | Websocket protocol DTOs, mirroring `../server/lib/domain/json/` |
| `src/domain/types/`       | Enums and unions, mirroring `../server/lib/domain/types/`       |
| `src/engine/`             | Connection, match state, frame loop                             |
| `src/input/`              | Player input → server commands                                  |
| `src/renderer/`           | Drawing                                                         |
| `src/i18n/`               | Locale tables and the `t()` helper                              |
| `src/assets/`             | Global stylesheet and static assets                             |

`src/domain/` deliberately mirrors the Dart server's `lib/domain/` layout so a protocol change has an obvious counterpart file on each side.

## Screens

| Route | Component         | Status            |
| ----- | ----------------- | ----------------- |
| `/`   | `home_screen.vue` | Empty placeholder |

The match screen is not built yet. History mode requires the catch-all rewrite in `../backend/firebase.json`.

## TypeScript projects

`tsconfig.json` holds no sources of its own — it references two projects so browser and build-tooling code get different globals:

| File                 | Covers                        | Extends                            | `types`       |
| -------------------- | ----------------------------- | ---------------------------------- | ------------- |
| `tsconfig.app.json`  | `src/**/*.ts`, `src/**/*.vue` | `@vue/tsconfig/tsconfig.dom.json`  | `vite/client` |
| `tsconfig.node.json` | `vite.config.ts`              | `@tsconfig/node24`                 | `node`        |

Keeping them apart is what stops Node globals such as `process` from typechecking inside `src/`. Each file extends the official base for its environment, so `strict`, `skipLibCheck`, `target` and `lib` are inherited rather than restated. Two things still have to live in the project files: the extra strictness layered on top (`noUncheckedIndexedAccess`, `noUnusedLocals`, `noUnusedParameters`, `noFallthroughCasesInSwitch`, `noImplicitOverride`), which must be listed in both; and, in `tsconfig.node.json` alone, `noEmit`, `verbatimModuleSyntax` and the bundler module settings, none of which `@tsconfig/node24` provides.

`target` is left to the bases (`esnext` for the app, `es2024` for Node) — the app's `lib` stays at ES2022, and what actually ships is decided by Vite's `build.target`, not by TypeScript.

## Build & deploy

`npm run dev` serves the app with `vite-plugin-vue-devtools` attached — component inspector and timeline, toggled with `Alt+Shift+D` or opened standalone at `/__devtools__/`. It is dev-only and leaves no trace in the production bundle.

`npm run build` typechecks both projects with `vue-tsc --build` and writes straight into `../backend/public`, the directory Firebase Hosting serves. `npm run deploy` runs the build, then deploys hosting from `../backend` against the `remote` Firebase project.
