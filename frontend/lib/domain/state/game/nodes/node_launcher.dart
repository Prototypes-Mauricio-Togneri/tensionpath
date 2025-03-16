import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';

class NodeLauncher extends Node {
  final Player player;

  NodeLauncher({
    required super.x,
    required super.y,
    required super.nodeSize,
    required this.player,
  }) : super(captureRate: 0);

  @override
  NodeComponent get component =>
      NodeComponent(node: this, position: position, size: size);
}
