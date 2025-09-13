import 'package:tensionpath/domain/engine/launcher.dart';
import 'package:tensionpath/domain/engine/missile.dart';
import 'package:tensionpath/domain/engine/resources.dart';
import 'package:tensionpath/domain/engine/unit.dart';
import 'package:tensionpath/domain/json/models/start/json_battlefield.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'package:tensionpath/utils/map_list.dart';

class Battlefield {
  final int width;
  final int height;
  final Missile missile;
  final MapList<String, Resources> resources;
  final MapList<String, Launcher> launchers;
  final MapList<String, Unit> units;

  const Battlefield({
    required this.width,
    required this.height,
    required this.missile,
    required this.resources,
    required this.launchers,
    required this.units,
  });

  factory Battlefield.fromJson(JsonBattlefield json) => Battlefield(
    width: json.size.width,
    height: json.size.height,
    missile: Missile.fromJson(
      jsonMissile: json.missile,
      jsonPlatforms: json.platforms,
    ),
    resources: Resources.list(json.resources),
    launchers: Launcher.list(
      width: json.size.width,
      height: json.size.height,
    ),
    units: MapList(),
  );

  Map<String, JsonUnitUpdate> unitsToJsonUpdate() => Map.fromEntries(
    units.list.map((u) => MapEntry(u.id, u.toJsonUpdate())),
  );
}
