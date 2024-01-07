import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/game/specs/unit_specs.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';

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

  void onNodeSpawnUnit({
    required Node node,
    required int power,
  }) {
    final Lane lane = battlefield.laneOf(node);

    _deployUnit(
      owner: node.owner!,
      power: power,
      waypoints: lane.getWaypointsFrom(
        node: node,
        forward: node.owner!.isSelf,
      ),
    );
  }

  void onUnitCollidedWithBase({
    required UnitComponent unit,
    required Player baseOwner,
  }) {
    unit.destroy();
    baseOwner.reduceHp(unit.power);
  }

  void onNodeVictoryCaptured(Node node) {
    // TODO(momo): implement
  }

  void onAddCredits({
    required Player player,
    required double credits,
  }) {
    player.addCredits(credits);
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

  void destroyUnit(UnitComponent unit) {
    world.remove(unit);
  }

  NodeComponent getNodeComponent(Node node) {
    final List<NodeComponent> unitComponents =
        world.children.query<NodeComponent>();

    for (final NodeComponent component in unitComponents) {
      if (component.node == node) {
        return component;
      }
    }

    throw Exception('Associated component not found');
  }

  void _deployUnit({
    required Player owner,
    required int power,
    required List<Waypoint> waypoints,
  }) {
    final UnitComponent unit = UnitComponent(
      specs: UnitSpecs(
        speed: Constants.UNIT_SPEED,
        power: power,
        sprite: owner.unitSprite,
      ),
      owner: owner,
      waypoints: waypoints.sublist(1, waypoints.length),
      startingPosition: waypoints.first.position,
      size: battlefield.nodeSize,
    );
    world.add(unit);
  }
}
