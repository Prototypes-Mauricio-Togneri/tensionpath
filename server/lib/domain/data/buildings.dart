import 'package:tensionpath/domain/entities/building.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/types/building_type.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Buildings {
  final IterableMap<String, Building> _buildings;

  const Buildings(this._buildings);

  Building get(String id) => _buildings.get(id);

  List<Building> get list => _buildings.list;

  Building ofPlayer({
    required Player player,
    required BuildingType type,
  }) {
    for (final Building building in _buildings.list) {
      if ((building.player == player) && (building.type == type)) {
        return building;
      }
    }

    throw Exception('Building $type for player ${player.name} not found');
  }

  Building? closestBuilding({
    required Position position,
    required Player player,
  }) {
    final List<Building> availableBuildings = _buildings.list
        .where(
          (building) => building.player == player,
        )
        .toList();

    return closestFromList(
      position: position,
      availableBuildings: availableBuildings,
    );
  }

  Building? closestEnemyBaseInRange(Unit unit) {
    Building? result;
    num closestDistance = double.infinity;
    final List<Building> availableBuildings = _buildings.list
        .where((building) => building.player != unit.player)
        .toList();

    for (final Building building in availableBuildings) {
      final num distance = unit.distanceToBase(building);

      if (unit.isInAttackRange(distance) && (distance < closestDistance)) {
        closestDistance = distance;
        result = building;
      }
    }

    return result;
  }

  Building? closestFromList({
    required Position position,
    required List<Building> availableBuildings,
  }) {
    Building? result;
    num closestDistance = double.infinity;

    for (final Building building in availableBuildings) {
      final num distance = position.distanceTo(building.position);

      if (distance < closestDistance) {
        closestDistance = distance;
        result = building;
      }
    }

    return result;
  }
}
