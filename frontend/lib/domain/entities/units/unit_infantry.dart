import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/components/units/unit_infantry_component.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class UnitInfantry extends Unit {
  UnitInfantry({
    required super.position,
    required super.player,
    required super.health,
    required super.remainingMoves,
    required super.remainingAttacks,
  }) : super(type: UnitType.infrantry);

  @override
  UnitComponent component({
    required JsonNode node,
    required Vector2 position,
    required Vector2 size,
  }) => UnitInfantryComponent(
    node: node,
    unit: this,
    position: position,
    size: size,
  );
}
