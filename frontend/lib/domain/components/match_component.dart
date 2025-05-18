import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/components/header_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/components/reconfigurable.dart';
import 'package:tensionpath/domain/entities/match.dart';
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
        position: Dimensions.battlefieldPosition(resolution),
        size: Dimensions.battlefieldSize(resolution),
        nodeComponents: nodeComponents,
      ),
    );

    add(
      HeaderComponent(
        player1: match.player1,
        player2: match.player2,
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

  void onMatchUpdated(Match match) {
    if (match.selfWon) {
      GameComponentRef.instance.onMatchFinished(true);
    } else if (match.opponentWon) {
      GameComponentRef.instance.onMatchFinished(false);
    } else {
      reconfigure();
    }
  }

  void reconfigure() => _iterateChildrenRecursively(this);

  void _iterateChildrenRecursively(Component component) {
    final dynamic dynamicComponent = component;

    if (dynamicComponent is Reconfigurable) {
      dynamicComponent.reconfigure();
    }

    for (final Component child in component.children) {
      _iterateChildrenRecursively(child);
    }
  }

  /*NodeComponent? getActionTargetAt({
    required Vector2 position,
    required Units unit,
  }) {
    for (final NodeComponent nodeComponent in nodeComponents) {
      if (nodeComponent.containsPoint(position) &&
          nodeComponent.node.isMovementTarget(unit)) {
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
