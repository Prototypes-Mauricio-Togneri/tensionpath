import 'dart:math';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Units {
  final int maxHarvestersCount;
  final IterableMap<String, Unit> _units;
  final Map<String, int> _harvesterMaxCount = {};

  Units({
    required this.maxHarvestersCount,
  }) : _units = IterableMap();

  int harvesterCurrentCount(String playerIndex) => _units.list
      .where(
        (unit) =>
            (unit.player.index == playerIndex) &&
            (unit.type == UnitType.harvester),
      )
      .length;

  int harvesterMaxCount(String playerIndex) =>
      _harvesterMaxCount[playerIndex] ?? 0;

  bool hasMaxHarvesters(String playerIndex) =>
      harvesterCurrentCount(playerIndex) >= maxHarvestersCount;

  int unitCost({
    required UnitType type,
    required Player player,
  }) {
    if (type == UnitType.harvester) {
      final int currentCount = harvesterCurrentCount(player.index);
      final int maxCount = harvesterMaxCount(player.index);

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

      if (_harvesterMaxCount.containsKey(playerIndex)) {
        _harvesterMaxCount[playerIndex] = min(
          _harvesterMaxCount[playerIndex]! + 1,
          maxHarvestersCount,
        );
      } else {
        _harvesterMaxCount[playerIndex] = 1;
      }
    }
  }

  Unit get(String id) => _units.get(id);

  List<Unit> get list => _units.list;

  Unit? closestUnitInRange(Unit unit) {
    Unit? result;
    num closestDistance = double.infinity;
    final List<Unit> enemyUnits = _units.list
        .where((u) => (u.player != unit.player) && u.isAlive)
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
