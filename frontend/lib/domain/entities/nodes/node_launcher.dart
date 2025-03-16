import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/nodes/node_launcher_component.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';

class NodeLauncher extends Node {
  final Player player;

  NodeLauncher({
    required super.x,
    required super.y,
    required super.nodeSize,
    required this.player,
  });

  @override
  NodeComponent get component =>
      NodeLauncherComponent(node: this, position: position, size: size);
}
