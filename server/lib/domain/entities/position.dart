import 'dart:math';
import 'package:tensionpath/domain/json/models/common/json_position.dart';

class Position {
  final num x;
  final num y;

  const Position({required this.x, required this.y});

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
