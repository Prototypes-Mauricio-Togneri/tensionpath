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

| File                 | Covers                       | `types`        |
| -------------------- | ---------------------------- | -------------- |
| `tsconfig.app.json`  | `src/**/*.ts`, `src/**/*.vue` | `vite/client`  |
| `tsconfig.node.json` | `vite.config.ts`             | `node`         |

Keeping them apart is what stops Node globals such as `process` from typechecking inside `src/`. Compiler options that should apply everywhere have to be set in both files.

## Build & deploy

`npm run build` typechecks both projects with `vue-tsc --build` and writes straight into `../backend/public`, the directory Firebase Hosting serves. `npm run deploy` runs the build, then deploys hosting from `../backend` against the `remote` Firebase project.
