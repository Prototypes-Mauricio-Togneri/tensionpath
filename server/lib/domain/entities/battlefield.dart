import 'package:tensionpath/domain/entities/launcher.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/missile.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/nodes.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/resources.dart';
import 'package:tensionpath/domain/entities/size.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/json/models/start/json_battlefield_start.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/constants.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Battlefield {
  final Size mapSize;
  final Missile missile;
  final IterableMap<String, Resources> resources;
  final IterableMap<String, Launcher> launchers;
  final IterableMap<String, Unit> units;
  final Nodes nodes;

  const Battlefield({
    required this.mapSize,
    required this.missile,
    required this.resources,
    required this.launchers,
    required this.nodes,
    required this.units,
  });

  bool update(double dt) {
    bool result = false;

    for (final Unit unit in units.list) {
      result |= unit.update(dt);
    }

    return result;
  }

  void deployUnit({
    required Player player,
    required Location location,
    required UnitType type,
  }) {
    final Node node = nodes.atLocation(location);
    final Unit unit = Unit(
      id: DateTime.now().toIso8601String(),
      player: player,
      type: type,
      closestNode: node,
      position: node.position,
      health: type.maxHealth.toDouble(),
    );
    units.add(unit.id, unit);
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
    }
  }

  factory Battlefield.fromJson(JsonBattlefieldStart json) {
    final IterableMap<String, Node> nodes = Node.list(json.nodes);

    return Battlefield(
      mapSize: Size.fromJson(json.mapSize),
      missile: Missile.fromJson(
        json: json.missile,
        node: nodes.get(json.missile.location.id),
      ),
      resources: Resources.list(
        json: json.resources,
        nodes: nodes,
      ),
      launchers: Launcher.list(json.launchers),
      nodes: Nodes(nodes),
      units: IterableMap(),
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
