import 'package:tensionpath/domain/entities/building.dart';
import 'package:tensionpath/domain/entities/player.dart';
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
}
