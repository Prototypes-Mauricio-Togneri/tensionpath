import 'package:tensionpath/domain/entities/launcher.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Launchers {
  final IterableMap<String, Launcher> _launchers;

  const Launchers(this._launchers);

  Launcher get(String id) => _launchers.get(id);

  List<Launcher> get list => _launchers.list;

  Launcher? closestEnemyBaseInRange(Unit unit) {
    Launcher? result;
    num closestDistance = double.infinity;
    final List<Launcher> availableLaunchers = _launchers.list
        .where((launcher) => launcher.player != unit.player)
        .toList();

    for (final Launcher launcher in availableLaunchers) {
      final num distance = unit.position.distanceTo(launcher.position);

      if (unit.isInAttackRange(distance) && (distance < closestDistance)) {
        closestDistance = distance;
        result = launcher;
      }
    }

    return result;
  }
}
