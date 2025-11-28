import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/json/models/start/json_node_start.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class Node {
  final String id;
  final NodeType type;
  final Location location;
  final Position position;
  final List<Node> neighbors = [];
  final String? spawnPointForPlayer;
  Unit? lockedUnit;

  Node({
    required this.id,
    required this.type,
    required this.location,
    required this.position,
    required this.spawnPointForPlayer,
  });

  bool get isFree => lockedUnit == null;

  bool get isLocked => lockedUnit != null;

  bool lockedByPlayer(Player player) =>
      isLocked && (lockedUnit!.player == player);

  bool notLockedByPlayer(Player player) =>
      isLocked && (lockedUnit!.player != player);

  bool canMove(UnitType unitType) => isFree && type.canMove(unitType);

  void lock(Unit unit) {
    lockedUnit = unit;
  }

  void unlock() {
    lockedUnit = null;
  }

  num movementCost(Unit unit) {
    final UnitClass unitClass = unit.type.clazz;

    if (notLockedByPlayer(unit.player)) {
      if (unitClass.canGoOver(lockedUnit!.type.clazz)) {
        return unitClass.movingCost(type);
      } else {
        return double.infinity;
      }
    } else {
      return unitClass.movingCost(type);
    }
  }

  JsonNodeStart toJson() => JsonNodeStart(
    location: location.toJson(),
    position: position.toJson(),
    type: type,
    playerIndex: null,
    platformId: null,
    building: null,
    spawnPoint: null,
  );

  @override
  bool operator ==(Object other) => other is Node && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
