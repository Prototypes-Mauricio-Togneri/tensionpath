import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/launcher_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/components/resource_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/start/json_battlefield.dart';
import 'package:tensionpath/domain/json/models/start/json_resource.dart';
import 'package:tensionpath/domain/json/models/start/json_size.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/json_location_extension.dart';
import 'package:tensionpath/utils/assets.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class BattlefieldComponent extends PositionComponent {
  final JsonBattlefield battlefield;
  final Player self;
  final Player opponent;
  final List<NodeComponent> nodeComponents;
  final List<LauncherComponent> launcherComponents;
  final List<UnitComponent> unitComponents;

  BattlefieldComponent({
    required super.position,
    required super.size,
    required this.battlefield,
    required this.self,
    required this.opponent,
    required this.nodeComponents,
    required this.launcherComponents,
    required this.unitComponents,
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
      canvasSize: size * 0.9,
      mapSize: Size(
        battlefield.size.width.toDouble(),
        battlefield.size.height.toDouble(),
      ),
    );
    final Vector2 mapCenter = size / 2;
    final List<JsonLocation> nodePositions = _getNodeLocations(
      battlefield.size,
    );

    add(
      BattlefieldBackgroundComponent(
        position: mapCenter,
        size: sprite.originalSize,
        sprite: sprite,
      ),
    );

    add(
      BattlefieldGridComponent(
        position: mapCenter,
        size: size,
        nodeLocations: nodePositions,
        nodeSize: nodeSize,
      ),
    );

    /*for (final Vector2 position in nodePositions) {
      add(
        NodeComponent(
          position: position,
          size: nodeSize,
          type: NodeType.empty,
          location: JsonLocation(
            x: ((position.x - (size.x / 2)) / nodeSize.x).round(),
            y: ((position.y - (size.y / 2)) / nodeSize.y).round(),
          ),
        ),
      );
    }

    for (final JsonLocation location in battlefield.nodes) {
      final Vector2 position = Dimensions.nodePosition(
        center: size / 2,
        nodeSize: nodeSize,
        location: location,
      );

      final NodeComponent nodeComponent = NodeComponent(
        position: position,
        size: nodeSize,
        type: getNodeType(
          positionId: location.id,
          missile: battlefield.missile,
          resources: battlefield.resources,
          launchers: battlefield.launchers
              .map((launchers) => launchers.locations)
              .expand((locations) => locations)
              .toList(),
        ),
        location: location,
      );
      add(nodeComponent);
      nodeComponents.add(nodeComponent);
    }*/

    for (final JsonResource resource in battlefield.resources) {
      final Vector2 position = Dimensions.nodePosition(
        location: resource.location.toVector2(),
        nodeSize: nodeSize,
        canvasSize: size,
      );
      final ResourceComponent resourceComponent = ResourceComponent(
        position: position,
        size: nodeSize,
      );
      add(resourceComponent);
    }

    /*final int half = width ~/ 2;
    final int column1 = -half;
    final int column2 = half;

    for (final String playerIndex in ['1', '2']) {
      for (int i = 0; i < height; i++) {
        final JsonLocation location = JsonLocation(
          x: playerIndex == '1' ? column1 : column2,
          y: i,
        );

        final Vector2 nodePosition = Dimensions.nodePosition(
          location: location.toVector2(),
          nodeSize: nodeSize,
          canvasSize: size,
        );
        final LauncherComponent launcherComponent = LauncherComponent(
          position: nodePosition,
          size: nodeSize,
          player: self.index == playerIndex ? self : opponent,
          nodeComponent: match.getNodeById(location.id),
        );
        add(launcherComponent);
        launcherComponents.add(launcherComponent);
      }
    }*/

    /*for (final JsonLaunchers launchers in battlefield.) {
      for (final JsonLocation location in launchers.locations) {
        final Vector2 nodePosition = Dimensions.nodePosition(
          center: mapCenter,
          nodeSize: nodeSize,
          location: location,
        );
        final LauncherComponent launcherComponent = LauncherComponent(
          position: nodePosition,
          size: nodeSize,
          player: self.index == launchers.playerIndex ? self : opponent,
          nodeComponent: match.getNodeById(location.id),
        );
        add(launcherComponent);
        launcherComponents.add(launcherComponent);
      }
    }*/

    /*for (final JsonPlatform platform in battlefield.missile.platforms) {
      for (final JsonLocation location in platform.pads) {
        final Vector2 position = Dimensions.nodePosition(
          center: mapCenter,
          nodeSize: nodeSize,
          location: location,
        );
        final PadComponent padComponent = PadComponent(
          position: position,
          size: nodeSize,
          platformId: platform.id,
          owner: null,
        );
        add(padComponent);
      }
    }

    add(
      FogComponent(
        position: size / 2,
        size: size,
        unitComponents: unitComponents,
        launcherComponents: launcherComponents
            .where((launcher) => launcher.player.isSelf)
            .toList(),
        nodeComponents: nodeComponents,
        nodeSize: nodeSize,
        offset: position + (size / 2),
      ),
    );*/
  }

  /*NodeType getNodeType({
    required String positionId,
    required JsonMissile missile,
    required List<JsonResource> resources,
    required List<JsonLocation> launchers,
  }) {
    if (missile.location.id == positionId) {
      return NodeType.missile;
    }

    final List<JsonLocation> pads = missile.platforms
        .map((p) => p.pads)
        .expand((p) => p)
        .toList();

    if (pads.any((pad) => pad.id == positionId)) {
      return NodeType.pad;
    }

    if (resources.any((resource) => resource.location.id == positionId)) {
      return NodeType.resources;
    }

    if (launchers.any((launcher) => launcher.id == positionId)) {
      return NodeType.launcher;
    }

    return NodeType.empty;
  }*/

  List<JsonLocation> _getNodeLocations(JsonSize size) {
    final List<JsonLocation> result = [];
    final int halfX = size.width ~/ 2;
    final int halfY = size.height ~/ 2;
    final int minX = -halfX;
    final int maxX = halfX;
    final int minY = -halfY;
    final int maxY = halfY;

    for (int x = minX; x <= maxX; x++) {
      for (int y = minY; y <= maxY; y++) {
        result.add(JsonLocation(x: x, y: y));
      }
    }

    return result;
  }
}

class BattlefieldBackgroundComponent extends SpriteComponent {
  BattlefieldBackgroundComponent({
    required super.position,
    required super.size,
    required super.sprite,
  }) : super(anchor: Anchor.center);
}

class BattlefieldGridComponent extends SpriteComponent {
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.NODE_BORDER,
  );
  final List<JsonLocation> nodeLocations;
  final Vector2 nodeSize;

  BattlefieldGridComponent({
    required super.position,
    required super.size,
    required this.nodeLocations,
    required this.nodeSize,
  }) : super(anchor: Anchor.center);

  @override
  Future onLoad() async {
    borderPaint.strokeWidth = size.y / 300;

    final PictureRecorder recorder = PictureRecorder();
    final Canvas canvas = Canvas(recorder, Rect.fromLTWH(0, 0, size.x, size.y));

    for (final JsonLocation location in nodeLocations) {
      final Vector2 position = Dimensions.nodePosition(
        location: location.toVector2(),
        nodeSize: nodeSize,
        canvasSize: size,
      );

      canvas.drawNode(
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
