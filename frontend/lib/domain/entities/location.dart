import 'package:tensionpath/domain/json/models/common/json_location.dart';

class Location {
  final int x;
  final int y;

  const Location({required this.x, required this.y});

  String get id => '$x,$y';

  factory Location.fromJson(JsonLocation json) => Location(
    x: json.x,
    y: json.y,
  );

  JsonLocation toJson() => JsonLocation(x: x, y: y);
}
