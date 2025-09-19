import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/json/models/start/json_platform.dart';

class Platform {
  final String id;
  final List<Location> pads;
  String? owner;

  Platform({
    required this.id,
    required this.pads,
  });

  factory Platform.fromJson(JsonPlatform json) => Platform(
    id: json.id,
    pads: json.pads.map(Location.fromJson).toList(),
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
