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

Missile:
/\*
String? get owner {
int player1 = 0;
int player2 = 0;
int none = 0;

    for (final JsonPlatform platform in platforms) {
      if (platform.owner == Constants.PLAYER_1) {
        player1++;
      } else if (platform.owner == Constants.PLAYER_2) {
        player2++;
      } else if (platform.owner == null) {
        none++;
      }
    }

    if (none == platforms.length) {
      return null;
    } else if (player1 > player2) {
      return Constants.PLAYER_1;
    } else if (player2 > player1) {
      return Constants.PLAYER_2;
    } else {
      return '';
    }

}
\*/

Platform:
/\*String? get owner {
int player1 = 0;
int player2 = 0;

    for (final Node node in nodes) {
      if (node.hasUnit) {
        if (node.unit!.player.isPlayer1) {
          player1++;
        } else if (node.unit!.player.isPlayer2) {
          player2++;
        }
      }
    }

    if ((player1 > 0) && (player2 == 0)) {
      return Constants.PLAYER_1;
    } else if ((player2 > 0) && (player1 == 0)) {
      return Constants.PLAYER_2;
    } else if ((player1 > 0) && (player2 > 0)) {
      return '';
    } else {
      return null;
    }
    return null;

}\*/
