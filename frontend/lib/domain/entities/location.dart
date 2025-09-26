import 'package:tensionpath/domain/json/models/common/json_location.dart';

class Location {
  final int x;
  final int y;

  const Location({required this.x, required this.y});

  String get id => '$x,$y';

  int distanceTo(Location other) {
    final num distance =
        ((x - other.x).abs() +
            (x + y - other.x - other.y).abs() +
            (y - other.y).abs()) /
        2;

    return distance.toInt();
  }

  factory Location.fromJson(JsonLocation json) => Location(
    x: json.x,
    y: json.y,
  );

  JsonLocation toJson() => JsonLocation(x: x, y: y);
}
