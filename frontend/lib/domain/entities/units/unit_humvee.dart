import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/components/units/unit_humvee_component.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class UnitHumvee extends Unit {
  UnitHumvee({
    required super.cost,
    required super.health,
    required super.maxHealth,
    required super.shootingRange,
    required super.movementRange,
    required super.visibilityRange,
    required super.attack,
    required super.moves,
    required super.player,
  }) : super(type: UnitType.humvee);

  @override
  UnitComponent component({
    required Node node,
    required Vector2 position,
    required Vector2 size,
  }) => UnitHumveeComponent(
    node: node,
    unit: this,
    position: position,
    size: size,
  );
}
