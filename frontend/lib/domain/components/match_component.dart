import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/components/header_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/components/structures/structure_missile_component.dart';
import 'package:tensionpath/domain/components/structures/structure_pad_component.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
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

  void onMatchUpdated(Match match) {
    if (match.selfWon) {
      GameComponentRef.instance.onMatchFinished(true);
    } else if (match.opponentWon) {
      GameComponentRef.instance.onMatchFinished(false);
    } else {
      _iterateChildrenRecursively(this);
    }
  }

  void _iterateChildrenRecursively(Component component) {
    if (component is StructurePadComponent) {
      component.reconfigure();
    } else if (component is NodeComponent) {
      component.reconfigure();
    } else if (component is MissileIndicatorComponent) {
      component.reconfigure();
    } else if (component is PopcapComponent) {
      component.reconfigure();
    } else if (component is UnitSelectorComponent) {
      component.reconfigure();
    }

    for (final Component child in component.children) {
      _iterateChildrenRecursively(child);
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
      if (nodeComponent.containsPoint(position) &&
          nodeComponent.node.isDeploymentTarget(match.self)) {
        return nodeComponent;
      }
    }

    return null;
  }

  NodeComponent? getActionTargetAt({
    required Vector2 position,
    required Unit unit,
  }) {
    for (final NodeComponent nodeComponent in nodeComponents) {
      if (nodeComponent.containsPoint(position) &&
          (nodeComponent.node.isMovementTarget(unit) ||
              nodeComponent.node.isAttackUnitTarget(unit) ||
              nodeComponent.node.isAttackBaseTarget(unit))) {
        return nodeComponent;
      }
    }

    return null;
  }
}

mixin MatchComponentRef {
  static late MatchComponent instance;

  MatchComponent get match => instance;
}
