import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/state/game/base.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/game/specs/unit_specs.dart';
import 'package:tensionpath/domain/state/game/unit.dart';

class GameState {
  final Player self;
  final Player enemy;
  final Battlefield battlefield;
  late final World world;

  static late GameState instance;

  GameState({
    required this.self,
    required this.enemy,
    required this.battlefield,
  });

  void setWorld(World newWorld) {
    world = newWorld;
  }

  void update(double dt) {
    self.update(dt);
    enemy.update(dt);
  }

  void onSpawnUnit({
    required Lane lane,
    required Player player,
    required Node node,
    required int power,
  }) {
    _deployUnit(
      owner: player,
      power: power,
      nodes: lane.getNodes(
        forward: player.isSelf,
        from: node,
      ),
    );
  }

  void onUnitCollidedWithBase({
    required UnitComponent unit,
    required Base base,
  }) {
    unit.destroy();
    base.onHit(unit.unit.hp);
  }

  void onNodeVictoryCaptured(NodeComponent node) {
    // TODO(momo): implement
  }

  void onAddCredits({
    required Player player,
    required double credits,
  }) {
    player.addCredits(credits);
  }

  void onNodeCreditsGeneratorCaptured({
    required NodeComponent node,
    required Player owner,
  }) {
    const double extra = Constants.CREDITS_EXTRA_RATE;
    owner.addCreditsExtraRate(extra);
  }

  void onNodeCreditsGeneratorLost({
    required NodeComponent node,
    required Player owner,
  }) {
    const double extra = Constants.CREDITS_EXTRA_RATE;
    owner.removeCreditsExtraRate(extra);
  }

  void destroyUnit(UnitComponent unit) {
    world.remove(unit);
  }

  NodeComponent getNodeComponent(NodeComponent node) {
    final Iterable<NodeComponent> unitComponents =
        world.children.query<NodeComponent>();

    for (final NodeComponent component in unitComponents) {
      if (component == node) {
        return component;
      }
    }

    throw Exception('Associated component not found');
  }

  void _deployUnit({
    required Player owner,
    required int power,
    required List<Node> nodes,
  }) {
    final Unit unit = Unit(
      specs: UnitSpecs(
        speed: Constants.UNIT_SPEED,
        power: power,
      ),
      owner: owner,
      nodes: nodes.sublist(1, nodes.length),
      startingPosition: nodes.first.position,
    );

    final UnitComponent unitComponent = UnitComponent(
      unit: unit,
      size: battlefield.nodeSize,
    );
    world.add(unitComponent);
  }
}
