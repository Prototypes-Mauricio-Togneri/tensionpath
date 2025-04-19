import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/components/units/unit_rifle_squad_component.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class UnitRifleSquad extends Unit {
  UnitRifleSquad({
    required super.location,
    required super.player,
    required super.health,
    required super.remainingMoves,
  }) : super(type: UnitType.rifle_squad);

  @override
  UnitComponent component({
    required Node node,
    required Vector2 position,
    required Vector2 size,
  }) => UnitRifleSquadComponent(
    node: node,
    unit: this,
    position: position,
    size: size,
  );
}
