# TypeScript Rules

## Style

- Do not use semicolons
- One class per file
- Unused parameters: use `_`, `__`, `___`, etc.

## Naming

- Files: `snake_case`
- Classes, interfaces, type aliases: `PascalCase`
- Functions: `camelCase`
- Variables: full descriptive names, avoid abbreviations
  - Allowed: `i`, `j` (loop counters), `x`, `y` (coordinates), `dx`, `dy` (deltas), `ctx` (canvas context)
  - Avoid: `p` (player), `u` (unit), `el` (element), `m` (missile), etc.

## Types

- `strict` and `noUncheckedIndexedAccess` are on and stay on. Do not add `any` to silence an error — this project has no test suite, so the type checker and the type-aware lint rules are the only automated safety net.
- Indexing a `Record` or array yields `T | undefined`. Handle the miss (`?? fallback`) rather than asserting it away with `!`.
- Everything in `src/domain/` crosses the client/engine boundary and must stay wire-safe plain data: no `Map`, `Set`, `Date`, class instance or optional-`undefined` field. Reference other entities by id, never by object reference. `LocalTransport` JSON round-trips every payload, so anything that is not wire-safe is stripped in transit and breaks immediately instead of surviving until a socket exists.
- Use `import type` for type-only imports (enforced by `@typescript-eslint/consistent-type-imports` and required by `verbatimModuleSyntax`).

## Imports

Always use the `@` path alias (mapped to `src/`). No relative paths (`./`, `../`). No file extensions.

## Getters

Prefer getters over methods for parameterless functions that only read instance state and return a computed value (no side effects).

## Centralized Constants

Numeric balancing values go in `src/engine/balancing.ts`. Structural constants (maps, sets, factory functions) and engine configuration such as the tick rate go in `src/engine/constants.ts`. Pure string enums, unions and id aliases go in `src/domain/types/`. Do not hardcode values in other files.

Both constant files are engine-owned and the client may not import them (enforced in `eslint.config.js`). The subset a client needs — costs, ranges, sizes, the tick rate, the deploy margin — travels in the `start` message as `MatchConfig`.

Purely visual constants are the client's own and belong to the module that draws with them: `src/renderer/constants.ts` for the canvas, and a `const` at the top of the file for anything used by one client alone. They never travel on the wire and the engine never sees them.

## Comment Conventions

**Class Level** — JSDoc block describing purpose:

```typescript
/**
 * Brief description of class purpose.
 * Additional context about role in the game architecture.
 */
class ClassName {
```

**Function Level** — JSDoc with parameters and return description (no types; TypeScript already declares them):

```typescript
/**
 * Brief description of what the method does.
 * @param paramName - Description
 * @returns Description
 */
methodName(paramName: string): number {
```

**Field Level** — Inline end-of-line comment on first declaration:

```typescript
this.x = 0; // Current X position
this.speed = config.speed; // Movement speed in units/second
```

**Code Block Level** — Plain comments for complex logic:

```typescript
// Interpolate toward the engine's authoritative position
```
