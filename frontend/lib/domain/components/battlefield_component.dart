import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/launcher_component.dart';
import 'package:tensionpath/domain/components/missile_component.dart';
import 'package:tensionpath/domain/components/pad_component.dart';
import 'package:tensionpath/domain/components/resource_component.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_platform.dart';
import 'package:tensionpath/domain/json/json_position.dart';
import 'package:tensionpath/domain/json/json_resource.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/assets.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class BattlefieldComponent extends PositionComponent {
  final JsonBattlefield battlefield;
  List<LauncherComponent> launcherComponents;

  BattlefieldComponent({
    required super.position,
    required super.size,
    required this.battlefield,
    required this.launcherComponents,
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
        size: sprite.originalSize,
      ),
    );

    add(
      BattlefieldGridComponent(
        position: mapCenter,
        size: size,
        nodeSize: nodeSize,
        nodes: battlefield.nodes,
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
        size: nodeSize,
        resource: resource,
      );
      add(resourceComponent);
    }

    final MissileComponent missileComponent = MissileComponent(
      position: Dimensions.nodePosition(
        center: mapCenter,
        nodeSize: nodeSize,
        position: battlefield.missile.position,
      ),
      size: nodeSize,
      missile: battlefield.missile,
    );
    add(missileComponent);

    for (final JsonPlatform platform in battlefield.missile.platforms) {
      for (final JsonPosition position in platform.pads) {
        final Vector2 nodePosition = Dimensions.nodePosition(
          center: mapCenter,
          nodeSize: nodeSize,
          position: position,
        );
        final PadComponent padComponent = PadComponent(
          position: nodePosition,
          size: nodeSize,
          platformId: platform.id,
          owner: platform.owner,
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
          size: nodeSize,
        );
        add(launcherComponent);
        launcherComponents.add(launcherComponent);
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

class BattlefieldGridComponent extends SpriteComponent {
  final Vector2 nodeSize;
  final List<JsonPosition> nodes;
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.stroke,
    strokeWidth: 3,
    color: Palette.NODE_BORDER,
  );

  BattlefieldGridComponent({
    required super.position,
    required super.size,
    required this.nodeSize,
    required this.nodes,
  }) : super(anchor: Anchor.center);

  @override
  Future onLoad() async {
    final PictureRecorder recorder = PictureRecorder();
    final Canvas canvas = Canvas(recorder, Rect.fromLTWH(0, 0, size.x, size.y));

    for (final JsonPosition node in nodes) {
      final Vector2 position = Dimensions.nodePosition(
        center: size / 2,
        nodeSize: nodeSize,
        position: node,
      );
      canvas.drawHexagon(
        center: position,
        size: nodeSize,
        borderPaint: borderPaint,
      );
    }

    final Picture picture = recorder.endRecording();
    final Image image = await picture.toImage(size.x.toInt(), size.y.toInt());
    sprite = Sprite(image);
  }
}
