import 'package:flame/game.dart';
import 'package:tensionpath/domain/components/units/unit_melee_component.dart';
import 'package:tensionpath/domain/state/game/units/unit.dart';

class UnitMelee extends Unit {
  int power;

  UnitMelee({
    required super.maxHealth,
    required super.speed,
    required super.range,
    required super.size,
    required this.power,
    required super.owner,
    required super.lane,
    required super.nodes,
    required super.startingPosition,
  });

  @override
  UnitMeleeComponent get component =>
      UnitMeleeComponent(unit: this, size: Vector2(size, size));
}
