import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/state/game/base.dart';
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

    // TODO(momo): add unit to node
    onUnitCreated(unit);*/
  }

  void onUnitCreated(Unit unit) {
    gameComponent.onUnitCreated(unit.component);
  }

  void onUnitCollidedWithBase({required Unit unit, required Base base}) {
    base.onHit(unit.health);
    onUnitDestroyed(unit);
  }

  void onUnitsCollided({required Unit unit1, required Unit unit2}) {
    if (unit1.health > unit2.health) {
      unit1.reduceHealth(unit2.health);
      onUnitDestroyed(unit2);
    } else if (unit1.health < unit2.health) {
      unit2.reduceHealth(unit1.health);
      onUnitDestroyed(unit1);
    } else {
      onUnitDestroyed(unit1);
      onUnitDestroyed(unit2);
    }
  }

  void onUnitDestroyed(Unit unit) {
    unit.destroy();
    gameComponent.onUnitDestroyed(unit);
  }

  void onNodeTouched({required Node node, required Unit unit}) {
    node.onTouched(unit);
  }

  void onBaseDestroyed(Base base) =>
      gameComponent.onMatchFinished(base.owner.isEnemy);

  void onNodeVictoryCaptured(Node node) =>
      gameComponent.onMatchFinished(node.owner!.isSelf);

  void onNodeCreditsGeneratorCaptured({
    required Node node,
    required Player owner,
  }) {
    const double extra = Constants.CREDITS_EXTRA_RATE;
    owner.addCreditsExtraRate(extra);
  }

  void onNodeCreditsGeneratorLost({required Node node, required Player owner}) {
    const double extra = Constants.CREDITS_EXTRA_RATE;
    owner.removeCreditsExtraRate(extra);
  }

  void onAddCredits({required Player player, required double credits}) {
    player.addCredits(credits);
  }
}

mixin GameEngineRef {
  static late GameEngine instance;

  GameEngine get engine => instance;
}
