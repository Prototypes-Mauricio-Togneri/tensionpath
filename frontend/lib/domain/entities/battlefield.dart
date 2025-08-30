import 'package:flutter/services.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/json/json_player.dart';

class Battlefield {
  final String id;
  final List<Node> nodes;
  final Size size;
  final Size gridRatio;

  Battlefield({
    required this.id,
    required this.nodes,
    required this.size,
    required this.gridRatio,
  });

  void replaceWith({
    required JsonPlayer self,
    required Battlefield newBattlefield,
  }) {
    /*final Set<String> visibleNodes = {};

    for (final Node newNode in newBattlefield.nodes) {
      final Node oldNode = nodeById(newNode.id);

      if (oldNode.hasUnit) {
        final Unit unit = oldNode.unit!;

        if (unit.belongsTo(self)) {
          visibleNodes.addAll(
            oldNode.visibleNodes(
              visibilityRange: unit.visibilityRange,
              nodes: nodes,
            ),
          );
        }
      }

      if (oldNode.hasStructure) {
        final Structure structure = oldNode.structure!;

        if (structure.belongsTo(self)) {
          visibleNodes.addAll(
            oldNode.visibleNodes(
              visibilityRange: structure.visibilityRange,
              nodes: nodes,
            ),
          );
        }
      }
    }*/
  }

  Node nodeById(String id) {
    for (final Node node in nodes) {
      if (node.id == id) {
        return node;
      }
    }

    throw Exception('Node with id "$id" not found');
  }
}
