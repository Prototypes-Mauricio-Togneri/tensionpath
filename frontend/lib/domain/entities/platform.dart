import 'package:tensionpath/domain/entities/pad.dart';
import 'package:tensionpath/domain/json/models/start/json_platform_start.dart';

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

  static List<Platform> list(List<JsonPlatformStart> json) {
    final List<Platform> result = [];

    for (final JsonPlatformStart jsonPlatform in json) {
      final Platform platform = Platform.fromJson(jsonPlatform);
      result.add(platform);
    }

    return result;
  }
}
