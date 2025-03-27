import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/components/units/unit_helicopter.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';

class UnitHelicopter extends Unit {
  UnitHelicopter({
    required super.player,
    required super.type,
    required super.maxHealth,
    required super.range,
    required super.attack,
  });

  @override
  UnitComponent component({required Vector2 position, required Vector2 size}) =>
      UnitHelicopterComponent(unit: this, position: position, size: size);
}
