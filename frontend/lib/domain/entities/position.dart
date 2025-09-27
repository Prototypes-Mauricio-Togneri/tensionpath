import 'dart:math';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';

class Position {
  final double x;
  final double y;

  const Position({required this.x, required this.y});

  num distanceTo(Position other) {
    final num dx = other.x - x;
    final num dy = other.y - y;

    return sqrt((dx * dx) + (dy * dy));
  }

  Vector2 localPosition({
    required Vector2 mapCenter,
    required num nodeSizeRatio,
  }) => Vector2(x * nodeSizeRatio, y * nodeSizeRatio) + mapCenter;

  factory Position.fromJson(JsonPosition json) => Position(
    x: json.x.toDouble(),
    y: json.y.toDouble(),
  );
}
