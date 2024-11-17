import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/state/game/base.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';
import 'package:tensionpath/domain/state/game/units/unit.dart';

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
    required Lane lane,
    required Player player,
    required Node node,
    required int power,
  }) {
    final List<Node> nodes = lane.getNodes(
      forward: player.isSelf,
      from: node,
    );

    final Unit unit = Unit(
      hp: power,
      speed: Constants.UNIT_SPEED,
      owner: player,
      lane: lane,
      nodes: nodes.sublist(1, nodes.length),
      startingPosition: nodes.first.position,
    );

    lane.addUnit(unit);

    final UnitComponent unitComponent = unit.component(battlefield.maxUnitSize);
    gameComponent.world.add(unitComponent);
  }

  void onUnitCollidedWithBase({
    required UnitComponent unit,
    required Base base,
  }) {
    base.onHit(unit.unit.hp);
    onDestroyUnit(unit);
  }

  void onDestroyUnit(UnitComponent unit) {
    unit.unit.destroy();
    gameComponent.world.remove(unit);
  }

  void onNodeTouched({
    required Node node,
    required Unit unit,
  }) {
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

  void onNodeCreditsGeneratorLost({
    required Node node,
    required Player owner,
  }) {
    const double extra = Constants.CREDITS_EXTRA_RATE;
    owner.removeCreditsExtraRate(extra);
  }

  void onAddCredits({
    required Player player,
    required double credits,
  }) {
    player.addCredits(credits);
  }
}

mixin GameEngineRef {
  static late GameEngine instance;

  GameEngine get engine => instance;
}
