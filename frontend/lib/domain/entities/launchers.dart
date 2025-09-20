import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/start/json_launcher_start.dart';

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

  static List<Launcher> list(List<JsonLauncherStart> json) {
    final List<Launcher> result = [];

    for (final JsonLauncherStart jsonLaunchers in json) {
      final Launcher launcher = Launcher.fromJson(jsonLaunchers);
      result.add(launcher);
    }

    return result;
  }
}
