import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/game/nodes/node_base_component.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/game/unit.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';

class GameState {
  final Player self;
  final Player enemy;
  final Battlefield battlefield;
  late final World world;
  int creditsSelected = 0;

  GameState({
    required this.self,
    required this.enemy,
    required this.battlefield,
  }) {
    battlefield.nodes.forEach((node) => node.setGameState(this));
  }

  void setWorld(World newWorld) {
    world = newWorld;
  }

  void update(double dt) {
    self.update(dt);
    enemy.update(dt);
  }

  void onCreditsSelected(int amount) {
    creditsSelected = amount;
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
    required Unit unit,
    required Player baseOwner,
  }) {
    unit.destroy();
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
    required Player? previousOwner,
    required Player newOwner,
  }) {
    const double extra = Constants.CREDITS_EXTRA_RATE;
    newOwner.addCreditsExtraRate(extra);
    previousOwner?.removeCreditsExtraRate(extra);
  }

  void destroyUnit(Unit unit) {
    final UnitComponent component = getUnitComponent(unit);
    world.remove(component);
  }

  UnitComponent getUnitComponent(Unit unit) {
    final List<UnitComponent> unitComponents =
        world.children.query<UnitComponent>();

    for (final UnitComponent component in unitComponents) {
      if (component.unit == unit) {
        return component;
      }
    }

    throw Exception('Associated component not found');
  }

  NodeBaseComponent getNodeComponent(Node node) {
    final List<NodeBaseComponent> unitComponents =
        world.children.query<NodeBaseComponent>();

    for (final NodeBaseComponent component in unitComponents) {
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
    final Unit unit = Unit.create(
      state: this,
      owner: owner,
      power: power,
      waypoints: waypoints,
    );
    world.add(UnitComponent(
      unit: unit,
      size: battlefield.nodeSize,
    ));
  }
}
