import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';
import 'package:tensionpath/domain/state/game/units/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class GameEngine {
  final GameComponent gameComponent;
  final Player self;
  final Player enemy;
  final Battlefield battlefield;

  GameEngine({
    required this.gameComponent,
    required this.self,
    required this.enemy,
    required this.battlefield,
  }) {
    GameEngineRef.instance = this;
  }

  void update(double dt) {
    self.update(dt);
    enemy.update(dt);
    battlefield.update(dt);
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

  void onUnitCreated(Unit unit) {
    gameComponent.onUnitCreated(unit.component);
  }

  void onUnitDestroyed(Unit unit) {
    unit.destroy();
    gameComponent.onUnitDestroyed(unit);
  }

  void onNodeVictoryCaptured(Node node) =>
      gameComponent.onMatchFinished(node.owner!.isSelf);
}

mixin GameEngineRef {
  static late GameEngine instance;

  GameEngine get engine => instance;
}
