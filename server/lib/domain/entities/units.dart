import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Units {
  final IterableMap<String, Unit> _units;

  Units() : _units = IterableMap();

  void add(Unit unit) => _units.add(unit.id, unit);

  Unit get(String id) => _units.get(id);

  List<Unit> get list => _units.list;

  Unit? closestUnitInRange(Unit unit) {
    Unit? result;
    num closestDistance = double.infinity;
    final List<Unit> enemyUnits = _units.list
        .where((u) => (u.player != unit.player) && u.isAlive)
        .toList();

    for (final Unit enemyUnit in enemyUnits) {
      final num distance = unit.distanceTo(enemyUnit);

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
