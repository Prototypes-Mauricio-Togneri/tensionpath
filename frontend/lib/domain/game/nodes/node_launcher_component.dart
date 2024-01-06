import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:tensionpath/domain/game/nodes/node_base_component.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/nodes/node_launcher.dart';
import 'package:tensionpath/extensions/sprite_component_extension.dart';

class NodeLauncherComponent extends NodeBaseComponent<NodeLauncher>
    with CollisionCallbacks, TapCallbacks {
  NodeLauncherComponent({
    required super.node,
    required super.size,
  });

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
    if ((other is UnitComponent) && (node.owner != other.owner)) {
      node.onUnitCollided(other.unit);
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (node.hasOwner && node.owner!.hasCreditsSelected) {
      node.spawnUnitOfPlayer(node.owner!);
    }
  }
}
