import 'package:tensionpath/domain/data/buildings.dart';
import 'package:tensionpath/domain/data/nodes.dart';
import 'package:tensionpath/domain/data/players.dart';
import 'package:tensionpath/domain/data/resources.dart';
import 'package:tensionpath/domain/data/units.dart';
import 'package:tensionpath/domain/entities/building.dart';
import 'package:tensionpath/domain/entities/config.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/missile.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/resource.dart';
import 'package:tensionpath/domain/entities/size.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_event.dart';
import 'package:tensionpath/domain/json/models/start/json_battlefield_start.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/constants.dart';

class Battlefield {
  final Config config;
  final Size mapSize;
  final Size nodeSize;
  final Missile missile;
  final Resources resources;
  final Buildings buildings;
  final Players players;
  final Units units;
  final Nodes nodes;

  const Battlefield({
    required this.config,
    required this.mapSize,
    required this.nodeSize,
    required this.missile,
    required this.resources,
    required this.buildings,
    required this.players,
    required this.units,
    required this.nodes,
  });

  (List<JsonEvent>, bool) update(double dt) {
    final List<JsonEvent> events = [];
    bool updatePlayers = false;

    for (final Unit unit in units.list) {
      if (unit.isAlive) {
        final (List<JsonEvent>, bool) unitUpdate = unit.update(dt);
        events.addAll(unitUpdate.$1);
        updatePlayers |= unitUpdate.$2;
      }
    }

    events.addAll(missile.update(dt));

    updatePlayers |= units.removeDestroyed();

    return (events, updatePlayers);
  }

  JsonEvent deployUnit({
    required Player player,
    required Location location,
    required UnitType type,
  }) {
    final Building? building = buildings.ofPlayer(
      player: player,
      type: type.buildingType,
    );
    final Node originNode = nodes.get(building!.id);
    final Node targetNode = nodes.atLocation(location);

    final Unit unit = Unit(
      config: config,
      nodes: nodes,
      resources: resources,
      buildings: buildings,
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

    return JsonEvent.unitCreated(
      unitId: unit.id,
      playerIndex: player.index,
      unitType: type,
      health: unit.health,
      position: unit.position.toJson(),
      targetPosition: unit.targetNode?.position.toJson(),
      lockedLocation: unit.lockedNode?.location.toJson(),
      targetBase: unit.targetBase?.location.toJson(),
      targetUnitId: unit.targetUnit?.id,
    );
  }

  List<JsonEvent> unitAction({
    required Player player,
    required String unitId,
    required Location? targetLocation,
    required String? targetUnitId,
  }) {
    final List<JsonEvent> result = [];

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

      if (targetNode.type == NodeType.building) {
        final Building targetBase = buildings.get(targetNode.id);
        final num distanceToTarget = attackerUnit.distanceToBase(targetBase);

        if (!attackerUnit.isInAttackRange(distanceToTarget)) {
          final Node? alternativeNode = nodes.closestNodeToMove(
            position: targetNode.position,
            unit: attackerUnit,
          );

          if (alternativeNode != null) {
            result.add(
              attackerUnit.move(
                node: alternativeNode,
                manual: true,
              ),
            );
          }
        }

        attackerUnit.attackBase(targetBase);
      } else {
        result.add(
          attackerUnit.move(
            node: targetNode,
            manual: true,
          ),
        );
      }
    } else if (defenderUnit.isAlive) {
      final num distanceToTarget = attackerUnit.distanceToUnit(defenderUnit);

      if (!attackerUnit.isInAttackRange(distanceToTarget)) {
        final Node targetNode =
            defenderUnit.lockedNode ?? defenderUnit.closestNode;
        final Node? alternativeNode = nodes.closestNodeToMove(
          position: targetNode.position,
          unit: attackerUnit,
        );

        if (alternativeNode != null) {
          result.add(
            attackerUnit.move(
              node: alternativeNode,
              manual: true,
            ),
          );
        }
      }

      attackerUnit.attackUnit(defenderUnit);
    }

    return result;
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
        players: players,
      ),
      resources: Resources(
        Resource.list(
          json: json.resources,
          nodes: nodes,
        ),
      ),
      buildings: Buildings(
        Building.list(
          json: json.buildings,
          players: players,
          radius: nodeSize.radius,
        ),
      ),
      players: players,
      units: units,
      nodes: nodes,
    );
  }

  JsonBattlefieldStart toJson() => JsonBattlefieldStart(
    mapSize: mapSize.toJson(),
    nodeSize: Constants.NODE_SIZE.toJson(),
    missile: missile.toJson(),
    resources: resources.list.map((r) => r.toJson()).toList(),
    buildings: buildings.list.map((l) => l.toJson()).toList(),
    nodes: nodes.list.map((n) => n.toJson()).toList(),
  );
}
