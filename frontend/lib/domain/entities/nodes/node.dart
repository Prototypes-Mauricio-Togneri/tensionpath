import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/node_type.dart';

abstract class Node {
  final NodeType type;
  final int x;
  final int y;
  Unit? unit;
  Player? player;

  Node({required this.type, required this.x, required this.y, this.player});

  NodeComponent component({required Vector2 position, required Vector2 size});

  String get id => '[$x,$y]';

  Color? get playerColor => player?.color;

  bool get canDeployUnit => unit == null;

  void deployUnit(Unit unit) {
    this.unit = unit;
    player = unit.player;
  }

  int distance(Node node) {
    final double distance =
        ((x - node.x).abs() +
            (x + y - node.x - node.y).abs() +
            (y - node.y).abs()) /
        2;

    return distance.toInt();
  }

  Vector2 position(double nodeSize) {
    final double hexWidth = nodeSize;
    final double hexHeight = nodeSize * (sqrt(3) / 2);

    return Vector2(hexWidth * 3 / 4 * x, hexHeight * ((x / 2) + y));
  }
}
