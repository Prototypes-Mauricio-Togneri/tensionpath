import 'package:flutter/services.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/missile.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/units.dart';

class Battlefield {
  final String id;
  final List<Node> nodes;
  final Size size;
  final Missile missile;

  Battlefield({
    required this.id,
    required this.nodes,
    required this.size,
    required this.missile,
  });

  String? platformOwner(String id) => missile.platformOwner(id);

  void replaceWith({
    required Player self,
    required Battlefield newBattlefield,
  }) {
    final Set<String> visibleNodes = {};

    for (final Node newNode in newBattlefield.nodes) {
      final Node oldNode = _nodeById(newNode.id);
      oldNode.replaceWith(newNode);

      if (oldNode.hasUnits) {
        final Units unit = oldNode.units!;

        if (unit.belongsTo(self)) {
          visibleNodes.addAll(
            oldNode.visibleNodes(
              visibilityRange: Constants.UNITS_VISIBILITY_RANGE,
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
    }

    for (final Node node in nodes) {
      node.setRevealed(visibleNodes.contains(node.id));
    }

    missile.replaceWith(newBattlefield.missile);
  }

  Node _nodeById(String id) {
    for (final Node node in nodes) {
      if (node.id == id) {
        return node;
      }
    }

    throw Exception('Node with id "$id" not found');
  }
}
