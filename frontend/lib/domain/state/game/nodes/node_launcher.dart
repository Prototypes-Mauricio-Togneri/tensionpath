import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/unit.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeLauncher extends Node {
  NodeLauncher({
    required super.id,
    required super.position,
    required super.owner,
  }) : super(rate: 0);

  @override
  Sprite get sprite {
    if (owner!.isEnemy) {
      return Sprites.LAUNCHER_ENEMY;
    } else if (owner!.isSelf) {
      return Sprites.LAUNCHER_SELF;
    }

    throw Exception('Cannot determine node sprite');
  }

  void onUnitCollided(Unit unit) => state.onUnitCollidedWithBase(
        unit: unit,
        baseOwner: owner!,
      );
}
