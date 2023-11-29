import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/types/node_type.dart';

class Node {
  final String id;
  final Vector2 position;
  final NodeType type;
  late GameState state;
  Player? _owner;
  double _commandPointsAccumulated = 0;

  Node({
    required this.id,
    required this.position,
    required this.type,
  });

  bool get hasOwner => _owner != null;

  Player? get owner => _owner;

  double get commandPointsAccumulated =>
      _commandPointsAccumulated.floorToDouble();

  void setGameState(GameState gameState) {
    state = gameState;
  }

  void setOwner(Player player) {
    _owner = player;
    _commandPointsAccumulated = 0;
  }

  void resetCommandPointsAccumulated() {
    _commandPointsAccumulated = 0;
  }

  void update(double dt) {
    if (type.canAccumulate) {
      if ((type.isCheckpoint) || ((_owner != null) && (type.isUnitGenerator))) {
        _commandPointsAccumulated += Constants.NODE_COMMAND_POINTS_RATIO * dt;
      }

      if ((_owner != null) &&
          (type.isUnitGenerator) &&
          (_commandPointsAccumulated >= 1)) {
        _commandPointsAccumulated -= 1;
        state.onNodeSpawnUnit(
          node: this,
          power: 1,
        );
      }
    }
  }
}
