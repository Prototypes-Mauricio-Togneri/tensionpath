import 'package:tensionpath/domain/engine/launchers.dart';
import 'package:tensionpath/domain/engine/location.dart';
import 'package:tensionpath/domain/engine/missile.dart';
import 'package:tensionpath/domain/engine/player.dart';
import 'package:tensionpath/domain/engine/resources.dart';
import 'package:tensionpath/domain/engine/unit.dart';
import 'package:tensionpath/domain/json/models/start/json_battlefield.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/map_list.dart';

class Battlefield {
  final int width;
  final int height;
  final Missile missile;
  final MapList<String, Resources> resources;
  final MapList<String, Launchers> launchers;
  final MapList<String, Location> nodes;
  final MapList<String, Unit> units;

  const Battlefield({
    required this.width,
    required this.height,
    required this.missile,
    required this.resources,
    required this.launchers,
    required this.nodes,
    required this.units,
  });

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
    width: json.size.width,
    height: json.size.height,
    missile: Missile.fromJson(json.missile),
    resources: Resources.list(json.resources),
    launchers: Launchers.list(json.launchers),
    nodes: Location.list(json.nodes),
    units: MapList(),
  );

  Map<String, double> resourcesToJsonUpdate() => Map.fromEntries(
    resources.list.map((r) => MapEntry(r.id, r.amountCurrent)),
  );

  Map<String, JsonUnitUpdate> unitsToJsonUpdate() => Map.fromEntries(
    units.list.map((u) => MapEntry(u.id, u.toJsonUpdate())),
  );
}
