# TODO

Remove:
reconfigurable

- Snapshot update
- Dart compile in Docker
- Continuous popcap
- Add changelog to home screen
- Max 2 harvesters
- Harvester kill reward
- New harvester free
- Commanders abilities
- Choose map
- Unit ability deployment

# API

## Client -> Server

- Deploy unit
  - ID
  - Position
  - Type
- Move unit
  - ID
  - Target position
- Attack unit
  - ID
  - Target unit

## Server -> Client

- Match update
  - Player's base health
  - Battlefield
    - Missile charge
    - Pads
    - Resources
    - Units
      - ID
      - Position
      - Target position
      - Target unit
