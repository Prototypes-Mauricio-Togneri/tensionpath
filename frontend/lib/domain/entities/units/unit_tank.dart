import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/components/units/unit_tank_component.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class UnitTank extends Unit {
  UnitTank({
    required super.player,
    required super.maxHealth,
    required super.range,
    required super.attack,
  }) : super(type: UnitType.tank);

  @override
  UnitComponent component({required Vector2 position, required Vector2 size}) =>
      UnitTankComponent(unit: this, position: position, size: size);
}
