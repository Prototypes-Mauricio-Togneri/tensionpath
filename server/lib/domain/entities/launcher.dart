import 'package:tensionpath/domain/data/players.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/start/json_launcher_start.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Launcher {
  final Player player;
  final Location location;
  final Position position;
  final num radius;

  const Launcher({
    required this.player,
    required this.location,
    required this.position,
    required this.radius,
  });

  String get id => location.id;

  factory Launcher.fromJson({
    required JsonLauncherStart json,
    required Player player,
    required num radius,
  }) => Launcher(
    player: player,
    location: Location.fromJson(json.location),
    position: Position.fromJson(json.position),
    radius: radius,
  );

  static IterableMap<String, Launcher> list({
    required List<JsonLauncherStart> json,
    required Players players,
    required num radius,
  }) {
    final IterableMap<String, Launcher> result = IterableMap();

    for (final JsonLauncherStart jsonLauncher in json) {
      final Launcher launcher = Launcher.fromJson(
        json: jsonLauncher,
        player: players.get(jsonLauncher.playerIndex),
        radius: radius,
      );
      result.add(launcher.location.id, launcher);
    }

    return result;
  }

  JsonLauncherStart toJsonStart() => JsonLauncherStart(
    playerIndex: player.index,
    location: location.toJson(),
    position: position.toJson(),
  );
}
