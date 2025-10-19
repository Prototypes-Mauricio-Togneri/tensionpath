import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/components/header_component.dart';
import 'package:tensionpath/domain/components/launcher_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/components/resource_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/entities/event.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/resources.dart';
import 'package:tensionpath/domain/entities/update.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';

class MatchComponent extends World {
  final Vector2 resolution;
  final Match match;
  final List<NodeComponent> nodeComponents = [];
  final List<ResourceComponent> resourceComponents = [];
  final List<LauncherComponent> launcherComponents = [];
  final List<UnitComponent> unitComponents = [];
  late final Player self;
  late final Player opponent;
  late final Vector2 nodeSize;
  late final DateTime startedAt;
  late final BattlefieldComponent battlefieldComponent;

  MatchComponent({
    required this.resolution,
    required this.match,
  }) {
    MatchComponentRef.instance = this;
    self = match.self;
    opponent = match.opponent;
    startedAt = match.createdAt.toLocal();
  }

  int get timeElapsed => DateTime.now().difference(startedAt).inSeconds;

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
      launcherComponents: launcherComponents,
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

    add(
      ControlsComponent(
        player: self,
        maxHarvestersCount: match.config.maxHarvestersCount,
        position: Dimensions.controlsPosition(
          resolution: resolution,
          isPlayer1: self.isPlayer1,
        ),
        size: Dimensions.controlsSize(resolution),
      ),
    );

    return super.onLoad();
  }

  void onMatchUpdated(MatchUpdate matchUpdate) {
    bool updateNodeLocks = false;

    for (final Event event in matchUpdate.events) {
      if (event is EventMissile) {
        match.battlefield.missile.update(event);
      } else if (event is EventPlayer) {
        if (event.id == self.id) {
          self.update(event);
        } else if (event.id == opponent.id) {
          opponent.update(event);
        }
      } else if (event is EventResourcesDepleted) {
        for (final Resources resources in match.battlefield.resources) {
          if (event.id == resources.id) {
            resources.deplete();
            break;
          }
        }
      } else if (event is EventUnitCreated) {
        updateNodeLocks = true;
        battlefieldComponent.onUnitCreated(event);
      } else if (event is EventUnitMovementStarted) {
        updateNodeLocks = true;
        battlefieldComponent.onUnitMovementStarted(event);
      } else if (event is EventUnitMovementEnded) {
        updateNodeLocks = true;
        battlefieldComponent.onUnitMovementEnded(event);
      }
    }

    if (updateNodeLocks) {
      battlefieldComponent.updateNodesLocks();
    }
  }

  int unitsOfPlayer(Player player) => unitComponents
      .where((unit) => unit.isAlive && unit.belongsTo(player))
      .length;

  UnitComponent? getEnemyUnitAt(Vector2 position) {
    for (final UnitComponent unitComponent in unitComponents) {
      if (unitComponent.containsPoint(position) &&
          unitComponent.belongsTo(opponent)) {
        return unitComponent;
      }
    }

    return null;
  }

  LauncherComponent? getLauncherAt(Vector2 position) {
    for (final LauncherComponent launcherComponent in launcherComponents) {
      if (launcherComponent.containsPoint(position) &&
          launcherComponent.belongsTo(self) &&
          launcherComponent.nodeComponent.isFree) {
        return launcherComponent;
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

    for (final LauncherComponent launcherComponent in launcherComponents) {
      if (launcherComponent.containsPoint(position) &&
          launcherComponent.belongsTo(opponent)) {
        return launcherComponent.nodeComponent;
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

  LauncherComponent getClosestLauncherAt(Vector2 position) {
    LauncherComponent? closestLauncher;
    double closestDistance = double.infinity;

    for (final LauncherComponent launcherComponent in launcherComponents) {
      final double distance =
          (launcherComponent.absolutePosition - position).length;

      if (distance < closestDistance) {
        closestDistance = distance;
        closestLauncher = launcherComponent;
      }
    }

    if (closestLauncher == null) {
      throw Exception('No closest launcher found');
    }

    return closestLauncher;
  }

  NodeComponent getNodeById(String id) {
    for (final NodeComponent nodeComponent in nodeComponents) {
      if (nodeComponent.location.id == id) {
        return nodeComponent;
      }
    }

    throw Exception('Node not found');
  }

  void highlightLauncherAt(Vector2 position) {
    unhighlightNodes();

    final LauncherComponent? launcherComponent = getLauncherAt(position);
    launcherComponent?.nodeComponent.highlight(true);
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
