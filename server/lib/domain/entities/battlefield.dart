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
import 'package:tensionpath/utils/iterable_map.dart';

class Battlefield {
  final Size mapSize;
  final Missile missile;
  final IterableMap<String, Resources> resources;
  final IterableMap<String, Launchers> launchers;
  final IterableMap<String, Node> nodes;
  final IterableMap<String, Unit> units;

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
    final Node closestNode = getClosestNode(location);

    final Unit unit = Unit(
      id: DateTime.now().toIso8601String(),
      player: player,
      type: type,
      closestNode: closestNode,
      position: closestNode.position,
      health: type.maxHealth.toDouble(),
    );
    units.add(unit.id, unit);
  }

  Node getClosestNode(Location location) {
    Node? closestNode;
    num closestDistance = double.infinity;

    for (final Node node in nodes.list) {
      final num distance = location.distanceTo(node.location);

      if (distance < closestDistance) {
        closestDistance = distance;
        closestNode = node;
      }
    }

    if (closestNode == null) {
      throw Exception('No closest node to location ${location.id} found');
    }

    return closestNode;
  }

  factory Battlefield.fromJson(JsonBattlefield json) {
    final IterableMap<String, Node> nodes = Node.list(json.nodes);

    return Battlefield(
      mapSize: Size.fromJson(json.mapSize),
      missile: Missile.fromJson(json.missile),
      resources: Resources.list(
        json: json.resources,
        nodes: nodes,
      ),
      launchers: Launchers.list(json.launchers),
      nodes: nodes,
      units: IterableMap(),
    );
  }

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
