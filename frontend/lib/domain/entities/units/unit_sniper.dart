import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/components/units/unit_sniper_component.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';

class UnitSniper extends Unit {
  UnitSniper({
    required super.player,
    required super.maxHealth,
    required super.range,
    required super.attack,
  });

  @override
  UnitComponent component({required Vector2 position, required Vector2 size}) =>
      UnitSniperComponent(unit: this, position: position, size: size);
}
