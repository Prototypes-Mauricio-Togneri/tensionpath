import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/controls_component.dart';
import 'package:tensionpath/domain/components/header_component.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class MatchComponent extends World {
  final Size resolution;
  final Player self;
  final Player enemy;
  final Battlefield battlefield;

  MatchComponent({
    required this.resolution,
    required this.self,
    required this.enemy,
    required this.battlefield,
  });

  @override
  FutureOr onLoad() {
    add(
      BattlefieldComponent(
        battlefield: battlefield,
        position: Vector2(
          -Constants.UI_WIDTH / 2,
          (-resolution.height / 2) + Constants.UI_HEADER_HEIGHT,
        ),
        size: Vector2(
          Constants.UI_WIDTH,
          resolution.height -
              Constants.UI_HEADER_HEIGHT -
              Constants.UI_CONTROLS_HEIGHT,
        ),
      ),
    );
    add(
      HeaderComponent(
        player1: self,
        player2: enemy,
        position: Vector2(-Constants.UI_WIDTH / 2, -resolution.height / 2),
        size: Vector2(Constants.UI_WIDTH, Constants.UI_HEADER_HEIGHT),
      ),
    );
    add(
      ControlsComponent(
        player: self,
        position: Vector2(
          -Constants.UI_WIDTH / 2,
          (resolution.height / 2) - Constants.UI_CONTROLS_HEIGHT,
        ),
        size: Vector2(Constants.UI_WIDTH, Constants.UI_CONTROLS_HEIGHT),
      ),
    );

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
