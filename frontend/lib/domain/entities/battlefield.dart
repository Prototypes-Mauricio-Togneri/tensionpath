import 'package:flutter/services.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/extensions/size_extension.dart';

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

  Node nodeByPosition(int x, int y) {
    for (final Node node in nodes) {
      if ((node.x == x) && (node.y == y)) {
        return node;
      }
    }

    throw Exception('Node not found at position ($x, $y)');
  }

  JsonBattlefield deployUnit({required Node node, required Unit unit}) {
    final List<JsonNode> jsonNodes = [];

    for (final Node currentNode in nodes) {
      if (currentNode == node) {
        jsonNodes.add(node.withUnitDeployed(unit));
      } else {
        jsonNodes.add(currentNode.toJson());
      }
    }

    return JsonBattlefield(
      id: id,
      size: size.toJsonSize(),
      gridRatio: gridRatio.toJsonRatio(),
      nodes: jsonNodes,
    );
  }

  JsonBattlefield moveUnit({
    required Node nodeOrigin,
    required Node nodeTarget,
  }) {
    final List<JsonNode> jsonNodes = [];
    final Unit unit = nodeOrigin.unit;

    for (final Node currentNode in nodes) {
      if (currentNode == nodeOrigin) {
        jsonNodes.add(nodeOrigin.withUnitUndeployed());
      } else if (currentNode == nodeOrigin) {
        jsonNodes.add(nodeTarget.withUnitDeployed(unit));
      } else {
        jsonNodes.add(currentNode.toJson());
      }
    }

    return JsonBattlefield(
      id: id,
      size: size.toJsonSize(),
      gridRatio: gridRatio.toJsonRatio(),
      nodes: jsonNodes,
    );
  }
}
