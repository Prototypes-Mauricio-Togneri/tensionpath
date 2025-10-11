import 'package:tensionpath/domain/data/launchers.dart';
import 'package:tensionpath/domain/data/nodes.dart';
import 'package:tensionpath/domain/data/players.dart';
import 'package:tensionpath/domain/data/resources.dart';
import 'package:tensionpath/domain/data/units.dart';
import 'package:tensionpath/domain/entities/config.dart';
import 'package:tensionpath/domain/entities/launcher.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/missile.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/resource.dart';
import 'package:tensionpath/domain/entities/size.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/json/models/start/json_battlefield_start.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/constants.dart';

class Battlefield {
  final Config config;
  final Size mapSize;
  final Size nodeSize;
  final Missile missile;
  final Resources resources;
  final Launchers launchers;
  final Units units;
  final Nodes nodes;

  const Battlefield({
    required this.config,
    required this.mapSize,
    required this.nodeSize,
    required this.missile,
    required this.resources,
    required this.launchers,
    required this.nodes,
    required this.units,
  });

  bool update(double dt) {
    bool result = false;

    for (final Unit unit in units.list) {
      if (unit.isAlive) {
        result |= unit.update(dt);
      }
    }

    result |= units.removeDestroyed();

    return missile.update(dt) || result;
  }

  void updateMissile() => missile.update(0);

  void deployUnit({
    required Player player,
    required Location location,
    required UnitType type,
  }) {
    final Node targetNode = nodes.atLocation(location);
    final Launcher? launcher = launchers.closestLauncher(
      position: targetNode.position,
      player: player,
    );
    final Node originNode = nodes.get(launcher!.id);

    final Unit unit = Unit(
      config: config,
      nodes: nodes,
      resources: resources,
      launchers: launchers,
      units: units,
      id: Unit.newId,
      player: player,
      type: type,
      radius: nodeSize.radius,
      closestNode: originNode,
      position: originNode.position,
      maxHealth: type.health,
    );
    units.add(unit);
    unit.move(
      node: targetNode,
      manual: true,
    );
  }

  void unitAction({
    required Player player,
    required String unitId,
    required Location? targetLocation,
    required String? targetUnitId,
  }) {
    if ((targetLocation == null) && targetUnitId == null) {
      throw Exception('Either targetLocation or targetUnitId must be provided');
    }

    final Unit attackerUnit = units.get(unitId);
    final Unit? defenderUnit = targetUnitId != null
        ? units.get(targetUnitId)
        : null;

    if (!attackerUnit.isAlive || (attackerUnit.player != player)) {
      throw Exception('Invalid attacker unit');
    }

    if (defenderUnit == null) {
      final Node targetNode = nodes.atLocation(targetLocation!);

      if (targetNode.type == NodeType.launcher) {
        final Launcher targetBase = launchers.get(targetNode.id);
        final num distanceToTarget = attackerUnit.distanceToBase(targetBase);

        if (!attackerUnit.isInAttackRange(distanceToTarget)) {
          final Node? alternativeNode = nodes.closestAlternative(
            node: targetNode,
            unit: attackerUnit,
          );

          if (alternativeNode != null) {
            attackerUnit.move(
              node: alternativeNode,
              manual: true,
            );
          }
        }

        attackerUnit.attackBase(targetBase);
      } else {
        attackerUnit.move(
          node: targetNode,
          manual: true,
        );
      }
    } else if (defenderUnit.isAlive) {
      final num distanceToTarget = attackerUnit.distanceToUnit(defenderUnit);

      if (!attackerUnit.isInAttackRange(distanceToTarget)) {
        final Node targetNode =
            defenderUnit.lockedNode ?? defenderUnit.closestNode;
        final Node? alternativeNode = nodes.closestAlternative(
          node: targetNode,
          unit: attackerUnit,
        );

        if (alternativeNode != null) {
          attackerUnit.move(
            node: alternativeNode,
            manual: true,
          );
        }
      }

      attackerUnit.attackUnit(defenderUnit);
    }
  }

  factory Battlefield.fromJson({
    required JsonBattlefieldStart json,
    required Config config,
    required Players players,
  }) {
    final Nodes nodes = Node.load(json.nodes);
    final Size nodeSize = Size.fromJson(json.nodeSize);
    final Units units = Units(maxHarvestersCount: config.maxHarvestersCount);

    return Battlefield(
      config: config,
      mapSize: Size.fromJson(json.mapSize),
      nodeSize: nodeSize,
      missile: Missile.fromJson(
        json: json.missile,
        nodes: nodes,
        units: units,
      ),
      resources: Resources(
        Resource.list(
          json: json.resources,
          nodes: nodes,
        ),
      ),
      launchers: Launchers(
        Launcher.list(
          json: json.launchers,
          players: players,
          radius: nodeSize.radius,
        ),
      ),
      nodes: nodes,
      units: units,
    );
  }

  Map<String, num> resourcesToJsonUpdate() => Map.fromEntries(
    resources.list.map((r) => MapEntry(r.id, r.amountCurrent)),
  );

  Map<String, JsonUnitUpdate> unitsToJsonUpdate() => Map.fromEntries(
    units.list.map((u) => MapEntry(u.id, u.toJsonUpdate())),
  );

  JsonBattlefieldStart toJsonStart() => JsonBattlefieldStart(
    mapSize: mapSize.toJson(),
    nodeSize: Constants.NODE_SIZE.toJson(),
    missile: missile.toJsonStart(),
    resources: resources.list.map((r) => r.toJsonStart()).toList(),
    launchers: launchers.list.map((l) => l.toJsonStart()).toList(),
    nodes: nodes.list.map((n) => n.toJsonStart()).toList(),
  );
}
