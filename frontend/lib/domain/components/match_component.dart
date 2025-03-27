import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/components/header_component.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class MatchComponent extends World {
  final Size resolution;
  final Player self;
  final Player enemy;
  final Battlefield battlefield;

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

  void highlightNode(NodeComponent? node) {
    for (final NodeComponent node in nodeComponents) {
      node.highlight = false;
    }

    if (node != null) {
      node.highlight = true;
    }
  }

  NodeComponent? getLauncherAt(Vector2 position) => getNodeAt(
    position: position,
    nodeTypes: [NodeType.launcher],
    player: self,
  );

  NodeComponent? getNodeAt({
    required Vector2 position,
    required List<NodeType> nodeTypes,
    Player? player,
  }) {
    for (final NodeComponent node in nodeComponents) {
      final bool isNodeType = nodeTypes.contains(node.node.type);
      final bool isPlayer = player == null || node.node.player == player;
      final bool isInPosition = node.containsPoint(position);

      if (isNodeType && isPlayer && isInPosition) {
        return node;
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
      final Unit unit = Unit.fromType(unitType: unitType, owner: self);
      nodeComponent.deployUnit(unit);
      nodeComponent.highlight = false;
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
