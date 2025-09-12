import 'package:tensionpath/domain/engine/location.dart';
import 'package:tensionpath/domain/json/models/start/json_launchers.dart';
import 'package:tensionpath/utils/map_list.dart';

class Launchers {
  final String playerIndex;
  final List<Location> locations;

  const Launchers({
    required this.playerIndex,
    required this.locations,
  });

  factory Launchers.fromJson(JsonLaunchers json) => Launchers(
    playerIndex: json.playerIndex,
    locations: json.locations.map(Location.fromJson).toList(),
  );

  static MapList<String, Launchers> list(List<JsonLaunchers> json) {
    final MapList<String, Launchers> result = MapList();

    for (final JsonLaunchers jsonLaunchers in json) {
      final Launchers platform = Launchers.fromJson(jsonLaunchers);
      result.add(platform.playerIndex, platform);
    }

    return result;
  }
}
