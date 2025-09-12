import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/components/header_component.dart';
import 'package:tensionpath/domain/components/launcher_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/components/target_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/start/json_match.dart';
import 'package:tensionpath/domain/json/models/start/json_player.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';

class MatchComponent extends World {
  final Vector2 resolution;
  final JsonMatch match;
  final List<NodeComponent> nodeComponents = [];
  final List<LauncherComponent> launcherComponents = [];
  final List<UnitComponent> unitComponents = [];
  late final Player self;
  late final Player opponent;
  late final Vector2 nodeSize;
  late final DateTime startedAt;
  late final TargetComponent targetComponent;

  MatchComponent({
    required this.resolution,
    required this.match,
  }) {
    MatchComponentRef.instance = this;
    self = Player.fromJson(matchSelf(match));
    opponent = Player.fromJson(matchOpponent(match));
    startedAt = DateTime.parse(match.createdAt).toLocal();
  }

  int get timeElapsed => DateTime.now().difference(startedAt).inSeconds;

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
          isPlayer1: self.isPlayer1,
        ),
        size: Dimensions.battlefieldSize(resolution),
        battlefield: match.battlefield,
        self: self,
        opponent: opponent,
        nodeComponents: nodeComponents,
        launcherComponents: launcherComponents,
        unitComponents: unitComponents,
      ),
    );

    add(
      HeaderComponent(
        player1: self,
        player2: opponent,
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
        position: Dimensions.controlsPosition(
          resolution: resolution,
          isPlayer1: self.isPlayer1,
        ),
        size: Dimensions.controlsSize(resolution),
      ),
    );

    return super.onLoad();
  }

  void onMatchUpdated(JsonMatch match) {
    self.update(matchSelf(match));
    opponent.update(matchOpponent(match));
  }

  JsonPlayer matchSelf(JsonMatch match) =>
      match.players.firstWhere((player) => player.isSelf);

  JsonPlayer matchOpponent(JsonMatch match) =>
      match.players.firstWhere((player) => !player.isSelf);

  LauncherComponent? getLauncherAt(Vector2 position) {
    for (final LauncherComponent launcherComponent in launcherComponents) {
      if (launcherComponent.containsPoint(position) &&
          launcherComponent.belongsTo(self)) {
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

  NodeComponent getClosestNode({
    required List<NodeType> nodeTypes,
    required Vector2 position,
  }) {
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

  NodeComponent getNodeById(String id) {
    for (final NodeComponent nodeComponent in nodeComponents) {
      if (nodeComponent.location.id == id) {
        return nodeComponent;
      }
    }

    throw Exception('Node not found');
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
    required JsonLocation location,
    required UnitType type,
  }) {
    game.matchState.onDeployUnit(
      location: location,
      type: type,
    );

    /*if (self.resources >= unitType.deploymentCost) {
      self.removeResources(unitType.deploymentCost);

      final UnitComponent unitComponent = UnitComponent(
        position: launcherComponent.absolutePosition,
        size: nodeSize,
        id: DateTime.now().toIso8601String(),
        type: unitType,
        player: self,
        currentNodeType: NodeType.launcher,
        currentLocation: launcherComponent.nodeComponent.location,
      );

      add(unitComponent);
      unitComponents.add(unitComponent);
    }*/
  }

  void onMoveUnit({
    required UnitComponent unitComponent,
    required NodeComponent nodeComponent,
  }) {
    unitComponent.moveTo(
      location: nodeComponent.location,
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
