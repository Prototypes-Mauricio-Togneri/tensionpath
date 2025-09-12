import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class Unit {
  final String id;
  final String playerIndex;
  final UnitType type;
  double health;

  Unit({
    required this.id,
    required this.playerIndex,
    required this.type,
    required this.health,
  });

  JsonUnitUpdate toJsonUpdate() => JsonUnitUpdate(
    id: id,
    location: const JsonLocation(x: 0, y: 0),
    position: const JsonPosition(x: 0, y: 0),
    health: health,
  );
}
