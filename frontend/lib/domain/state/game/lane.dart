import 'package:tensionpath/domain/state/game/nodes/node.dart';

class Lane {
  final String id;
  final List<Node> nodes;

  const Lane({
    required this.id,
    required this.nodes,
  });

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
