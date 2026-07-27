# Specs

This document contains the specifications of the game, divided into sections.

The simulation is owned by the local engine (`src/engine/`), which is authoritative. This document describes the game rules; clients render the snapshots it broadcasts and send commands against them. See `docs/architecture.md`.

## Units

Each unit type is defined by:

- Deployment cost
- Health
- Attack type
- Damage
- Damage effect: single/splash
- Armor type: light/medium/heavy
- Visibility range
- Attack range
- Size: radius in battlefield units — the renderer draws it and the client previews a deployment with it
- Speed: battlefield units per second

The roster itself is undecided. `scout`, `ranger` and `lancer` exist as placeholders so deployment, the economy and the renderer have something to work with, and are replaced wholesale once the real roster lands. Each is a different reason to spend rather than three points on one power curve: the scout is speed, the ranger is reach, the lancer is weight.

## Nodes

Points on the battlefield that units interact with:

- Launcher
- Platform
- Missile
- Resources
- Obstacle: slows down or removes health
- Victory
- Chest
- Resource generator
- Unit generator
- Checkpoint

No node is placed on the battlefield yet. The kinds above are decided but their positions are not, and a placeholder layout only teaches players a shape that is about to change. The plumbing is wired end to end — ownership travels in every snapshot and the renderer draws whatever the layout holds — so the real map is a matter of filling the list in `createDefaultBattlefield()`.

## Commands

Actions a player can issue:

- Deploy unit
- Stop unit movement
- Resume unit movement
- Switch unit target
- Switch lane
- Activate unit ability

## Economy

- Players start holding enough to afford the cheapest unit at the whistle, so no match opens on an empty field waiting for income — implemented
- Base income starts at 2 T/s and accelerates by +0.2 T/s every 30 seconds, up to a max of 3 T/s — implemented
- Income per harvester increases from 1.5 T/s at the start of the game to a max of 4 T/s at 150 seconds — an increase of 0.7 T/s every 30 seconds — not implemented; it waits on a harvester existing in the roster

## UI

- **Left rail**
  - Unit selector — one card per unit in the roster, ordered by cost. A card is a handle, not a button: a unit reaches the field by being dragged onto it, and the cards are not clickable
  - Resource indicator — what is in hand, in the same coin every card is priced in
- **Top bar**
  - Both bases, drawn as the share of the bar each player still holds. They drain inward toward the clock, so the neutral ground between them widens as the match wears on and the two remaining lengths can be compared across the middle
  - Match clock, counting up — nothing ends a match on time, so it is a reference for the economy rather than a deadline
- **Battlefield**
  - The canvas the match is played on
  - Frame rate, in the bottom right corner

## Open questions

Undecided rules. Resolve before the match screen is built.

- Can units overlap?
- Fog of war?
- Can units be stopped (cost 1)?
- Can units switch lanes (cost 1)?
- Units cannot be stopped while in a node
- Limitations
  - Cooldown: a unit type can be deployed every X seconds
  - Popcap: limit the total number of units on the battlefield
