import 'package:flame/components.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';

class Position {
  final double x;
  final double y;

  const Position({required this.x, required this.y});

  Vector2 localPosition({
    required Vector2 mapCenter,
    required num nodeSizeRatio,
  }) => Vector2(x * nodeSizeRatio, y * nodeSizeRatio) + mapCenter;

  factory Position.fromJson(JsonPosition json) => Position(
    x: json.x.toDouble(),
    y: json.y.toDouble(),
  );
}
