import 'package:tensionpath/domain/engine/launchers.dart';
import 'package:tensionpath/domain/engine/location.dart';
import 'package:tensionpath/domain/engine/missile.dart';
import 'package:tensionpath/domain/engine/resources.dart';
import 'package:tensionpath/domain/engine/unit.dart';
import 'package:tensionpath/domain/json/models/start/json_battlefield.dart';
import 'package:tensionpath/utils/map_list.dart';

class Battlefield {
  final int width;
  final int height;
  final Missile missile;
  final MapList<String, Resources> resources;
  final MapList<String, Launchers> launchers;
  final List<Location> nodes;
  final List<Unit> units;

  const Battlefield({
    required this.width,
    required this.height,
    required this.missile,
    required this.resources,
    required this.launchers,
    required this.nodes,
    required this.units,
  });

  factory Battlefield.fromJson(JsonBattlefield json) => Battlefield(
    width: json.size.width,
    height: json.size.height,
    missile: Missile.fromJson(json.missile),
    resources: Resources.list(json.resources),
    launchers: MapList(),
    nodes: [],
    units: [],
  );
}
