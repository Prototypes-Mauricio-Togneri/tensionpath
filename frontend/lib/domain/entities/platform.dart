import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/json/models/start/json_platform.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Platform {
  final String id;
  final List<Location> pads;
  String? owner;

  Platform({
    required this.id,
    required this.pads,
  });

  void update(String? newOwner) {
    owner = newOwner;
  }

  factory Platform.fromJson(JsonPlatform json) => Platform(
    id: json.id,
    pads: json.pads.map(Location.fromJson).toList(),
  );

  static IterableMap<String, Platform> list(List<JsonPlatform> json) {
    final IterableMap<String, Platform> result = IterableMap();

    for (final JsonPlatform jsonPlatform in json) {
      final Platform platform = Platform.fromJson(jsonPlatform);
      result.add(platform.id, platform);
    }

    return result;
  }
}
