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
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/launchers.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/pad.dart';
import 'package:tensionpath/domain/entities/platform.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/resources.dart';
import 'package:tensionpath/domain/entities/update.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/assets.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class BattlefieldComponent extends PositionComponent {
  final Battlefield battlefield;
  final Player self;
  final Player opponent;
  final List<NodeComponent> nodeComponents;
  final List<ResourceComponent> resourceComponents;
  final List<LauncherComponent> launcherComponents;
  final List<UnitComponent> unitComponents;
  late final MissileComponent missileComponent;
  late final Vector2 mapCenter;
  late final Vector2 nodeSize;
  late final num nodeSizeRatio;

  BattlefieldComponent({
    required super.position,
    required super.size,
    required this.battlefield,
    required this.self,
    required this.opponent,
    required this.nodeComponents,
    required this.resourceComponents,
    required this.launcherComponents,
    required this.unitComponents,
  }) : super(
         anchor: Anchor.topLeft,
         priority: Priority.battlefield.value,
       );

  @override
  FutureOr onLoad() async {
    mapCenter = size / 2;
    nodeSize = Dimensions.nodeSize(
      canvasSize: size,
      mapSize: battlefield.mapSize,
    );
    nodeSizeRatio = Dimensions.nodeSizeRatio(
      localNodeSize: nodeSize,
      removeNodeSize: battlefield.nodeSize,
    );

    await _addBattlefieldComponent(
      nodeSize: nodeSize,
      mapCenter: mapCenter,
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

    _addFogComponent(
      nodeSize: nodeSize,
      mapCenter: mapCenter,
    );
  }

  Future _addBattlefieldComponent({
    required Vector2 nodeSize,
    required Vector2 mapCenter,
  }) async {
    final Sprite sprite = await Sprite.load(
      Assets.IMAGES_BATTLEFIELDS_BACKGROUND,
    );
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
        nodeSizeRatio: nodeSizeRatio,
        nodes: battlefield.nodes,
      ),
    );
  }

  void _addNodeComponents({
    required Vector2 nodeSize,
    required Vector2 mapCenter,
  }) {
    for (final Node node in battlefield.nodes) {
      final Vector2 position = node.position.localPosition(
        mapCenter: mapCenter,
        nodeSizeRatio: nodeSizeRatio,
      );

      final NodeComponent nodeComponent = NodeComponent(
        position: position,
        size: nodeSize,
        type: node.type,
        location: node.location,
        remotePosition: node.position,
      );
      add(nodeComponent);
      nodeComponents.add(nodeComponent);
    }
  }

  void _addResourceComponents({
    required Vector2 nodeSize,
    required Vector2 mapCenter,
  }) {
    for (final Resources resources in battlefield.resources) {
      final Vector2 position = resources.position.localPosition(
        mapCenter: mapCenter,
        nodeSizeRatio: nodeSizeRatio,
      );
      final ResourceComponent resourceComponent = ResourceComponent(
        position: position,
        size: nodeSize,
        resources: resources,
      );
      add(resourceComponent);
      resourceComponents.add(resourceComponent);
    }
  }

  void _addMissileComponent({
    required Vector2 nodeSize,
    required Vector2 mapCenter,
  }) {
    missileComponent = MissileComponent(
      position: battlefield.missile.position.localPosition(
        mapCenter: mapCenter,
        nodeSizeRatio: nodeSizeRatio,
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
    for (final Platform platform in battlefield.missile.platforms) {
      for (final Pad pad in platform.pads) {
        final Vector2 position = pad.position.localPosition(
          mapCenter: mapCenter,
          nodeSizeRatio: nodeSizeRatio,
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
    for (final Launcher launcher in battlefield.launchers) {
      final Vector2 nodePosition = launcher.position.localPosition(
        mapCenter: mapCenter,
        nodeSizeRatio: nodeSizeRatio,
      );
      final LauncherComponent launcherComponent = LauncherComponent(
        position: nodePosition,
        size: nodeSize,
        player: self.index == launcher.playerIndex ? self : opponent,
        nodeComponent: match.getNodeById(launcher.location.id),
      );
      add(launcherComponent);
      launcherComponents.add(launcherComponent);
    }
  }

  void _addFogComponent({
    required Vector2 nodeSize,
    required Vector2 mapCenter,
  }) {
    add(
      FogComponent(
        position: mapCenter,
        size: size,
        self: self,
        unitComponents: unitComponents,
        launcherComponents: launcherComponents
            .where((launcher) => launcher.player.isSelf)
            .toList(),
        nodeComponents: nodeComponents,
        nodeSize: nodeSize,
        offset: position + mapCenter,
      ),
    );
  }

  void onBattlefieldUpdated({
    required MissileUpdate missile,
    required Map<String, num> resources,
    required Map<String, UnitUpdate> units,
  }) {
    missileComponent.refresh(missile);

    _updateExistingUnits(
      units: units,
      unitComponents: unitComponents,
    );

    _createNewUnits(
      units: units,
      unitComponents: unitComponents,
    );

    _updateNodes();

    _updateResources(resources);
  }

  void _updateExistingUnits({
    required Map<String, UnitUpdate> units,
    required List<UnitComponent> unitComponents,
  }) {
    for (final UnitComponent unitComponent in unitComponents) {
      final UnitUpdate? unitUpdate = units[unitComponent.id];

      if (unitUpdate != null) {
        unitComponent.refresh(
          health: unitUpdate.health,
          newCurrentPosition: unitUpdate.currentPosition.localPosition(
            mapCenter: mapCenter,
            nodeSizeRatio: nodeSizeRatio,
          ),
          newTargetPosition: unitUpdate.targetPosition?.localPosition(
            mapCenter: mapCenter,
            nodeSizeRatio: nodeSizeRatio,
          ),
          newLockedNode: (unitUpdate.lockedLocation != null)
              ? match.getNodeById(unitUpdate.lockedLocation!.id)
              : null,
        );
      }
    }
  }

  void _createNewUnits({
    required Map<String, UnitUpdate> units,
    required List<UnitComponent> unitComponents,
  }) {
    final List<UnitUpdate> newUnits = [];
    final Set<String> existingUnitIds = unitComponents
        .map((unitComponent) => unitComponent.id)
        .toSet();

    for (final MapEntry<String, UnitUpdate> entry in units.entries) {
      if (!existingUnitIds.contains(entry.key)) {
        newUnits.add(entry.value);
      }
    }

    for (final UnitUpdate unit in newUnits) {
      final UnitComponent unitComponent = UnitComponent(
        position: unit.currentPosition.localPosition(
          mapCenter: mapCenter,
          nodeSizeRatio: nodeSizeRatio,
        ),
        size: nodeSize,
        id: unit.id,
        type: unit.type,
        nodeSizeRatio: nodeSizeRatio,
        player: unit.playerIndex == self.index ? self : opponent,
        lockedNode: (unit.lockedLocation != null)
            ? match.getNodeById(unit.lockedLocation!.id)
            : null,
      );
      add(unitComponent);
      unitComponents.add(unitComponent);
    }
  }

  void _updateNodes() {
    for (final NodeComponent nodeComponent in nodeComponents) {
      for (final UnitComponent unitComponent in unitComponents) {
        final NodeComponent? lockedNodeComponent = unitComponent.lockedNode;

        if ((lockedNodeComponent != null) &&
            (lockedNodeComponent == nodeComponent)) {
          nodeComponent.lock(unitComponent);
          break;
        } else {
          nodeComponent.unlock();
        }
      }
    }
  }

  void _updateResources(Map<String, num> resources) {
    for (final ResourceComponent resourceComponent in resourceComponents) {
      final num? newAmount = resources[resourceComponent.resources.id];

      if (newAmount != null) {
        resourceComponent.refresh(newAmount);
      }
    }
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
  final num nodeSizeRatio;
  final List<Node> nodes;
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.stroke,
    strokeWidth: 3,
    color: Palette.NODE_BORDER,
  );

  BattlefieldGridComponent({
    required super.position,
    required super.size,
    required this.nodeSize,
    required this.nodeSizeRatio,
    required this.nodes,
  }) : super(anchor: Anchor.center);

  @override
  Future onLoad() async {
    final PictureRecorder recorder = PictureRecorder();
    final Canvas canvas = Canvas(recorder, Rect.fromLTWH(0, 0, size.x, size.y));

    for (final Node node in nodes) {
      final Vector2 position = node.position.localPosition(
        mapCenter: size / 2,
        nodeSizeRatio: nodeSizeRatio,
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
