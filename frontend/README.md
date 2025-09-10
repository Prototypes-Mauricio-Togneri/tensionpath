# TODO

- Target line in each unit

  - Dragging for movement
  - Moving towards a cell
  - Attacking a unit

- Units always have a "hovering node" (the closest node to them)
- Snapshot update
- Dart compile in Docker
- Continuous popcap
- Add changelog to home screen
- Max 2 harvesters
- Harvester kill reward
- New harvester free
- Choose map
- Unit ability deployment
- Use varaiable tick rate (the more simultaneous matches, the slower the tick rate)
- Conquer structures
- Toxic tiles that damage units
- Re-attach to an active match
- After 5 minutes, bases take damage every turn
- Show match replay
- Commanders abilities
  - Paratroopers (only on revealed tiles)
  - Radar
    - Reveal map
    - Increase units visibility
  - Bomb (only on revealed tiles)
    - Toxic bomb (removes units on each turn)
    - Single tile
    - Center tile and adjacents (more expensive or less damage in each node)
    - Vertical (affects 2 tiles in a column)
    - Mine

## Cooldown

- Each unit has a separate cooldown once it's deployed. For example, I create a tank. After deployment, the tank unit has a cooldown of 5 seconds. This cooldown is independent and it doesn't apply to other units. After 5 seconds I can build another tank. The cooldown automatically resets if the tank is destroyed before 5 seconds passed.

## Economy

- Base income starts at 2 T/s and accelerates by +0.2 T/s every 30 seconds up to a max of 3 T/s
- Income per harvester increases from 1.5 T/s at the start of the game to a max of 4 T/s at 150 seconds, an increase of 0.7 T/s every 30 seconds

## Actions

- Deploy unit
- Move unit
- Attack unit

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

## Goal

- The goal of the game is to destroy the enemy's base
- This is your base and this is your enemy's base
- The bases' hit points are indicated on the top bar
- There are 2 ways to destroy an enemy's base
- The first one (and most common), is to shoot the missile in the center
- I'll explain later how to do that
- The second way is to use your units to attack the enemy's base directly
- These two ways are not mutually exclusive
- The difference is that the missile takes half of the enemy's base hit point
- And the units damage it depending on their level

## Map

- Let's see other things that appear in the map
- The yellow tiles are empty
- The green tiles are resource patches
- I'll explain how to get resources later
- And then we have 2 platforms
- Each platform has 3 pads
- A platform can be in 3 states:
  1. Neutral (when none of the pads have units on them)
  2. Captured (when only units of one player are on it)
  3. Contested (when units of both players are on it)
- The number of units on a platform is not important
- The ownership of a platform can change over time
- A missile is captured when a player holds the majority of the platforms
- At the end of each turn:
  1. If the missile is captured it increases the charge
  2. If it's not captured, the charge stops
  3. If the missile is contested, the charge falls back to a predefined value
- When the missile reaches its maximum charge, it's fired
- After firing, the missile restarts its charge

## Control panel

- At the bottom you have the control panel
- First we have the money you have
- There are 3 ways to get money:
  1. There is a fixed amount of money each player gets at the beginning of a turn
  2. Money can be collected by placing units in an resource patch
  3. The more time the enemy's take to pass their turn, the more money you receive

## Units

- Each unit costs money
- To deploy a unit, click on one of the launchers of your base
- You can increase the level of a unit while deploying it
- There is a maximum of units that can be deployed at any given time
- Increases when a unit is deployed and decreases when it's destroyed
- The last button allows you to end your turn
- Units can only move in a straight line
- Units can only move forward
- Units can be merged and their level is combined
- Units can move any amount of tiles at once but:
  1. They can't jump over other units
  2. They can't move to or jump over obstacles
  3. They can only move to the first unrevealed tile in range
- Each movement has a cost
- Units also have a range of visibility
- Units remove the fog of war
- Only units of one player can occupy a given tile
- When 2 units battle, there is the concept of attacker and defender
- If a unit participating in a battle:
  1. Didn't move in that turn, then it's considered the defender
  2. It did move in that turn, then it's considered the attacker
- Defender units have extra levels during battle
