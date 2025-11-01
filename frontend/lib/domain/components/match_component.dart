import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/building_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/components/header_component.dart';
import 'package:tensionpath/domain/components/missile_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/components/resource_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/entities/event.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/resources.dart';
import 'package:tensionpath/domain/types/building_type.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/presentation/audio/audio.dart';
import 'package:tensionpath/presentation/audio/sound.dart';
import 'package:tensionpath/utils/dimensions.dart';

class MatchComponent extends World {
  final Vector2 resolution;
  final Match match;
  final List<NodeComponent> nodeComponents = [];
  final List<ResourceComponent> resourceComponents = [];
  final List<BuildingComponent> buildingComponents = [];
  final List<UnitComponent> unitComponents = [];
  late final Player self;
  late final Player opponent;
  late final Vector2 nodeSize;
  late final BattlefieldComponent battlefieldComponent;
  late final ControlsComponent controlsComponent;

  MatchComponent({
    required this.resolution,
    required this.match,
  }) {
    MatchComponentRef.instance = this;
    self = match.self;
    opponent = match.opponent;
  }

  @override
  FutureOr onLoad() {
    nodeSize = Dimensions.nodeSize(
      canvasSize: Dimensions.battlefieldSize(resolution),
      mapSize: match.battlefield.mapSize,
    );

    battlefieldComponent = BattlefieldComponent(
      position: Dimensions.battlefieldPosition(
        resolution: resolution,
        isPlayer1: self.isPlayer1,
      ),
      size: Dimensions.battlefieldSize(resolution),
      battlefield: match.battlefield,
      self: self,
      opponent: opponent,
      nodeComponents: nodeComponents,
      resourceComponents: resourceComponents,
      buildingComponents: buildingComponents,
      unitComponents: unitComponents,
    );

    add(battlefieldComponent);

    add(
      HeaderComponent(
        player1: self.isPlayer1 ? self : opponent,
        player2: self.isPlayer2 ? self : opponent,
        position: Dimensions.headerPosition(
          resolution: resolution,
          isPlayer1: self.isPlayer1,
        ),
        size: Dimensions.headerSize(resolution),
      ),
    );

    controlsComponent = ControlsComponent(
      player: self,
      maxHarvestersCount: match.config.maxHarvestersCount,
      position: Dimensions.controlsPosition(
        resolution: resolution,
        isPlayer1: self.isPlayer1,
      ),
      size: Dimensions.controlsSize(resolution),
    );

    add(controlsComponent);

    return super.onLoad();
  }

  void onMatchUpdated(List<Event> events) {
    bool updateNodeLocks = false;

    // Update status
    events.whereType<EventMatchStatus>().forEach(
      (event) => match.setStatus(event.status),
    );

    // Update missile
    events.whereType<EventMissile>().forEach(
      (event) {
        match.battlefield.missile.refresh(event);

        if (event.fired) {
          _fireMissile(event);
        }
      },
    );

    // Update players
    events.whereType<EventPlayer>().forEach(
      (event) {
        final Player player = _playerByIndex(event.index);
        player.refresh(event);
      },
    );

    // Update popcap
    events.whereType<EventPopcap>().forEach(
      (event) => match.setPopcap(event.popcap),
    );

    // Update base damage
    events.whereType<EventBaseDamaged>().forEach(
      (event) {
        final Player player = _playerByIndex(event.playerIndex);
        player.onHit(event.damage);
      },
    );

    // Update resources depleted
    events.whereType<EventResourcesDepleted>().forEach(
      _resourcesDepleted,
    );

    // Update building unlocked
    events.whereType<EventBuildingUnlocked>().forEach(_unlockBuilding);

    // Update unit created
    events.whereType<EventUnitCreated>().forEach(
      (event) {
        updateNodeLocks = true;
        battlefieldComponent.onUnitCreated(event);
      },
    );

    // Update unit movement started
    events.whereType<EventUnitMovementStarted>().forEach(
      (event) {
        updateNodeLocks = true;
        battlefieldComponent.onUnitMovementStarted(event);
      },
    );

    // Update unit movement ended
    events.whereType<EventUnitMovementEnded>().forEach(
      (event) {
        updateNodeLocks = true;
        battlefieldComponent.onUnitMovementEnded(event);
      },
    );

    // Update unit attack
    events.whereType<EventUnitAttack>().forEach(
      battlefieldComponent.onUnitAttack,
    );

    // Update unit damaged
    events.whereType<EventUnitDamaged>().forEach(
      (event) {
        updateNodeLocks = true;
        battlefieldComponent.onUnitDamaged(event);
      },
    );

    if (updateNodeLocks) {
      battlefieldComponent.updateNodesLocks();
    }
  }

  Player _playerByIndex(String index) {
    if (self.index == index) {
      return self;
    } else if (opponent.index == index) {
      return opponent;
    } else {
      throw Exception('Player not found with index: $index');
    }
  }

  void _fireMissile(EventMissile event) {
    Audio.get.playSound(Sound.EVA_MISSILE_LAUNCHED);
    Audio.get.playSound(Sound.EFFECT_MISSILE_LAUNCHED);

    final Player player = _playerByIndex(event.playerIndex!);
    final MissileComponent missileComponent = MissileComponent(
      position: battlefieldComponent.siloComponent.absolutePosition,
      size: nodeSize,
      player: player,
      damage: event.damage!,
      targetPosition: _mainBuildingPosition(
        buildings: buildingComponents,
        player: player,
      ),
    );
    add(missileComponent);
  }

  Vector2 _mainBuildingPosition({
    required List<BuildingComponent> buildings,
    required Player player,
  }) {
    for (final BuildingComponent building in buildings) {
      if (building.belongsTo(player) &&
          building.building.type == BuildingType.main) {
        return building.absolutePosition;
      }
    }

    throw Exception('Main building not found for player: ${player.index}');
  }

  void _unlockBuilding(EventBuildingUnlocked event) {
    if (event.playerIndex == self.index) {
      controlsComponent.unlockBuilding(event.type);
    }

    match.battlefield.onBuildingUnlocked(
      player: _playerByIndex(event.playerIndex),
      type: event.type,
    );
  }

  void _resourcesDepleted(EventResourcesDepleted event) {
    for (final Resources resources in match.battlefield.resources) {
      if (event.id == resources.id) {
        resources.deplete();
        break;
      }
    }
  }

  void onUnitDestroyed(UnitComponent unitComponent) =>
      battlefieldComponent.onUnitDestroyed(unitComponent);

  int unitsOfPlayer(Player player) => unitComponents
      .where((unit) => unit.isAlive && unit.belongsTo(player))
      .length;

  @override
  void update(double dt) {
    super.update(dt);

    match.update(dt);
  }

  UnitComponent? getEnemyUnitAt(Vector2 position) {
    for (final UnitComponent unitComponent in unitComponents) {
      if (unitComponent.containsPoint(position) &&
          unitComponent.belongsTo(opponent)) {
        return unitComponent;
      }
    }

    return null;
  }

  NodeComponent? getActionNodeAt({
    required Vector2 position,
    required UnitType unitType,
  }) {
    for (final NodeComponent nodeComponent in nodeComponents) {
      if (nodeComponent.containsPoint(position) &&
          nodeComponent.type.canMove(unitType)) {
        return nodeComponent;
      }
    }

    for (final BuildingComponent buildingComponent in buildingComponents) {
      if (buildingComponent.containsPoint(position) &&
          buildingComponent.belongsTo(opponent)) {
        return buildingComponent.nodeComponent;
      }
    }

    return null;
  }

  NodeComponent getClosestNodeAt(Vector2 position) {
    NodeComponent? closestNode;
    double closestDistance = double.infinity;

    for (final NodeComponent nodeComponent in nodeComponents) {
      final double distance =
          (nodeComponent.absolutePosition - position).length;

      if (distance < closestDistance) {
        closestDistance = distance;
        closestNode = nodeComponent;
      }
    }

    if (closestNode == null) {
      throw Exception('No closest node found');
    }

    return closestNode;
  }

  NodeComponent getNodeById(String id) {
    for (final NodeComponent nodeComponent in nodeComponents) {
      if (nodeComponent.location.id == id) {
        return nodeComponent;
      }
    }

    throw Exception('Node not found');
  }

  void highlightActionNodeAt({
    required Vector2 position,
    required UnitType unitType,
  }) {
    unhighlightNodes();

    final NodeComponent? nodeComponent = getActionNodeAt(
      position: position,
      unitType: unitType,
    );
    nodeComponent?.highlight(true);
  }

  void unhighlightNodes() {
    for (final NodeComponent nodeComponent in nodeComponents) {
      nodeComponent.highlight(false);
    }
  }

  void onDeployUnit({
    required Location location,
    required UnitType type,
  }) => game.matchState.onDeployUnit(
    location: location,
    type: type,
  );

  void onUnitAction({
    required UnitComponent unitComponent,
    required NodeComponent? targetNodeComponent,
    required UnitComponent? targetUnitComponent,
  }) => game.matchState.onUnitAction(
    unitId: unitComponent.id,
    targetLocation: targetNodeComponent?.location,
    targetUnitId: targetUnitComponent?.id,
  );
}

mixin MatchComponentRef {
  static late MatchComponent instance;

  MatchComponent get match => instance;
}
