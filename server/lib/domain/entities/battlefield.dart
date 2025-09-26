import 'package:tensionpath/domain/entities/launcher.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/missile.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/nodes.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/resources.dart';
import 'package:tensionpath/domain/entities/size.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/entities/units.dart';
import 'package:tensionpath/domain/json/models/start/json_battlefield_start.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/constants.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Battlefield {
  final Size mapSize;
  final Size nodeSize;
  final Missile missile;
  final IterableMap<String, Resources> resources;
  final IterableMap<String, Launcher> launchers;
  final Units units;
  final Nodes nodes;

  const Battlefield({
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
      result |= unit.update(
        dt: dt,
        nodes: nodes,
      );
    }

    return missile.update(dt) || result;
  }

  void updateMissile() => missile.update(0);

  void deployUnit({
    required Player player,
    required Location location,
    required UnitType type,
  }) {
    final Node node = nodes.atLocation(location);
    final Unit unit = Unit(
      units: units,
      id: Unit.newId,
      player: player,
      type: type,
      radius: nodeSize.radius,
      closestNode: node,
      position: node.position,
      maxHealth: type.health,
    );
    units.add(unit);
  }

  void moveUnit({
    required Player player,
    required String unitId,
    required Location location,
  }) {
    final Unit unit = units.get(unitId);

    if (unit.player == player) {
      final Node node = nodes.atLocation(location);
      unit.move(node);
    } else {
      throw Exception('Unit $unitId does not belong to player ${player.id}');
    }
  }

  void attackUnit({
    required Player player,
    required String attackerUnitId,
    required String defenderUnitId,
  }) {
    final Unit attackerUnit = units.get(attackerUnitId);
    final Unit defenderUnit = units.get(defenderUnitId);

    if (attackerUnit.player == player) {
      attackerUnit.attack(defenderUnit);
    } else {
      throw Exception(
        'Unit $attackerUnit does not belong to player ${player.id}',
      );
    }
  }

  factory Battlefield.fromJson(JsonBattlefieldStart json) {
    final Nodes nodes = Node.load(json.nodes);

    return Battlefield(
      mapSize: Size.fromJson(json.mapSize),
      nodeSize: Size.fromJson(json.nodeSize),
      missile: Missile.fromJson(
        json: json.missile,
        nodes: nodes,
      ),
      resources: Resources.list(
        json: json.resources,
        nodes: nodes,
      ),
      launchers: Launcher.list(json.launchers),
      nodes: nodes,
      units: Units(),
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
