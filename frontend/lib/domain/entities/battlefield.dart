import 'package:flutter/services.dart';
import 'package:tensionpath/domain/entities/node.dart';

class Battlefield {
  final String id;
  final List<Node> nodes;
  final Size size;
  final Size gridRatio;

  const Battlefield({
    required this.id,
    required this.nodes,
    required this.size,
    required this.gridRatio,
  });

  Node nodeById(String id) {
    for (final Node node in nodes) {
      if (node.id == id) {
        return node;
      }
    }

    throw Exception('Node with id "$id" not found');
  }
}
