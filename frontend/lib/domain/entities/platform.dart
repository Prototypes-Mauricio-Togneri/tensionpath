import 'package:tensionpath/domain/entities/pad.dart';
import 'package:tensionpath/domain/json/models/start/json_platform_start.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Platform {
  final String id;
  final List<Pad> pads;
  String? owner;

  Platform({
    required this.id,
    required this.pads,
  });

  void update(String? newOwner) {
    owner = newOwner;
  }

  factory Platform.fromJson(JsonPlatformStart json) => Platform(
    id: json.id,
    pads: json.pads.map(Pad.fromJson).toList(),
  );

  static IterableMap<String, Platform> list(List<JsonPlatformStart> json) {
    final IterableMap<String, Platform> result = IterableMap();

    for (final JsonPlatformStart jsonPlatform in json) {
      final Platform platform = Platform.fromJson(jsonPlatform);
      result.add(platform.id, platform);
    }

    return result;
  }
}
