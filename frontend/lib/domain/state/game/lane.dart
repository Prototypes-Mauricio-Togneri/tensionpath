import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';

class Lane {
  final String id;
  final List<Node> nodes;

  const Lane({
    required this.id,
    required this.nodes,
  });

  List<Node> nodesFromPlayer(Player player) =>
      nodes.where((n) => n.owner == player).toList();

  List<Node> getNodes({
    required bool forward,
    Node? from,
  }) {
    final List<Node> list = forward ? nodes : nodes.reversed.toList();
    final List<Node> result = [];
    bool found = false;

    for (final Node node in list) {
      if ((node == from) || (from == null)) {
        found = true;
      }

      if (found) {
        result.add(node);
      }
    }

    return result;
  }
}
