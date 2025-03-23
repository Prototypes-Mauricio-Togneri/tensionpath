import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';

abstract class Node with GameComponentRef {
  final int x;
  final int y;

  Node({required this.x, required this.y});

  NodeComponent component({required Vector2 position, required Vector2 size});

  String get id => '[$x,$y]';

  Vector2 battlefieldPosition(double nodeSize) {
    final double hexWidth = nodeSize;
    final double hexHeight = nodeSize * (sqrt(3) / 2);

    return Vector2(hexWidth * 3 / 4 * x, hexHeight * ((x / 2) + y));
  }

  void onTapped() {}

  @mustCallSuper
  void update(double dt) {}
}
