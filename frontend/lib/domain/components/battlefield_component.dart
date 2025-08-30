import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/fog_component.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';
import 'package:tensionpath/utils/dimensions.dart';

class BattlefieldComponent extends PositionComponent {
  final JsonBattlefield battlefield;

  BattlefieldComponent({
    required this.battlefield,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft, priority: Priority.battlefield.value);

  @override
  FutureOr onLoad() async {
    final Sprite sprite = await Sprite.load(
      Assets.IMAGES_BATTLEFIELDS_BACKGROUND,
    );
    final Vector2 gridSize = Dimensions.battlefildGridSize(size);

    add(
      BattlefieldBackgroundComponent(
        sprite: sprite,
        position: size / 2,
        size: Dimensions.battlefieldBackgroundSize(
          canvasSize: size,
          imageSize: sprite.originalSize,
          gridSize: gridSize,
          battlefield: battlefield,
        ),
      ),
    );

    add(
      BattlefieldGridComponent(
        battlefield: battlefield,
        position: size / 2,
        size: gridSize,
      ),
    );

    add(
      FogComponent(
        position: size / 2,
        size: size,
      ),
    );

    return super.onLoad();
  }
}

class BattlefieldGridComponent extends PositionComponent {
  final JsonBattlefield battlefield;

  BattlefieldGridComponent({
    required this.battlefield,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() {
    /*final Size nodeSize = Dimensions.nodeSize(
      canvasSize: size,
      battlefield: battlefield,
    );
    final Vector2 mapCenter = size / 2;
    final Set<String> existingNodes = {};

    for (final Node node in battlefield.nodes) {
      if (existingNodes.contains(node.id)) {
        throw Exception('Duplicated node: ${node.id}');
      } else {
        final Vector2 position = Dimensions.nodePosition(
          nodeSize: nodeSize,
          position: node.position,
        );

        final NodeComponent nodeComponent = node.component(
          position: Vector2(mapCenter.x + position.x, mapCenter.y + position.y),
          size: Vector2(nodeSize.height, nodeSize.height),
        );
        nodeComponents.add(nodeComponent);
        add(nodeComponent);

        existingNodes.add(node.id);
      }
    }*/

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
