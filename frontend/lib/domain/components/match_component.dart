import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/components/header_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/utils/dimensions.dart';

class MatchComponent extends World {
  final Size resolution;
  final JsonMatch match;
  final List<NodeComponent> nodeComponents = [];

  MatchComponent({
    required this.resolution,
    required this.match,
  }) {
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

  NodeComponent? getLauncherAt(Vector2 position) {
    for (final NodeComponent nodeComponent in nodeComponents) {
      if (nodeComponent.containsPoint(position) /*&&
          nodeComponent.node.isDeploymentTarget(match.self)*/ ) {
        return nodeComponent;
      }
    }

    return null;
  }

  /*NodeComponent? getActionTargetAt({
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
  }*/
}

mixin MatchComponentRef {
  static late MatchComponent instance;

  MatchComponent get match => instance;
}
