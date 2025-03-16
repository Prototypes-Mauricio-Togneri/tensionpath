import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/nodes/node_land.dart';
import 'package:tensionpath/domain/state/game/nodes/node_launcher.dart';
import 'package:tensionpath/domain/state/game/nodes/node_victory.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';

class Battlefield {
  final String id;
  final List<Node> nodes;

  const Battlefield({required this.id, required this.nodes});

  void update(double dt) {
    for (final Node node in nodes) {
      node.update(dt);
    }
  }

  factory Battlefield.create({required Player self, required Player enemy}) =>
      Battlefield.w5h9(self: self, enemy: enemy);

  factory Battlefield.w5h9({required Player self, required Player enemy}) {
    const double laneWidth = Constants.UI_BATTLEFIELD_WIDTH / 5;
    const double nodeSize = laneWidth;

    final List<Node> nodes = [];

    for (int x = 0; x < 5; x++) {
      // Land nodes
      for (int y = 1; y <= 7; y++) {
        if (x != 2 || y != 4) {
          nodes.add(NodeLand(x: x, y: y, nodeSize: nodeSize));
        }
      }

      // Self launcher
      nodes.add(NodeLauncher(x: x, y: 0, nodeSize: nodeSize, player: self));
      // Enemy launcher
      nodes.add(NodeLauncher(x: x, y: 8, nodeSize: nodeSize, player: enemy));
    }

    // Victory node
    nodes.add(NodeVictory(x: 2, y: 4, nodeSize: nodeSize));

    return Battlefield(id: 'w5h9', nodes: nodes);
  }
}
