import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/fog_component.dart';
import 'package:tensionpath/domain/components/launcher_component.dart';
import 'package:tensionpath/domain/components/missile_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/components/pad_component.dart';
import 'package:tensionpath/domain/components/resource_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/start/json_battlefield.dart';
import 'package:tensionpath/domain/json/models/start/json_launchers.dart';
import 'package:tensionpath/domain/json/models/start/json_missile.dart';
import 'package:tensionpath/domain/json/models/start/json_platform.dart';
import 'package:tensionpath/domain/json/models/start/json_resource.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
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

    _addNodeComponents(
      nodeSize: nodeSize,
      mapCenter: mapCenter,
    );

    _addResourceComponents(
      nodeSize: nodeSize,
      mapCenter: mapCenter,
    );

    _addMissileComponent(
      nodeSize: nodeSize,
      mapCenter: mapCenter,
    );

    _addPadComponents(
      nodeSize: nodeSize,
      mapCenter: mapCenter,
    );

    _addLauncherComponents(
      nodeSize: nodeSize,
      mapCenter: mapCenter,
    );

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
    );
  }

  void _addNodeComponents({
    required Vector2 nodeSize,
    required Vector2 mapCenter,
  }) {
    for (final JsonLocation location in battlefield.nodes) {
      final Vector2 position = Dimensions.nodePosition(
        center: mapCenter,
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
    }
  }

  void _addResourceComponents({
    required Vector2 nodeSize,
    required Vector2 mapCenter,
  }) {
    for (final JsonResource resource in battlefield.resources) {
      final Vector2 position = Dimensions.nodePosition(
        center: mapCenter,
        nodeSize: nodeSize,
        location: resource.location,
      );
      final ResourceComponent resourceComponent = ResourceComponent(
        position: position,
        size: nodeSize,
        resource: resource,
      );
      add(resourceComponent);
    }
  }

  void _addMissileComponent({
    required Vector2 nodeSize,
    required Vector2 mapCenter,
  }) {
    final MissileComponent missileComponent = MissileComponent(
      position: Dimensions.nodePosition(
        center: mapCenter,
        nodeSize: nodeSize,
        location: battlefield.missile.location,
      ),
      size: nodeSize,
      missile: battlefield.missile,
    );
    add(missileComponent);
  }

  void _addPadComponents({
    required Vector2 nodeSize,
    required Vector2 mapCenter,
  }) {
    for (final JsonPlatform platform in battlefield.missile.platforms) {
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
  }

  void _addLauncherComponents({
    required Vector2 nodeSize,
    required Vector2 mapCenter,
  }) {
    for (final JsonLaunchers launchers in battlefield.launchers) {
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
    }
  }

  NodeType getNodeType({
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
  final List<JsonLocation> nodes;
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

    for (final JsonLocation node in nodes) {
      final Vector2 position = Dimensions.nodePosition(
        center: size / 2,
        nodeSize: nodeSize,
        location: node,
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
