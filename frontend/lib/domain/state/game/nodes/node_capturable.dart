import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeCapturable extends Node {
  NodeCapturable({
    required super.id,
    required super.position,
    required super.rate,
  });

  @override
  Sprite get sprite {
    if (owner == null) {
      return Sprites.NODE_NEUTRAL;
    } else if (owner!.isEnemy) {
      return Sprites.NODE_ENEMY;
    } else if (owner!.isSelf) {
      return Sprites.NODE_SELF;
    }

    throw Exception('Cannot determine node sprite');
  }

  void onTouched(Player player) => ownership.touched(player);
}
