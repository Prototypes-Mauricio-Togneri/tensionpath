import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/components/header_component.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/nodes/node_launcher_component.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/dimensions.dart';

class MatchComponent extends World {
  final Size resolution;
  final Player self;
  final Player enemy;
  final Battlefield battlefield;
  BattlefieldComponent? battlefieldComponent;
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
    battlefieldComponent = BattlefieldComponent(
      battlefield: battlefield,
      position: Dimensions.battlefieldPosition(resolution),
      size: Dimensions.battlefieldSize(resolution),
    );

    add(battlefieldComponent!);
    add(
      HeaderComponent(
        player1: self,
        player2: enemy,
        position: Dimensions.headerPosition(resolution),
        size: Dimensions.headerSize(resolution),
      ),
    );
    add(
      ControlsComponent(
        player: self,
        position: Dimensions.controlsPosition(resolution),
        size: Dimensions.controlsSize(resolution),
      ),
    );

    return super.onLoad();
  }

  List<NodeComponent> get nodeComponents =>
      battlefieldComponent?.nodeComponents ?? [];

  void onPassTurn() {
    self.addResources(self.baseResourceRate);
  }

  void selectNode(NodeComponent? node) {
    nodeSelected = node;
  }

  void unselectNodes() {
    for (final NodeComponent nodeComponent in nodeComponents) {
      nodeComponent.hideSelected();
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

  void moveUnitTo(NodeComponent nodeComponent) {
    if (nodeSelected != null) {
      nodeComponent.node.moveUnitTo(nodeSelected!.node);
      unselectNodes();
    }
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
      if (nodeComponent is NodeLauncherComponent) {
        final bool isPlayer = nodeComponent.node.belongsTo(self);
        final bool isInPosition = nodeComponent.containsPoint(position);
        final bool canDeploy = !nodeComponent.node.containsUnit;

        if (isPlayer && isInPosition && canDeploy) {
          return nodeComponent;
        }
      }
    }

    return null;
  }

  void onDeployUnit({
    required NodeComponent nodeComponent,
    required UnitType unitType,
  }) {
    if (self.hasResources(unitType.cost) && !nodeComponent.node.containsUnit) {
      self.spendResources(unitType.cost);
      final Unit unit = Unit.fromType(unitType: unitType, player: self);
      nodeComponent.node.deployUnit(unit);
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
