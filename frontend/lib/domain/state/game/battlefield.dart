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

  const Battlefield({
    required this.id,
    required this.nodes,
    required this.mapSize,
  });

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

    for (int x = 0; x < 5; x++) {
      final int landNodes = (x % 2) == 0 ? 7 : 6;

      // Land nodes
      for (int y = 1; y <= landNodes; y++) {
        nodes.add(NodeLand(x: x, y: y, nodeSize: nodeSize));
      }

      // Self launcher
      nodes.add(NodeLauncher(x: x, y: 0, nodeSize: nodeSize, player: self));
      // Enemy launcher
      nodes.add(
        NodeLauncher(x: x, y: landNodes + 1, nodeSize: nodeSize, player: enemy),
      );
    }

    return Battlefield(
      id: 'w5h9',
      mapSize: Vector2(
        Constants.UI_BATTLEFIELD_WIDTH,
        Constants.UI_BATTLEFIELD_HEIGHT,
      ),
      nodes: nodes,
    );
  }
}
