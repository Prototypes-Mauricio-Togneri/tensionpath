# TODO

- Target line in each unit

  - Dragging for movement
  - Moving towards a cell
  - Attacking a unit

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
- Use varaiable tick rate (the more simultaneous matches, the slower the tick rate)

# API

## Client -> Server

- Attack unit
  - ID
  - Target unit

## Messages

1. Server

- Sends state

2. Client

- Sends message "deploy_unit"
  - Type
  - Location

3. Server

- Creates unit in the battlefield
- Sends state

4. Client

- Creates UnitComponent

5. Client

- Sends message "move_unit"
  - ID
  - Location

6. Server

- Marks unit as moving
- Sends state

7. Client

- Updates UnitComponent

## Server loop

- For each unit
  - If moving
    - If target node is free
      - Update position
      - If unit inside of target node -> assign node to unit
    - If target node is not free
      - Re-assign node
      - Update position
      - If unit inside of target node -> assign node to unit
