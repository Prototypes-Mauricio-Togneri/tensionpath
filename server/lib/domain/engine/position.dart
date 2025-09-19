import 'package:tensionpath/domain/json/models/common/json_position.dart';

class Position {
  final double x;
  final double y;

  const Position({required this.x, required this.y});

  JsonPosition toJson() => JsonPosition(x: x, y: y);
}
