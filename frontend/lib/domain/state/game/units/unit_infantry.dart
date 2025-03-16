import 'package:flame/game.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/components/units/unit_infantry_component.dart';
import 'package:tensionpath/domain/state/game/units/unit.dart';

class UnitInfantry extends Unit {
  UnitInfantry({
    required super.maxHealth,
    required super.range,
    required super.size,
    required super.attack,
    required super.owner,
    required super.startingPosition,
  });

  @override
  UnitComponent get component =>
      UnitInfrantryComponent(unit: this, size: Vector2(size, size));
}
