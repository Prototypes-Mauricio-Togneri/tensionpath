import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/components/header_component.dart';
import 'package:tensionpath/domain/components/launcher_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/components/target_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/dimensions.dart';

class MatchComponent extends World {
  final Vector2 resolution;
  final JsonMatch match;
  final List<NodeComponent> nodeComponents = [];
  final List<LauncherComponent> launcherComponents = [];
  final List<UnitComponent> unitComponents = [];
  late final Vector2 nodeSize;
  late final TargetComponent targetComponent;

  MatchComponent({
    required this.resolution,
    required this.match,
  }) {
    MatchComponentRef.instance = this;
  }

  @override
  FutureOr onLoad() {
    targetComponent = TargetComponent(
      position: Vector2.zero(),
    );
    add(targetComponent);

    nodeSize = Dimensions.nodeSize(
      canvasSize: Dimensions.battlefieldSize(resolution),
      battlefield: match.battlefield,
    );

    add(
      BattlefieldComponent(
        position: Dimensions.battlefieldPosition(
          resolution: resolution,
          isPlayer1: match.self.isPlayer1,
        ),
        size: Dimensions.battlefieldSize(resolution),
        battlefield: match.battlefield,
        nodeComponents: nodeComponents,
        launcherComponents: launcherComponents,
      ),
    );

    add(
      HeaderComponent(
        player1: match.self,
        player2: match.opponent,
        position: Dimensions.headerPosition(
          resolution: resolution,
          isPlayer1: match.self.isPlayer1,
        ),
        size: Dimensions.headerSize(resolution),
      ),
    );

    add(
      ControlsComponent(
        player: match.self,
        position: Dimensions.controlsPosition(
          resolution: resolution,
          isPlayer1: match.self.isPlayer1,
        ),
        size: Dimensions.controlsSize(resolution),
      ),
    );

    return super.onLoad();
  }

  void onMatchUpdated(JsonMatch match) {
    if (match.selfWon) {
      GameComponentRef.instance.onMatchFinished(true);
    } else if (match.opponentWon) {
      GameComponentRef.instance.onMatchFinished(false);
    }
  }

  LauncherComponent? getLauncherAt(Vector2 position) {
    for (final LauncherComponent launcherComponent in launcherComponents) {
      if (launcherComponent.containsPoint(position) &&
          launcherComponent.belongsTo(match.self)) {
        return launcherComponent;
      }
    }

    return null;
  }

  NodeComponent? getNodeAt({
    required List<NodeType> nodeTypes,
    required Vector2 position,
  }) {
    for (final NodeComponent nodeComponent in nodeComponents) {
      if (nodeComponent.containsPoint(position) &&
          nodeTypes.contains(nodeComponent.type)) {
        return nodeComponent;
      }
    }

    return null;
  }

  void highlightNodeAt({
    required List<NodeType> nodeTypes,
    required Vector2 position,
  }) {
    unhighlightNodes();

    final NodeComponent? nodeComponent = getNodeAt(
      nodeTypes: nodeTypes,
      position: position,
    );

    if (nodeComponent != null) {
      nodeComponent.highlight(true);
    }
  }

  void unhighlightNodes() {
    for (final NodeComponent nodeComponent in nodeComponents) {
      nodeComponent.highlight(false);
    }
  }

  void onDeployUnit({
    required LauncherComponent launcherComponent,
    required UnitType unitType,
  }) {
    if (match.self.resources >= unitType.deploymentCost) {
      //match.self.resources -= unitType.deploymentCost;

      final UnitComponent unitComponent = UnitComponent(
        position: launcherComponent.absolutePosition,
        size: nodeSize,
        id: DateTime.now().toIso8601String(),
        type: unitType,
        player: match.self,
      );

      add(unitComponent);
      unitComponents.add(unitComponent);
    }
  }

  void onMoveUnit({
    required UnitComponent unitComponent,
    required NodeComponent nodeComponent,
  }) {
    unitComponent.moveTo(
      location: nodeComponent.jsonPosition,
      position: nodeComponent.absolutePosition,
    );
  }

  void showTarget({
    required Vector2 start,
    required Vector2 end,
  }) {
    targetComponent.setValues(
      start: start,
      end: end,
    );
  }

  void hideTarget() => targetComponent.cleanValues();
}

mixin MatchComponentRef {
  static late MatchComponent instance;

  MatchComponent get match => instance;
}
