import 'package:tensionpath/domain/types/unit_type.dart';

class Unit {
  final String id;
  final UnitType type;
  int health;

  Unit({
    required this.id,
    required this.type,
    required this.health,
  });
}
