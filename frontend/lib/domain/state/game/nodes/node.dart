import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';

abstract class Node with GameComponentRef {
  final int x;
  final int y;
  final double nodeSize;

  Node({required this.x, required this.y, required this.nodeSize});

  NodeComponent get component;

  String get id => '[$x,$y]';

  Vector2 get position =>
      Vector2((nodeSize * x) + (nodeSize / 2), (nodeSize * y) + (nodeSize / 2));

  Vector2 get size => Vector2(nodeSize, nodeSize);

  void onTapped() {}

  @mustCallSuper
  void update(double dt) {}
}
