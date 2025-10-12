import 'package:tensionpath/domain/entities/launcher.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Launchers {
  final IterableMap<String, Launcher> _launchers;

  const Launchers(this._launchers);

  Launcher get(String id) => _launchers.get(id);

  List<Launcher> get list => _launchers.list;

  Launcher? closestLauncher({
    required Position position,
    required Player player,
  }) {
    final List<Launcher> availableLaunchers = _launchers.list
        .where(
          (launcher) => launcher.player == player,
        )
        .toList();

    return closestFromList(
      position: position,
      availableLaunchers: availableLaunchers,
    );
  }

  Launcher? closestEnemyBaseInRange(Unit unit) {
    Launcher? result;
    num closestDistance = double.infinity;
    final List<Launcher> availableLaunchers = _launchers.list
        .where((launcher) => launcher.player != unit.player)
        .toList();

    for (final Launcher launcher in availableLaunchers) {
      final num distance = unit.distanceToBase(launcher);

      if (unit.isInAttackRange(distance) && (distance < closestDistance)) {
        closestDistance = distance;
        result = launcher;
      }
    }

    return result;
  }

  Launcher? closestFromList({
    required Position position,
    required List<Launcher> availableLaunchers,
  }) {
    Launcher? result;
    num closestDistance = double.infinity;

    for (final Launcher launcher in availableLaunchers) {
      final num distance = position.distanceTo(launcher.position);

      if (distance < closestDistance) {
        closestDistance = distance;
        result = launcher;
      }
    }

    return result;
  }
}
