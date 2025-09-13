import 'package:tensionpath/domain/engine/location.dart';
import 'package:tensionpath/domain/json/models/start/json_platform.dart';
import 'package:tensionpath/utils/map_list.dart';

class Platform {
  final String id;
  final Location location;

  const Platform({
    required this.id,
    required this.location,
  });

  factory Platform.fromJson(JsonPlatform json) => Platform(
    id: json.id,
    location: Location.fromJson(json.location),
  );

  static MapList<String, Platform> list(List<JsonPlatform> json) {
    final MapList<String, Platform> result = MapList();

    for (final JsonPlatform jsonPlatform in json) {
      final Platform platform = Platform.fromJson(jsonPlatform);
      result.add(platform.id, platform);
    }

    return result;
  }
}
