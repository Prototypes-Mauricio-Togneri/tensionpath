import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/resource_component.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_resource.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';
import 'package:tensionpath/utils/dimensions.dart';

class BattlefieldComponent extends PositionComponent {
  final JsonBattlefield battlefield;

  BattlefieldComponent({
    required this.battlefield,
    required super.position,
    required super.size,
  }) : super(
         anchor: Anchor.topLeft,
         priority: Priority.battlefield.value,
       );

  @override
  FutureOr onLoad() async {
    final Sprite sprite = await Sprite.load(
      Assets.IMAGES_BATTLEFIELDS_BACKGROUND,
    );
    final Vector2 nodeSize = Dimensions.nodeSize(
      canvasSize: size,
      battlefield: battlefield,
    );
    final Vector2 mapCenter = size / 2;

    add(
      BattlefieldBackgroundComponent(
        sprite: sprite,
        position: mapCenter,
        size: Dimensions.battlefieldBackgroundSize(
          canvasSize: size,
          imageSize: sprite.originalSize,
          gridSize: Dimensions.battlefildGridSize(size),
          battlefield: battlefield,
        ),
      ),
    );

    for (final JsonResource resource in battlefield.resources) {
      final Vector2 position = Dimensions.nodePosition(
        nodeSize: nodeSize,
        position: resource.position,
      );

      final ResourceComponent resourceComponent = ResourceComponent(
        position: Vector2(mapCenter.x + position.x, mapCenter.y + position.y),
        size: Vector2(nodeSize.y, nodeSize.y),
      );
      add(resourceComponent);
    }

    /*add(
      FogComponent(
        position: size / 2,
        size: size,
      ),
    );*/

    return super.onLoad();
  }
}

class BattlefieldBackgroundComponent extends SpriteComponent {
  BattlefieldBackgroundComponent({
    required super.sprite,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);
}
