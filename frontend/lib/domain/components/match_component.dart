import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/components/header_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/dimensions.dart';

class MatchComponent extends World {
  final Size resolution;
  final Match match;
  BattlefieldComponent? battlefieldComponent;
  NodeComponent? nodeSelected;

  MatchComponent({required this.resolution, required this.match}) {
    MatchComponentRef.instance = this;
  }

  @override
  FutureOr onLoad() {
    battlefieldComponent = BattlefieldComponent(
      battlefield: match.battlefield,
      position: Dimensions.battlefieldPosition(resolution),
      size: Dimensions.battlefieldSize(resolution),
    );
    add(battlefieldComponent!);

    add(
      HeaderComponent(
        player1: match.self,
        player2: match.opponent,
        position: Dimensions.headerPosition(resolution),
        size: Dimensions.headerSize(resolution),
      ),
    );

    add(
      ControlsComponent(
        player: match.self,
        position: Dimensions.controlsPosition(resolution),
        size: Dimensions.controlsSize(resolution),
      ),
    );

    return super.onLoad();
  }

  List<NodeComponent> get nodeComponents =>
      battlefieldComponent?.nodeComponents ?? [];

  @override
  void update(double dt) {
    super.update(dt);

    match.update(dt);
  }

  void onPassTurn() {
    match.self.addResources(match.self.resourcesRate);
  }

  void selectNode(NodeComponent? node) {
    nodeSelected = node;
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

        if (isEmpty && isInPosition && (distance == 1)) {
          return nodeComponent;
        }
      }
    }

    return null;
  }

  void onDeployUnit({
    required NodeComponent nodeComponent,
    required UnitType unitType,
  }) => match.onDeployUnit(node: nodeComponent.node, unitType: unitType);

  void onMoveUnit({required Node origin, required Node target}) =>
      match.onMoveUnit(nodeOrigin: origin, nodeTarget: target);

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
