import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/utils/iterable_map.dart';

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

  static IterableMap<String, Location> list(List<JsonLocation> json) {
    final IterableMap<String, Location> result = IterableMap();

    for (final JsonLocation jsonLocation in json) {
      final Location location = Location.fromJson(jsonLocation);
      result.add(location.id, location);
    }

    return result;
  }
}
