import 'package:tensionpath/domain/entities/launchers.dart';
import 'package:tensionpath/domain/entities/missile.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/resources.dart';
import 'package:tensionpath/domain/entities/size.dart';
import 'package:tensionpath/domain/json/models/start/json_battlefield_start.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Battlefield {
  final Size mapSize;
  final Size nodeSize;
  final Missile missile;
  final IterableMap<String, Resources> resources;
  final IterableMap<String, Launcher> launchers;
  final IterableMap<String, Node> nodes;

  const Battlefield({
    required this.mapSize,
    required this.nodeSize,
    required this.missile,
    required this.resources,
    required this.launchers,
    required this.nodes,
  });

  factory Battlefield.fromJson(JsonBattlefieldStart json) => Battlefield(
    mapSize: Size.fromJson(json.mapSize),
    nodeSize: Size.fromJson(json.nodeSize),
    missile: Missile.fromJson(json.missile),
    resources: Resources.list(json.resources),
    launchers: Launcher.list(json.launchers),
    nodes: Node.list(json.nodes),
  );
}
