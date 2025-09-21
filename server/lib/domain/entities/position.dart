import 'dart:math';
import 'package:tensionpath/domain/json/models/common/json_position.dart';

class Position {
  num x;
  num y;

  Position({required this.x, required this.y});

  void moveTowards({
    required Position target,
    required num distance,
  }) {
    final num remainingDistance = distanceTo(target);

    if (distance < remainingDistance) {
      x += (target.x - x) * distance / remainingDistance;
      y += (target.y - y) * distance / remainingDistance;
    } else {
      x = target.x;
      y = target.y;
    }
  }

  num distanceTo(Position other) {
    final num dx = other.x - x;
    final num dy = other.y - y;

    return sqrt((dx * dx) + (dy * dy));
  }

  factory Position.fromJson(JsonPosition json) => Position(
    x: json.x,
    y: json.y,
  );

  JsonPosition toJson() => JsonPosition(x: x, y: y);

  @override
  String toString() => '($x, $y)';
}
