### TODO

- Vue project
- No testing
- Home + match screens
- Architecture
  - Input: receives the player input and sends it to the engine
  - Engine: runs the game logic (loop) and sends the updated state to the renderer
  - Renderer: receives the updated state and renders it to the screen
- Vector graphics
- Keep specs.md updated (CLAUDE.md rule)

## Unit properties

- Deployment cost
- Health
- Attack type
- Damage
- Damage effect: single/splash
- Armor type: light/medium/heavy
- Visibility range
- Attack range

## Nodes

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

- Deploy unit
- Stop unit movement
- Resume unit movement
- Switch unit target
- Switch lane
- Activate unit ability

## UI

- Top:
  - Player name
  - Base health
- Middle
  - Map
- Bottom
  - Unit selector
  - Resource indicator
  - Player name
  - Base health

## Questions

- Can units overlap?
- Fog of war?
- Units can be stopped (cost 1)?
- Units can switch lanes (cost 1)?
- Units cannot be stopped in a node
- Limitations
  - Cooldown: a unit type can be deployed every X seconds
  - Popcap: limit the total number of units on the battlefield

## Economy

- Base income starts at 2 T/s and accelerates by +0.2 T/s every 30 seconds up to a max of 3 T/s
- Income per harvester increases from 1.5 T/s at the start of the game to a max of 4 T/s at 150 seconds, an increase of 0.7 T/s every 30 seconds
