import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/game/node_component.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/types/node_type.dart';

class Node {
  final String id;
  final Vector2 position;
  final NodeType type;
  late World world;
  Player? _owner;
  double _commandPointsAccumulated = 0;

  Node({
    required this.id,
    required this.position,
    required this.type,
  });

  Player? get owner => _owner;

  double get commandPointsAccumulated =>
      _commandPointsAccumulated.floorToDouble();

  NodeComponent get component {
    final List<NodeComponent> unitComponents =
        world.children.query<NodeComponent>();

    for (final NodeComponent component in unitComponents) {
      if (component.node == this) {
        return component;
      }
    }

    throw Exception('Associated component not found');
  }

  void setWorld(World newWorld) {
    world = newWorld;
  }

  void setOwner(Player player) {
    _owner = player;
  }

  void update(double dt) {
    _commandPointsAccumulated += Constants.NODE_COMMAND_POINTS_RATIO * dt;

    if ((type == NodeType.unit_generator) && (_commandPointsAccumulated >= 1)) {
      _commandPointsAccumulated -= 1;
      // TODO(momo): launch unit
    }
  }
}
