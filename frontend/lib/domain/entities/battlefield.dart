import 'package:flutter/services.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/missile.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/platform.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/structures/structure_resources.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/entities/units/unit_fuel_truck.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class Battlefield {
  final String id;
  final List<Node> nodes;
  final Size size;
  final Size gridRatio;
  final Missile missile;

  Battlefield({
    required this.id,
    required this.nodes,
    required this.size,
    required this.gridRatio,
    required this.missile,
  }) {
    final List<Platform> platforms = [];

    final Iterable<Node> nodePads = nodes.where(
      (node) => node.hasStructure && node.structure?.type == StructureType.pad,
    );

    for (int i = 0; i < missile.numberOfPlatforms; i++) {
      final String platformId = '${i + 1}';
      platforms.add(
        Platform(
          platformId: platformId,
          nodes:
              nodePads
                  .where((node) => node.structure?.getPlatformId == platformId)
                  .toList(),
        ),
      );
    }

    missile.setPlatforms(platforms);
  }

  Platform platformById(String id) {
    for (final Platform platform in missile.platforms) {
      if (platform.platformId == id) {
        return platform;
      }
    }

    throw Exception('Platform with id "$id" not found');
  }

  void replaceWith({
    required Player self,
    required Battlefield newBattlefield,
  }) {
    final Set<String> visibleNodes = {};

    for (final Node newNode in newBattlefield.nodes) {
      final Node oldNode = nodeById(newNode.id);
      oldNode.replaceWith(newNode);

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
    }

    for (final Node node in nodes) {
      node.setRevealed(visibleNodes.contains(node.id));
    }
  }

  int fuelCollected(Player player) {
    int result = 0;

    for (final Node node in nodes) {
      if (node.hasStructure && node.hasUnit) {
        final Structure structure = node.structure!;
        final Unit unit = node.unit!;

        if ((structure is StructureResources) &&
            unit.belongsTo(player) &&
            (unit is UnitFuelTruck)) {
          result += Constants.FUEL_TRUCK_COLLECTION;
        }
      }
    }

    return result;
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
