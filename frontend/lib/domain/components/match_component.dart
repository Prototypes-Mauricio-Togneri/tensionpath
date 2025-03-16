import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';
import 'package:tensionpath/domain/state/game/units/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class MatchComponent extends World {
  final Player self;
  final Battlefield battlefield;

  MatchComponent({required this.self, required this.battlefield});

  @override
  FutureOr onLoad() {
    add(BattlefieldComponent(battlefield));
    add(ControlsComponent(self));

    return super.onLoad();
  }

  Iterable<UnitComponent> get unitComponents =>
      children.whereType<UnitComponent>();

  void onUnitCreated(Unit unit) {
    add(unit.component);
  }

  void onUnitDestroyed(Unit unit) {
    unit.destroy();

    for (final UnitComponent unitComponent in unitComponents) {
      if (unitComponent.unit == unit) {
        remove(unitComponent);
        break;
      }
    }
  }

  void onSpawnUnit({
    required Player player,
    required Node node,
    required UnitType unitType,
  }) {
    /*final double extraGap =
        -player.ownershipDirection * (battlefield.nodeSize / 2);
    final Vector2 startingPosition = Vector2.copy(nodes.first.position);
    startingPosition.add(Vector2(0, extraGap));

    final Unit unit = Unit.fromType(
      unitType: unitType,
      owner: player,
      lane: lane,
      nodes: nodes.sublist(1, nodes.length),
      startingPosition: startingPosition,
      nodeSize: battlefield.nodeSize,
    );

    onUnitCreated(unit);*/
  }
}
