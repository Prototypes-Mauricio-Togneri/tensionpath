import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units/unit_artillery_component.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class UnitArtillery extends Unit {
  UnitArtillery({
    required super.player,
    required super.maxHealth,
    required super.range,
    required super.attack,
  }) : super(type: UnitType.artillery);

  @override
  UnitComponent component({required Vector2 position, required Vector2 size}) =>
      UnitArtilleryComponent(unit: this, position: position, size: size);
}
