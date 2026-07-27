# Architecture & Design

Vite + Vue 3 single-page application using Composition API (`<script setup>`) and TypeScript. Screens are routed with Vue Router in history mode.

## Local authoritative engine

There is no server. The prototype is a single frontend app played against the computer. It still keeps the authority split a server would impose, so a server can be introduced later without reshaping the client.

The engine owns the match. Clients — the player's UI and the bot — hold a `Transport` and never the engine itself:

```
player input ──▶ Input ──▶ command ──┐
                                     ▼
                                 Transport ──▶ MatchEngine ── owns MatchState
                                     │          (authority)    20 Hz, fixed dt
screen ◀── Renderer ◀── snapshot ◀───┘                │
                                                      │
                  BotClient ◀──▶ Transport ◀──────────┘
```

- **Engine** (`src/engine/`) — the authoritative simulation, playing the role a match server would. Sole owner of `MatchState`; advances on a fixed timestep and broadcasts a snapshot per tick.
- **Transport** (`src/domain/protocol/`) — the client's entire view of the authority: `send(command)` and `onMessage(handler)`. `LocalTransport` wires a client to an engine in the same tab; a `SocketTransport` would drop in beside it without touching a client.
- **Input** (`src/input/`) — captures player interaction and turns it into commands.
- **Renderer** (`src/renderer/`) — draws the battlefield to a `<canvas>` with the 2D context, sampling between the last two snapshots on every frame. Vector shapes only, at unit counts a GL pipeline would not earn back. `Viewport` is the sole holder of screen knowledge: it fits the battlefield's own coordinate space into whatever the canvas element is given, and converts back for pointer input. Colours are read once from the `:root` design tokens (`theme.ts`) rather than restated, since a canvas cannot resolve `var()`.
- **Bot** (`src/bot/`) — the computer opponent. A client like any other: it observes snapshots and issues commands through its own `Transport`, so it is fair by construction and can be hosted server-side later unchanged.
- **Session** (`src/session/`) — the composition root. `createLocalSession()` builds the engine, attaches both clients, and returns a `Session` (`transport` + `dispose`). A future `createRemoteSession()` returns the same type.

### Invariants

These are what make the split real rather than decorative. Most are enforced in `eslint.config.js`.

- **Commands are fire-and-forget.** `send` returns nothing. An authority broadcasts state, it does not answer calls; a command's outcome appears in a later snapshot or as a `rejected` event.
- **No shared references.** `LocalTransport` JSON round-trips every payload in both directions, so neither side can hold a reference into the other's data. JSON is deliberately narrower than `structuredClone`: a `Map` or `Set` collapses to `{}`, a `Date` becomes a string, methods and `undefined` fields disappear. Nothing that is not wire-safe survives the copy, so the mistake breaks now rather than on the day a socket arrives.
- **State is the wire format.** `MatchState` is plain data and rules are free functions over it, so there is no DTO layer and no mapping to keep in sync.
- **The engine is portable.** No DOM, no Vue, no storage — so it runs unchanged in Node behind a socket, or in a worker. The tick accumulator reads a clock only to decide how many steps to run; the simulation always advances by exactly `TICK_INTERVAL_SECONDS`.
- **Determinism.** `Math.random` is banned in `src/engine/`; randomness comes from `nextRandom`, whose seed lives in `MatchState`. A match replays exactly from its seed plus a recorded command log, and `MatchEngine.step()` is public so a replay harness can drive it without a timer.
- **Clients never import the engine.** Only `src/session/` may import both sides.
- **Per-player views.** The engine addresses each snapshot with `viewFor(playerId)` and each event list with `eventsFor(playerId, …)`. `viewFor` is identity today; if fog of war lands (see `docs/specs.md` open questions) it is the one function that changes.

## Source layout

| Path                      | Contents                                                            |
| ------------------------- | ------------------------------------------------------------------- |
| `src/main.ts`             | Entry point — creates the app, installs the router, mounts          |
| `src/app.vue`             | Root shell, renders `<RouterView />`                                |
| `src/router.ts`           | Route table                                                         |
| `src/components/screens/` | One component per screen                                            |
| `src/components/match/`   | HUD pieces the match screen composes                                |
| `src/domain/entities/`    | Plain-data game types; a snapshot is exactly these                  |
| `src/domain/protocol/`    | `Command`, `ServerMessage`, `MatchEvent`, the `Transport` interface |
| `src/domain/types/`       | Enums, unions and id aliases                                        |
| `src/engine/`             | Authoritative simulation, tick loop, balancing, `LocalTransport`    |
| `src/bot/`                | The computer opponent — a client, not part of the engine            |
| `src/session/`            | Composition root: wires engine and clients, returns a `Session`     |
| `src/input/`              | Player interaction → commands                                       |
| `src/renderer/`           | Drawing, interpolating between snapshots                            |
| `src/i18n/`               | Locale tables and the `t()` helper                                  |
| `src/assets/`             | Global stylesheet and static assets                                 |

`src/domain/` holds everything both sides of the boundary agree on, and nothing else. There is no DTO layer: because `MatchState` is already wire-safe plain data, the engine's state types and the protocol's payload types are the same types.

## Screens

| Route    | Component          | Status                              |
| -------- | ------------------ | ----------------------------------- |
| `/`      | `home_screen.vue`  | Title and the way into a match      |
| `/match` | `match_screen.vue` | Canvas battlefield, HUD, deployment |

`match_screen.vue` is the only component that builds a session. It owns the canvas, hands the same `Transport` to the renderer and the input controller, and tears all three down on unmount. History mode requires the catch-all rewrite in `../backend/firebase.json`.

## TypeScript projects

`tsconfig.json` holds no sources of its own — it references two projects so browser and build-tooling code get different globals:

| File                 | Covers                        | Extends                           | `types`       |
| -------------------- | ----------------------------- | --------------------------------- | ------------- |
| `tsconfig.app.json`  | `src/**/*.ts`, `src/**/*.vue` | `@vue/tsconfig/tsconfig.dom.json` | `vite/client` |
| `tsconfig.node.json` | `vite.config.ts`              | `@tsconfig/node24`                | `node`        |

Keeping them apart is what stops Node globals such as `process` from typechecking inside `src/`. Each file extends the official base for its environment, so `strict`, `skipLibCheck`, `target` and `lib` are inherited rather than restated. Two things still have to live in the project files: the extra strictness layered on top (`noUncheckedIndexedAccess`, `noUnusedLocals`, `noUnusedParameters`, `noFallthroughCasesInSwitch`, `noImplicitOverride`), which must be listed in both; and, in `tsconfig.node.json` alone, `noEmit`, `verbatimModuleSyntax` and the bundler module settings, none of which `@tsconfig/node24` provides.

`target` is left to the bases (`esnext` for the app, `es2024` for Node) — the app's `lib` stays at ES2022, and what actually ships is decided by Vite's `build.target`, not by TypeScript.

## Build & deploy

`npm run dev` serves the app with Vite's dev server and nothing else attached — no devtools overlay or component inspector. Use the Vue DevTools browser extension when component inspection is needed.

`npm run build` typechecks both projects with `vue-tsc --build` and writes straight into `../backend/public`, the directory Firebase Hosting serves. `npm run deploy` runs the build, then deploys hosting from `../backend` against the `remote` Firebase project.
