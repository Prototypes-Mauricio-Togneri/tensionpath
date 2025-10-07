import 'dart:math';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Units {
  final int maxHarvestersCount;
  final IterableMap<String, Unit> _units;
  final Map<String, int> _maxHarvesterCount = {};

  Units({
    required this.maxHarvestersCount,
  }) : _units = IterableMap();

  int currentHarvesterCount(String playerIndex) => _units.list
      .where(
        (unit) =>
            (unit.player.index == playerIndex) &&
            (unit.type == UnitType.harvester),
      )
      .length;

  int maxHarvesterCount(String playerIndex) =>
      _maxHarvesterCount[playerIndex] ?? 0;

  bool hasMaxHarvesters(String playerIndex) =>
      currentHarvesterCount(playerIndex) >= maxHarvestersCount;

  int currentHarvestersWorking(String playerIndex) => _units.list
      .where(
        (unit) => (unit.player.index == playerIndex) && (unit.isHarvesting),
      )
      .length;

  int unitCost({
    required UnitType type,
    required Player player,
  }) {
    if (type == UnitType.harvester) {
      final int currentCount = currentHarvesterCount(player.index);
      final int maxCount = maxHarvesterCount(player.index);

      if (currentCount < maxCount) {
        return 0;
      } else {
        return type.cost;
      }
    } else {
      return type.cost;
    }
  }

  void add(Unit unit) {
    _units.add(unit.id, unit);

    if (unit.type == UnitType.harvester) {
      final String playerIndex = unit.player.index;
      _maxHarvesterCount[playerIndex] = max(
        maxHarvesterCount(playerIndex),
        currentHarvesterCount(playerIndex),
      );
    }
  }

  Unit get(String id) => _units.get(id);

  List<Unit> get list => _units.list;

  Unit? closestUnitInRange(Unit unit) {
    Unit? result;
    num closestDistance = double.infinity;
    final List<Unit> enemyUnits = _units.list
        .where(
          (u) =>
              (u.player != unit.player) &&
              u.isAlive &&
              (unit.type.damageAgainst(u.type.clazz) > 0),
        )
        .toList();

    for (final Unit enemyUnit in enemyUnits) {
      final num distance = unit.distanceToUnit(enemyUnit);

      if (unit.isInAttackRange(distance) && (distance < closestDistance)) {
        closestDistance = distance;
        result = enemyUnit;
      }
    }

    return result;
  }

  bool removeDestroyed() {
    final List<Unit> unitsToRemove = _units.list
        .where((unit) => !unit.isAlive)
        .toList();

    for (final Unit unit in unitsToRemove) {
      _units.remove(unit.id);
    }

    return unitsToRemove.isNotEmpty;
  }
}
