import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/game/node_component.dart';
import 'package:tensionpath/domain/game/unit_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/game/unit.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';

class GameState {
  final Player self;
  final Player enemy;
  final Battlefield battlefield;
  late final World world;
  int commandPointsSelected = 0;

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

    battlefield.nodes.forEach((node) => node.update(dt));
  }

  void onCommandPointsSelected(int amount) {
    commandPointsSelected = amount;
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

  void onNodeChestAcquired({
    required Node node,
    required Player player,
  }) {
    player.addCommandPoints(node.commandPointsAccumulated);
    node.resetCommandPointsAccumulated();
  }

  void onNodeCommandPointsGeneratorCaptured({
    required Node node,
    required Player? previousOwner,
    required Player newOwner,
  }) {
    const double extra = Constants.COMMAND_POINTS_EXTRA_RATIO;
    newOwner.addCommandPointsExtraRatio(extra);
    previousOwner?.removeCommandPointsExtraRatio(extra);
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
    final Unit unit = Unit.create(
      state: this,
      owner: owner,
      power: power,
      waypoints: waypoints,
    );
    world.add(UnitComponent(
      state: this,
      unit: unit,
      size: battlefield.nodeSize,
    ));
  }
}
