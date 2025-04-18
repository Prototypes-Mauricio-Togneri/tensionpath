import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/components/header_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/dimensions.dart';

class MatchComponent extends World {
  final Size resolution;
  final Match match;
  final List<NodeComponent> nodeComponents = [];

  MatchComponent({required this.resolution, required this.match}) {
    MatchComponentRef.instance = this;
  }

  @override
  FutureOr onLoad() {
    add(
      BattlefieldComponent(
        battlefield: match.battlefield,
        position: Dimensions.battlefieldPosition(
          resolution: resolution,
          isPlayer1: match.self.isPlayer1,
        ),
        size: Dimensions.battlefieldSize(resolution),
        nodeComponents: nodeComponents,
      ),
    );

    add(
      HeaderComponent(
        player1: match.player1,
        player2: match.player2,
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

  @override
  void update(double dt) {
    super.update(dt);

    match.update(dt);
  }

  void highlightNode(NodeComponent? node) {
    for (final NodeComponent nodeComponent in nodeComponents) {
      nodeComponent.onHighlighted(false);
    }

    if (node != null) {
      node.onHighlighted(true);
    }
  }

  NodeComponent? getLauncherAt(Vector2 position) {
    for (final NodeComponent nodeComponent in nodeComponents) {
      if (nodeComponent.node.hasLauncher) {
        final bool isPlayer = nodeComponent.node.belongsTo(match.self);
        final bool isInPosition = nodeComponent.containsPoint(position);
        final bool canDeploy = !nodeComponent.node.hasUnit;

        if (isPlayer && isInPosition && canDeploy) {
          return nodeComponent;
        }
      }
    }

    return null;
  }

  NodeComponent? getActionTargetAt({
    required Vector2 position,
    required Node origin,
  }) {
    for (final NodeComponent nodeComponent in nodeComponents) {
      if (nodeComponent.node.isActionTarget) {
        final bool isEmpty = !nodeComponent.node.hasUnit;
        final bool isInPosition = nodeComponent.containsPoint(position);
        final int distance = nodeComponent.node.distance(origin);

        if (isEmpty &&
            isInPosition &&
            (origin.unit!.remainingMoves > 0) &&
            (distance == 1)) {
          return nodeComponent;
        }
      }
    }

    return null;
  }

  void onDeployUnit({required Node node, required UnitType unitType}) =>
      match.onDeployUnit(node: node, unitType: unitType);

  void onMoveUnit({
    required Unit unit,
    required Node origin,
    required Node target,
  }) => match.onMoveUnit(unit: unit, nodeOrigin: origin, nodeTarget: target);

  void onEndTurn() => match.onEndTurn();

  void onOpponentEndTurn() => match.onOpponentEndTurn();

  /*void onUnitDestroyed(Unit unit) {
    unit.destroy();

    for (final UnitComponent unitComponent in unitComponents) {
      if (unitComponent.unit == unit) {
        remove(unitComponent);
        break;
      }
    }
  }*/
}

mixin MatchComponentRef {
  static late MatchComponent instance;

  MatchComponent get match => instance;
}
