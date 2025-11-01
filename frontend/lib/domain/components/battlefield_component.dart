import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/building_component.dart';
import 'package:tensionpath/domain/components/explosion_component.dart';
import 'package:tensionpath/domain/components/fog_component.dart';
import 'package:tensionpath/domain/components/movement_path_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/components/pad_component.dart';
import 'package:tensionpath/domain/components/resource_component.dart';
import 'package:tensionpath/domain/components/rocks_low_component.dart';
import 'package:tensionpath/domain/components/silo_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/building.dart';
import 'package:tensionpath/domain/entities/event.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/pad.dart';
import 'package:tensionpath/domain/entities/platform.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/resources.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/presentation/audio/audio.dart';
import 'package:tensionpath/presentation/audio/sound.dart';
import 'package:tensionpath/utils/assets.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class BattlefieldComponent extends PositionComponent {
  final Battlefield battlefield;
  final Player self;
  final Player opponent;
  final List<NodeComponent> nodeComponents;
  final List<ResourceComponent> resourceComponents;
  final List<BuildingComponent> buildingComponents;
  final List<UnitComponent> unitComponents;
  late final SiloComponent siloComponent;
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
    required this.buildingComponents,
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

    _addRocksLowComponents(
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

    _addBuildingComponents(
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

  void _addRocksLowComponents({
    required Vector2 nodeSize,
    required Vector2 mapCenter,
  }) {
    for (final Node node in battlefield.nodes) {
      if (node.type == NodeType.rocks_low) {
        final Vector2 position = node.position.localPosition(
          mapCenter: mapCenter,
          nodeSizeRatio: nodeSizeRatio,
        );
        final RocksLowComponent rocksLowComponent = RocksLowComponent(
          position: position,
          size: nodeSize,
        );
        add(rocksLowComponent);
      }
    }
  }

  void _addMissileComponent({
    required Vector2 nodeSize,
    required Vector2 mapCenter,
  }) {
    siloComponent = SiloComponent(
      position: battlefield.missile.position.localPosition(
        mapCenter: mapCenter,
        nodeSizeRatio: nodeSizeRatio,
      ),
      size: nodeSize,
      missile: battlefield.missile,
    );
    add(siloComponent);
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
          platform: platform,
        );
        add(padComponent);
      }
    }
  }

  void _addBuildingComponents({
    required Vector2 nodeSize,
    required Vector2 mapCenter,
  }) {
    for (final Building building in battlefield.buildings) {
      final Vector2 nodePosition = building.position.localPosition(
        mapCenter: mapCenter,
        nodeSizeRatio: nodeSizeRatio,
      );
      final BuildingComponent buildingComponent = BuildingComponent(
        position: nodePosition,
        size: nodeSize,
        building: building,
        nodeComponent: match.getNodeById(building.location.id),
      );
      add(buildingComponent);
      buildingComponents.add(buildingComponent);
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
        buildingComponents: buildingComponents
            .where((building) => building.player.isSelf)
            .toList(),
        nodeComponents: nodeComponents,
        nodeSize: nodeSize,
        offset: position + mapCenter,
      ),
    );
  }

  void onUnitCreated(EventUnitCreated event) {
    final Player player = playerByIndex(event.playerIndex);
    MovementPathComponent? movementOrderComponent;
    MovementPathComponent? movementCurrentComponent;

    if (player.isSelf) {
      movementOrderComponent = MovementPathComponent(
        position: mapCenter - absoluteCenter,
        dashed: true,
        color: Palette.PATH_MOVEMENT,
        thickness: nodeSize.x / 30,
      );
      add(movementOrderComponent);

      movementCurrentComponent = MovementPathComponent(
        position: mapCenter - absoluteCenter,
        dashed: false,
        color: Palette.PATH_MOVEMENT,
        thickness: nodeSize.x / 30,
      );
      add(movementCurrentComponent);
    }

    final UnitComponent unitComponent = UnitComponent(
      position: event.currentPosition.localPosition(
        mapCenter: mapCenter,
        nodeSizeRatio: nodeSizeRatio,
      ),
      size: nodeSize,
      id: event.id,
      type: event.type,
      nodeSizeRatio: nodeSizeRatio,
      player: player,
      lockedNode: (event.lockedLocation != null)
          ? match.getNodeById(event.lockedLocation!.id)
          : null,
      battlefieldComponent: this,
      movementOrderComponent: movementOrderComponent,
      movementCurrentComponent: movementCurrentComponent,
      targetPositions: event.targetPositions
          .map(
            (position) => position.localPosition(
              mapCenter: mapCenter,
              nodeSizeRatio: nodeSizeRatio,
            ),
          )
          .toList(),
      targetUnit: event.targetUnitId != null
          ? unitComponents.where((u) => u.id == event.targetUnitId).firstOrNull
          : null,
      targetBase: (event.targetBase != null)
          ? match.getNodeById(event.targetBase!.id)
          : null,
    );

    add(unitComponent);
    unitComponents.add(unitComponent);

    if (player.isSelf) {
      Audio.get.playSound(Sound.EVA_UNIT_READY);
    }
  }

  void onUnitMovementStarted(EventUnitMovementStarted event) {
    final UnitComponent? unitComponent = unitComponentById(event.id);

    if (unitComponent != null) {
      unitComponent.onMovementStarted(
        newCurrentPosition: event.currentPosition.localPosition(
          mapCenter: mapCenter,
          nodeSizeRatio: nodeSizeRatio,
        ),
        newTargetPositions: event.targetPositions
            .map(
              (position) => position.localPosition(
                mapCenter: mapCenter,
                nodeSizeRatio: nodeSizeRatio,
              ),
            )
            .toList(),
      );
    }
  }

  void onUnitMovementEnded(EventUnitMovementEnded event) {
    final UnitComponent? unitComponent = unitComponentById(event.id);

    if (unitComponent != null) {
      unitComponent.onMovementEnded(
        newCurrentPosition: event.currentPosition.localPosition(
          mapCenter: mapCenter,
          nodeSizeRatio: nodeSizeRatio,
        ),
        newLockedNode: (event.lockedLocation != null)
            ? match.getNodeById(event.lockedLocation!.id)
            : null,
      );
    }
  }

  void onUnitAttack(EventUnitAttack event) {
    final UnitComponent? attackerUnitComponent = unitComponentById(
      event.attackerId,
    );

    if (attackerUnitComponent != null) {
      if (event.targetUnitId != null) {
        final UnitComponent? targetUnitComponent = unitComponentById(
          event.targetUnitId!,
        );

        if (targetUnitComponent != null) {
          attackerUnitComponent.onUnitAttack(
            targetUnit: targetUnitComponent,
            damage: event.damage,
            targetDestroyed: event.targetDestroyed,
          );
        }
      } else if (event.targetBaseLocation != null) {
        final BuildingComponent? targetBase = buildingComponentByLocation(
          Location.fromJson(event.targetBaseLocation!),
        );

        if (targetBase != null) {
          targetBase.onUnitAttack(
            attackerUnit: attackerUnitComponent,
            damage: event.damage,
          );
        }
      }
    }
  }

  void onUnitDamaged(EventUnitDamaged event) {
    final UnitComponent? unitComponent = unitComponentById(event.unitId);

    if (unitComponent != null) {
      unitComponent.onHit(event.damage);

      if (event.unitDestroyed) {
        onUnitDestroyed(unitComponent);
      }
    }
  }

  void onUnitDestroyed(UnitComponent unitComponent) {
    final ExplosionComponent explosionComponent = ExplosionComponent(
      position: unitComponent.absolutePosition,
      size: unitComponent.size * 0.5,
    );
    match.add(explosionComponent);

    unitComponent.destroy();
    unitComponents.remove(unitComponent);

    if (unitComponent.player.isSelf) {
      Audio.get.playSound(Sound.EVA_UNIT_LOST);
    }
  }

  void updateNodesLocks() {
    for (final NodeComponent nodeComponent in nodeComponents) {
      nodeComponent.unlock();
    }

    for (final UnitComponent unitComponent in unitComponents) {
      unitComponent.lockedNode?.lock(unitComponent);
    }
  }

  UnitComponent? unitComponentById(String unitId) =>
      unitComponents.where((u) => u.id == unitId).firstOrNull;

  BuildingComponent? buildingComponentByLocation(Location location) =>
      buildingComponents
          .where((l) => l.nodeComponent.location == location)
          .firstOrNull;

  Player playerByIndex(String index) {
    if (self.index == index) {
      return self;
    } else if (opponent.index == index) {
      return opponent;
    } else {
      throw Exception('Player not found');
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
    style: PaintingStyle.fill,
    color: const Color(0xffCBA972),
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
      borderPaint.color = borderPaint.color.withAlpha(
        Random().nextInt(60) + 60,
      );
      final Vector2 position = node.position.localPosition(
        mapCenter: size / 2,
        nodeSizeRatio: nodeSizeRatio,
      );
      canvas.drawHexagon(
        center: position,
        size: nodeSize,
        fillPaint: borderPaint,
      );
    }

    final Picture picture = recorder.endRecording();
    final Image image = await picture.toImage(size.x.toInt(), size.y.toInt());
    sprite = Sprite(image);
  }
}
