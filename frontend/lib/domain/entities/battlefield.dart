import 'package:flutter/widgets.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/entities/nodes/node_land.dart';
import 'package:tensionpath/domain/entities/nodes/node_launcher.dart';
import 'package:tensionpath/domain/entities/nodes/node_victory.dart';
import 'package:tensionpath/domain/entities/players/player.dart';

class Battlefield {
  final String id;
  final List<Node> nodes;
  final Size size;

  const Battlefield({
    required this.id,
    required this.nodes,
    required this.size,
  });

  void update(double dt) {
    for (final Node node in nodes) {
      node.update(dt);
    }
  }

  factory Battlefield.create({required Player self, required Player enemy}) =>
      Battlefield.w5h9(self: self, enemy: enemy);

  factory Battlefield.w5h9({required Player self, required Player enemy}) {
    const int widthCells = 7;
    const int heightCells = 13;

    const double laneWidth = Constants.SCREEN_WIDTH / widthCells;
    const double nodeSize = laneWidth;

    final List<Node> nodes = [];

    const int midCellX = widthCells ~/ 2;
    const int midCellY = heightCells ~/ 2;

    for (int x = 0; x < widthCells; x++) {
      // Land nodes
      for (int y = 1; y <= heightCells - 2; y++) {
        if (x != midCellX || y != midCellY) {
          nodes.add(NodeLand(x: x, y: y, nodeSize: nodeSize));
        }
      }

      // Self launcher
      nodes.add(NodeLauncher(x: x, y: 0, nodeSize: nodeSize, player: self));
      // Enemy launcher
      nodes.add(
        NodeLauncher(
          x: x,
          y: heightCells - 1,
          nodeSize: nodeSize,
          player: enemy,
        ),
      );
    }

    // Victory node
    nodes.add(NodeVictory(x: midCellX, y: midCellY, nodeSize: nodeSize));

    return Battlefield(
      id: 'w5h9',
      nodes: nodes,
      size: const Size(nodeSize * widthCells, nodeSize * heightCells),
    );
  }
}
