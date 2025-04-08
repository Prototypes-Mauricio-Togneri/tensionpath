import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units/unit_artillery_component.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class UnitArtillery extends Unit {
  UnitArtillery({
    required super.cost,
    required super.maxHealth,
    required super.shootingRange,
    required super.movementRange,
    required super.visibilityRange,
    required super.attack,
    required super.player,
  }) : super(type: UnitType.artillery);

  @override
  UnitComponent component({
    required Node node,
    required Vector2 position,
    required Vector2 size,
  }) => UnitArtilleryComponent(
    node: node,
    unit: this,
    position: position,
    size: size,
  );
}
