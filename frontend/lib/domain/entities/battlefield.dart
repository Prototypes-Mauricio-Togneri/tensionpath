import 'package:flutter/services.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/structures/structure_resources.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/entities/units/unit_fuel_truck.dart';

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
