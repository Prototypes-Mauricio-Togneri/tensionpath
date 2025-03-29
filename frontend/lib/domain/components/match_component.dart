import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/components/header_component.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/nodes/node_launcher_component.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class MatchComponent extends World {
  final Size resolution;
  final Player self;
  final Player enemy;
  final Battlefield battlefield;
  NodeComponent? nodeSelected;

  MatchComponent({
    required this.resolution,
    required this.self,
    required this.enemy,
    required this.battlefield,
  }) {
    MatchComponentRef.instance = this;
  }

  @override
  FutureOr onLoad() {
    add(
      BattlefieldComponent(
        battlefield: battlefield,
        position: Vector2(
          -Constants.UI_WIDTH / 2,
          (-resolution.height / 2) + Constants.UI_HEADER_HEIGHT,
        ),
        size: Vector2(
          Constants.UI_WIDTH,
          resolution.height -
              Constants.UI_HEADER_HEIGHT -
              Constants.UI_CONTROLS_HEIGHT,
        ),
      ),
    );
    add(
      HeaderComponent(
        player1: self,
        player2: enemy,
        position: Vector2(-Constants.UI_WIDTH / 2, -resolution.height / 2),
        size: Vector2(Constants.UI_WIDTH, Constants.UI_HEADER_HEIGHT),
      ),
    );
    add(
      ControlsComponent(
        player: self,
        position: Vector2(
          -Constants.UI_WIDTH / 2,
          (resolution.height / 2) - Constants.UI_CONTROLS_HEIGHT,
        ),
        size: Vector2(Constants.UI_WIDTH, Constants.UI_CONTROLS_HEIGHT),
      ),
    );

    return super.onLoad();
  }

  BattlefieldComponent get battlefieldComponent =>
      children.whereType<BattlefieldComponent>().first;

  Iterable<UnitComponent> get unitComponents =>
      battlefieldComponent.children.whereType<UnitComponent>();

  Iterable<NodeComponent> get nodeComponents =>
      battlefieldComponent.children.whereType<NodeComponent>();

  void onPassTurn() {
    self.addResources(self.baseResourceRate);
  }

  void selectNode(NodeComponent? node) {
    nodeSelected = node;
  }

  void unselectNodes() {
    for (final NodeComponent node in nodeComponents) {
      node.hideSelected();
    }
  }

  bool isMovementTarget(NodeComponent node) {
    if (nodeSelected != null) {
      final int distance = nodeSelected!.node.distance(node.node);

      return distance == 1;
    } else {
      return false;
    }
  }

  void moveUnitTo(NodeComponent node) {
    if (nodeSelected != null) {
      node.deployUnit(nodeSelected!.node.unit!);
      nodeSelected!.undeployUnit();
      unselectNodes();
    }
  }

  void highlightNode(NodeComponent? node) {
    for (final NodeComponent node in nodeComponents) {
      node.onHighlighted(false);
    }

    if (node != null) {
      node.onHighlighted(true);
    }
  }

  NodeComponent? getLauncherAt(Vector2 position) {
    for (final NodeComponent node in nodeComponents) {
      if (node is NodeLauncherComponent) {
        final bool isPlayer = node.node.player == self;
        final bool isInPosition = node.containsPoint(position);
        final bool canDeploy = node.node.canDeployUnit;

        if (isPlayer && isInPosition && canDeploy) {
          return node;
        }
      }
    }

    return null;
  }

  void onDeployUnit({required Vector2 position, required UnitType unitType}) {
    final NodeComponent? nodeComponent = getLauncherAt(position);

    if ((nodeComponent != null) &&
        self.hasResources(unitType.cost) &&
        nodeComponent.node.canDeployUnit) {
      self.spendResources(unitType.cost);
      final Unit unit = Unit.fromType(unitType: unitType, player: self);
      nodeComponent.deployUnit(unit);
      nodeComponent.onHighlighted(false);
    }
  }

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
