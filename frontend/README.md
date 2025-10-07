# TODO

### Phase 1

- More units
  - Jump jets
  - Dogs
  - Drones
- Nod faction
  - riflemen-militants
  - shocks-flames
  - missiles-laser
  - jumpjets-scavenger
  - grenadier-mutant
  - sniper-fanatic
  - dogs-wheels
  - rhino-buggy
  - pitbull-bikes
  - shatterer-chuggy
  - predator-scorpion
  - mlrs-giga
  - drones swarm-laser drones
  - talon-banshee
  - razorback-venom
  - orca-shade
  - mohawk-catship
  - hammerhead-phantom
- Other
  - Show health bar only if not full
  - Tiberium field with less opacity
  - Don't attack a unit that cannot be targeted
  - Bug with missile not dealing damage
  - Adapt it for mobile
  - Remove health for infantry in a tiberium field
  - Continuous popcap

### Phase 2

- More maps
- Events
  - Shooting
  - Destroying unit
- Music and sound effects
- Ramping popcap and resources rate (see picture)
- Drag the entire unit card, not just the unit sprite
- Path finding
- Choose map
- Toxic tiles that damage units

### Phase 3

- Show list of open matches to play knowing the map
- Dart compile in Docker
- Add changelog to home screen
- Use variable tick rate (the more simultaneous matches, the slower the tick rate)
- Conquer structures
- Re-attach to an active match
- After 5 minutes, bases take damage every turn
- Show match replay
- Commanders abilities

  - Paratroopers (only on revealed tiles)
  - Radar
    - Reveal map
    - Increase units visibility
  - Bomb (only on revealed tiles)
    - Fire bomb (leaves a fire trail)
    - Single tile (jade missile)
    - Center tile and adjacents (ion cannon)
    - Vertical (affects 2 tiles in a column)
    - Mine
  - Boost
    - Increases HP
    - Increases range
    - Increases attack
    - Increases conquering rate

## Combat

- Face to face
  - Pros: can hold a tile while fighting
  - Cons: hard to implement (implies shooting?)
- Same spot
  - Pros: easy to implement
  - Cons: can't hold a tile while fighting

## Movement

- Free movement
  - Pros: more tactical
  - Cons: harder to implement
- Straight movement
  - Pros: easy to implement
  - Cons: less tactical

## Map

- Hex
  - Pros: better diagonal movement, more tactical
  - Cons: harder to implement
- Square
  - Pros: easier to implement
  - Cons: less tactical

## Avoid

- Squads (pop caping)
- 2 range units
- Shooting while moving

## Units

### Barracks

- Warrior
- Spearman

### Archery

- Archer
- Crossbow

### Stable

- Scout
- Knight

## Cooldown

- Each unit has a separate cooldown once it's deployed. For example, I create a tank. After deployment, the tank unit has a cooldown of 5 seconds. This cooldown is independent and it doesn't apply to other units. After 5 seconds I can build another tank. The cooldown automatically resets if the tank is destroyed before 5 seconds passed.

## Economy

- Base income starts at 2 T/s and accelerates by +0.2 T/s every 30 seconds up to a max of 3 T/s
- Income per harvester increases from 1.5 T/s at the start of the game to a max of 4 T/s at 150 seconds, an increase of 0.7 T/s every 30 seconds

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
- And the units damage it little by little

## Map

- Let's see other things that appear in the map
- The yellow tiles are empty
- The black tiles are resource patches
- I'll explain how to get resources later
- And then we have 2 platforms
- Each platform has 3 pads
- A platform can be in 3 states:
  1. Neutral (when none of the pads have units on them)
  2. Captured (when only units of one player are on it)
  3. Contested (when units of both players are on it)
- The number of units on a platform is irrelevant
- The ownership of a platform can change over time
- A missile is captured when a player holds the majority of the platforms
- If the missile is captured, it will increase its charge
- If it's not captured or contested, the charge stops
- When the missile reaches its maximum charge, it's fired
- After firing, the missile restarts its charge

## Control panel

- On the left you have the control panel
- First we have the money you have
- There are 2 ways to get money:
  1. There is a fixed amount of money each player gets per second
  2. Money can be collected by placing a fuel truck in a resource patch

## Units

- Each unit costs money
- To deploy a unit, drag and drop it in on of your launchers
- Units have a range of visibility, which removes the fog of war
- To move a unit, drag and drop it into another tile
- Only units of one player can occupy a given tile
- Units can only shoot if they are stationary on a tile

Infantry:

- Good against infantry:
  - Riflemen/Militants
  - MG
  - Shocks/Flames/Chems
  - Sniper
  - Fanatic
- Good against vehicles:
  - Missiles/Laser
  - Jumpjets
  - Grens/Mutant
  - Savenger
- Good against aircraft:
  - Missile/Laser
  - Scavenger

Vehicle:

- Good against infantry:
  - Dogs/Wheels
  - Rhino/Buggy
  - Shatterer/Chuggy
  - APC
- Good against vehicles:
  - Pitbull/Bikes
  - MLRS/Giga
  - Predator/Scorpion
  - Tick Tank
  - Stealth Tank
- Good against aircraft:
  - Rhino/Buggy
  - Pitbull/Bikes
  - APC
  - Slingshot
  - Stealth Tank

Aircraft:

- Good against infantry:
  - Drone Swarm
  - Talon
  - Razorback
  - Venom
  - Catalyst
  - Inferno
- Good against vehicles:
  - Mohawk
  - Orca/Shade
  - Orca bomber
  - Laser drones
  - Banshee
  - Inferno
- Good against aircraft:
  - Talon
  - Hammerhead/Phantom
  - Banshee

Tech

- Good against infantry:
  - Wolverine/Widowmaker/Confesor
  - Disruptor/Flame Tank
  - Juggernaut/Artillery
  - Mammoth/Avatar
- Good against vehicles:
  - Juggernaut/Artillery
  - Zone Trooper/Cyborg
  - Kodiak
  - Sandstorm
  - Titan/Centurion
  - Basilisk
  - Rockworm
- Good against aircraft:
  - Wolverine/Widowmaker/Confesor
  - Zone Trooper/Cyborg
  - Sandstorm
  - Mammoth/Avatar
