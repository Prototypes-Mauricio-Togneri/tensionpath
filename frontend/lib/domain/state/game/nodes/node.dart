import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/state/game/accumulator.dart';
import 'package:tensionpath/domain/state/game/game_engine.dart';
import 'package:tensionpath/domain/state/game/ownership.dart';

abstract class Node extends Ownership with Accumulator, GameEngineRef {
  final int x;
  final int y;
  final double nodeSize;

  Node({
    required this.x,
    required this.y,
    required super.captureRate,
    required this.nodeSize,
  });

  NodeComponent get component;

  String get id => '[$x,$y]';

  Vector2 get position => Vector2(nodeSize * x, nodeSize * y);

  Vector2 get size => Vector2(nodeSize, nodeSize);

  void onTapped() {}
}
