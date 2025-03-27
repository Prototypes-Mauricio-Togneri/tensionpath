import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/nodes/node_launcher_component.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/types/node_type.dart';

class NodeLauncher extends Node {
  NodeLauncher({required super.x, required super.y, required super.player})
    : super(type: NodeType.launcher);

  @override
  NodeComponent<Node> component({
    required Vector2 position,
    required Vector2 size,
  }) => NodeLauncherComponent(node: this, position: position, size: size);
}
