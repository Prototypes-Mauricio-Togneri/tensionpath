import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/components/units/unit_harvester_component.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class UnitHarvester extends Unit {
  UnitHarvester({
    required super.location,
    required super.player,
    required super.health,
    required super.remainingMoves,
    required super.remainingAttacks,
  }) : super(type: UnitType.harvester);

  @override
  UnitComponent component({
    required Node node,
    required Vector2 position,
    required Vector2 size,
  }) => UnitHarvesterComponent(
    node: node,
    unit: this,
    position: position,
    size: size,
  );
}
