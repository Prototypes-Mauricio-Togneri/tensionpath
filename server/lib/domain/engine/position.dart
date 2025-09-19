import 'package:tensionpath/domain/json/models/common/json_position.dart';

class Position {
  final num x;
  final num y;

  const Position({required this.x, required this.y});

  factory Position.fromJson(JsonPosition json) => Position(
    x: json.x,
    y: json.y,
  );

  JsonPosition toJson() => JsonPosition(x: x, y: y);
}
