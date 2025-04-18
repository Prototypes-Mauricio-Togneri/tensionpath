import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/components/units/unit_sniper_component.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class UnitSniper extends Unit {
  UnitSniper({
    required super.location,
    required super.player,
    required super.health,
    required super.moves,
  }) : super(type: UnitType.sniper);

  @override
  UnitComponent component({
    required Node node,
    required Vector2 position,
    required Vector2 size,
  }) => UnitSniperComponent(
    node: node,
    unit: this,
    position: position,
    size: size,
  );
}
