import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/start/json_launcher_start.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Launcher {
  final String playerIndex;
  final Location location;
  final Position position;

  const Launcher({
    required this.playerIndex,
    required this.location,
    required this.position,
  });

  factory Launcher.fromJson(JsonLauncherStart json) => Launcher(
    playerIndex: json.playerIndex,
    location: Location.fromJson(json.location),
    position: Position.fromJson(json.position),
  );

  static IterableMap<String, Launcher> list(List<JsonLauncherStart> json) {
    final IterableMap<String, Launcher> result = IterableMap();

    for (final JsonLauncherStart jsonLaunchers in json) {
      final Launcher launchers = Launcher.fromJson(jsonLaunchers);
      result.add(launchers.playerIndex, launchers);
    }

    return result;
  }

  JsonLauncherStart toJsonStart() => JsonLauncherStart(
    playerIndex: playerIndex,
    location: location.toJson(),
    position: position.toJson(),
  );
}
