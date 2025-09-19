import 'package:tensionpath/domain/engine/location.dart';
import 'package:tensionpath/domain/engine/player.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class Unit {
  final String id;
  final Player player;
  final UnitType type;
  final Location location;
  double health;

  Unit({
    required this.id,
    required this.player,
    required this.type,
    required this.location,
    required this.health,
  });

  bool update(double dt) {
    /*
      - If moving
        - If target node is free
          - Update position
          - If unit inside of target node -> assign node to unit
        - If target node is not free
          - Re-assign node
          - Update position
          - If unit inside of target node -> assign node to unit
    */

    return false;
  }

  JsonUnitUpdate toJsonUpdate() => JsonUnitUpdate(
    id: id,
    playerIndex: player.index,
    type: type,
    location: location.toJson(),
    position: const JsonPosition(x: 0, y: 0),
    health: health,
  );
}
