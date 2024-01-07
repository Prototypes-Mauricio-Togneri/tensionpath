import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/extensions/sprite_component_extension.dart';
import 'package:tensionpath/utils/sprites.dart';

class NodeLauncherComponent extends NodeComponent
    with CollisionCallbacks, TapCallbacks {
  NodeLauncherComponent({
    required super.id,
    required super.owner,
    required super.position,
    required super.size,
  }) : super(rate: 0);

  @override
  FutureOr onLoad() {
    add(circleHitbox);

    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if ((other is UnitComponent) && (owner != other.owner)) {
      _onUnitCollided(other);
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (hasOwner && owner!.hasCreditsSelected) {
      spawnUnitOfPlayer(owner!);
    }
  }

  @override
  Sprite get sprite {
    if (owner!.isEnemy) {
      return Sprites.LAUNCHER_ENEMY;
    } else if (owner!.isSelf) {
      return Sprites.LAUNCHER_SELF;
    }

    throw Exception('Cannot determine node sprite');
  }

  void _onUnitCollided(UnitComponent unit) =>
      GameState.instance.onUnitCollidedWithBase(
        unit: unit,
        baseOwner: owner!,
      );
}
