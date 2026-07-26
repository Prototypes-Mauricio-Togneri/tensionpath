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

## Commands

Actions a player can issue:

- Deploy unit
- Stop unit movement
- Resume unit movement
- Switch unit target
- Switch lane
- Activate unit ability

## Economy

- Base income starts at 2 T/s and accelerates by +0.2 T/s every 30 seconds, up to a max of 3 T/s
- Income per harvester increases from 1.5 T/s at the start of the game to a max of 4 T/s at 150 seconds — an increase of 0.7 T/s every 30 seconds

## UI

- **Top**
  - Player name
  - Base health
- **Middle**
  - Map
- **Bottom**
  - Unit selector
  - Resource indicator
  - Player name
  - Base health

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
