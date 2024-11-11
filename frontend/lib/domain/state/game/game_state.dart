import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/state/game/base.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';
import 'package:tensionpath/domain/state/game/specs/unit_specs.dart';
import 'package:tensionpath/domain/state/game/unit.dart';
import 'package:tensionpath/presentation/dialogs/info_dialog.dart';

class GameState {
  final Player self;
  final Player enemy;
  final Battlefield battlefield;
  GameComponent? _gameComponent;

  static late GameState instance;

  GameState({
    required this.self,
    required this.enemy,
    required this.battlefield,
  });

  GameComponent get gameComponent => _gameComponent!;

  void setGameComponent(GameComponent newGameComponent) {
    _gameComponent ??= newGameComponent;
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
      specs: UnitSpecs(
        speed: Constants.UNIT_SPEED,
        power: power,
      ),
      owner: player,
      lane: lane,
      nodes: nodes.sublist(1, nodes.length),
      startingPosition: nodes.first.position,
    );

    lane.addUnit(unit);

    final UnitComponent unitComponent = unit.component(battlefield.laneSize);
    addComponent(unitComponent);
  }

  void onUnitCollidedWithBase({
    required UnitComponent unit,
    required Base base,
  }) {
    unit.destroy();
    base.onHit(unit.unit.hp);
  }

  void onBaseDestroyed(Base base) => _gameFinished(base.player.isEnemy);

  void onNodeVictoryCaptured(Node node) => _gameFinished(node.owner!.isSelf);

  void _gameFinished(bool won) {
    gameComponent.pauseEngine();

    if (won) {
      InfoDialog.won(() {});
    } else {
      InfoDialog.lost(() {});
    }
  }

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

  void addComponent(Component component) => gameComponent.world.add(component);

  void removeComponent(Component unit) => gameComponent.world.remove(unit);
}
