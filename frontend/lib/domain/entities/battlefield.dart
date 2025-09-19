import 'package:tensionpath/domain/entities/size.dart';
import 'package:tensionpath/domain/json/models/start/json_battlefield.dart';

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

  factory Battlefield.fromJson(JsonBattlefield jsonBattlefield) =>
      const Battlefield();
}
