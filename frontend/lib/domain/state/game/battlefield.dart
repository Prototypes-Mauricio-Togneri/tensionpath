import 'package:flame/game.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/nodes/node_land.dart';
import 'package:tensionpath/domain/state/game/nodes/node_launcher.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';

class Battlefield {
  final String id;
  final List<Node> nodes;
  final Vector2 mapSize;
  final double laneWidth;

  const Battlefield({
    required this.id,
    required this.nodes,
    required this.mapSize,
    required this.laneWidth,
  });

  double get nodeSize => laneWidth;

  void update(double dt) {
    for (final Node node in nodes) {
      node.update(dt);
    }
  }

  factory Battlefield.create({required Player self, required Player enemy}) =>
      Battlefield.w5h9(self: self, enemy: enemy);

  factory Battlefield.w5h9({required Player self, required Player enemy}) {
    //const double laneHeight = Constants.UI_BATTLEFIELD_HEIGHT;
    const double laneWidth = Constants.UI_BATTLEFIELD_WIDTH / 5;
    const double nodeSize = laneWidth;

    final List<Node> nodes = [];

    // Lane 1
    for (int y = 1; y <= 7; y++) {
      nodes.add(NodeLand(x: 0, y: y, nodeSize: nodeSize));
    }

    // Self launcher
    nodes.add(NodeLauncher(x: 0, y: 0, nodeSize: nodeSize, player: self));
    // Enemy launcher
    nodes.add(NodeLauncher(x: 0, y: 8, nodeSize: nodeSize, player: enemy));

    // Lane 2
    for (int y = 2; y <= 6; y++) {
      nodes.add(NodeLand(x: 1, y: y, nodeSize: nodeSize));
    }

    // Self launcher
    nodes.add(NodeLauncher(x: 1, y: 0, nodeSize: nodeSize, player: self));
    // Enemy launcher
    nodes.add(NodeLauncher(x: 1, y: 8, nodeSize: nodeSize, player: enemy));

    // Lane 3
    for (int y = 1; y <= 7; y++) {
      nodes.add(NodeLand(x: 2, y: y, nodeSize: nodeSize));
    }

    // Self launcher
    nodes.add(NodeLauncher(x: 2, y: 0, nodeSize: nodeSize, player: self));
    // Enemy launcher
    nodes.add(NodeLauncher(x: 2, y: 8, nodeSize: nodeSize, player: enemy));

    // Lane 4
    for (int y = 2; y <= 6; y++) {
      nodes.add(NodeLand(x: 3, y: y, nodeSize: nodeSize));
    }

    // Self launcher
    nodes.add(NodeLauncher(x: 3, y: 0, nodeSize: nodeSize, player: self));
    // Enemy launcher
    nodes.add(NodeLauncher(x: 3, y: 8, nodeSize: nodeSize, player: enemy));

    // Lane 5
    for (int y = 1; y <= 7; y++) {
      nodes.add(NodeLand(x: 4, y: y, nodeSize: nodeSize));
    }

    // Self launcher
    nodes.add(NodeLauncher(x: 4, y: 0, nodeSize: nodeSize, player: self));
    // Enemy launcher
    nodes.add(NodeLauncher(x: 4, y: 8, nodeSize: nodeSize, player: enemy));

    return Battlefield(
      id: 'vector',
      mapSize: Vector2(
        Constants.UI_BATTLEFIELD_WIDTH,
        Constants.UI_BATTLEFIELD_HEIGHT,
      ),
      laneWidth: laneWidth,
      nodes: nodes,
    );
  }
}
