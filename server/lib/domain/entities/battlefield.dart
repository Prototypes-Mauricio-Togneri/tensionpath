import 'package:tensionpath/domain/entities/launchers.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/missile.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/resources.dart';
import 'package:tensionpath/domain/entities/size.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/json/models/start/json_battlefield.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/constants.dart';
import 'package:tensionpath/utils/map_list.dart';

class Battlefield {
  final Size mapSize;
  final Missile missile;
  final MapList<String, Resources> resources;
  final MapList<String, Launchers> launchers;
  final MapList<String, Node> nodes;
  final MapList<String, Unit> units;

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
    final Unit unit = Unit(
      id: DateTime.now().toIso8601String(),
      player: player,
      type: type,
      location: location,
      health: type.maxHealth.toDouble(),
    );
    units.add(unit.id, unit);
  }

  factory Battlefield.fromJson(JsonBattlefield json) => Battlefield(
    mapSize: Size.fromJson(json.mapSize),
    missile: Missile.fromJson(json.missile),
    resources: Resources.list(json.resources),
    launchers: Launchers.list(json.launchers),
    nodes: Node.list(json.nodes),
    units: MapList(),
  );

  Map<String, num> resourcesToJsonUpdate() => Map.fromEntries(
    resources.list.map((r) => MapEntry(r.id, r.amountCurrent)),
  );

  Map<String, JsonUnitUpdate> unitsToJsonUpdate() => Map.fromEntries(
    units.list.map((u) => MapEntry(u.id, u.toJsonUpdate())),
  );

  JsonBattlefield toJson() => JsonBattlefield(
    mapSize: mapSize.toJson(),
    nodeSize: Constants.NODE_SIZE.toJson(),
    missile: missile.toJson(),
    resources: resources.list.map((r) => r.toJson()).toList(),
    launchers: launchers.list.map((l) => l.toJson()).toList(),
    nodes: nodes.list.map((n) => n.toJson()).toList(),
  );
}
