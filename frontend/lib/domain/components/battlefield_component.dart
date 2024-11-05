import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/types/priority.dart';

class BattlefieldComponent extends SpriteComponent {
  final Battlefield battlefield;

  BattlefieldComponent({
    required this.battlefield,
  }) : super(
          position: Vector2(0, 0),
          sprite: battlefield.sprite,
          size: battlefield.sprite.image.size,
          anchor: Anchor.topLeft,
          priority: Priority.battlefield.value,
        );

  @override
  FutureOr onLoad() {
    for (final NodeComponent node in battlefield.nodes) {
      add(node);
    }

    return super.onLoad();
  }
}
