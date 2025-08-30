import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/components/units/unit_vehicle_component.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class UnitVehicle extends Unit {
  UnitVehicle({
    required super.position,
    required super.player,
    required super.health,
    required super.remainingMoves,
    required super.remainingAttacks,
  }) : super(type: UnitType.vehicle);

  @override
  UnitComponent component({
    required JsonNode node,
    required Vector2 position,
    required Vector2 size,
  }) => UnitVehicleComponent(
    node: node,
    unit: this,
    position: position,
    size: size,
  );
}
