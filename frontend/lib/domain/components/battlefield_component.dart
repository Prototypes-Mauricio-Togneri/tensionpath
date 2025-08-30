import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/launcher_component.dart';
import 'package:tensionpath/domain/components/missile_component.dart';
import 'package:tensionpath/domain/components/pad_component.dart';
import 'package:tensionpath/domain/components/resource_component.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_position.dart';
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
    final Vector2 effectiveNodeSize = Vector2(nodeSize.y, nodeSize.y);
    final Vector2 mapCenter = size / 2;

    add(
      BattlefieldBackgroundComponent(
        sprite: sprite,
        position: mapCenter,
        size: Dimensions.battlefieldBackgroundSize(
          canvasSize: size,
          imageSize: sprite.originalSize,
          gridSize: Dimensions.battlefieldGridSize(size),
          battlefield: battlefield,
        ),
      ),
    );

    for (final JsonResource resource in battlefield.resources) {
      final Vector2 position = Dimensions.nodePosition(
        center: mapCenter,
        nodeSize: nodeSize,
        position: resource.position,
      );
      final ResourceComponent resourceComponent = ResourceComponent(
        position: position,
        size: effectiveNodeSize,
      );
      add(resourceComponent);
    }

    final MissileComponent missileComponent = MissileComponent(
      jsonMissile: battlefield.missile,
      position: Dimensions.nodePosition(
        center: mapCenter,
        nodeSize: nodeSize,
        position: battlefield.missile.position,
      ),
      size: effectiveNodeSize,
    );
    add(missileComponent);

    for (final MapEntry<String, List<JsonPosition>> platform
        in battlefield.missile.platforms.entries) {
      final String platformId = platform.key;

      for (final JsonPosition position in platform.value) {
        final Vector2 nodePosition = Dimensions.nodePosition(
          center: mapCenter,
          nodeSize: nodeSize,
          position: position,
        );
        final PadComponent padComponent = PadComponent(
          platformId: platformId,
          position: nodePosition,
          size: effectiveNodeSize,
        );
        add(padComponent);
      }
    }

    for (final MapEntry<String, List<JsonPosition>> platform
        in battlefield.launchers.entries) {
      final String playerId = platform.key;

      for (final JsonPosition position in platform.value) {
        final Vector2 nodePosition = Dimensions.nodePosition(
          center: mapCenter,
          nodeSize: nodeSize,
          position: position,
        );
        final LauncherComponent launcherComponent = LauncherComponent(
          playerId: playerId,
          position: nodePosition,
          size: effectiveNodeSize,
        );
        add(launcherComponent);
      }
    }

    /*add(
      FogComponent(
        position: size / 2,
        size: size,
      ),
    );*/
  }
}

class BattlefieldBackgroundComponent extends SpriteComponent {
  BattlefieldBackgroundComponent({
    required super.sprite,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);
}
