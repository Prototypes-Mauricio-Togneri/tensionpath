import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/json/models/start/json_launchers.dart';
import 'package:tensionpath/utils/iterable_map.dart';

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

  static IterableMap<String, Launchers> list(List<JsonLaunchers> json) {
    final IterableMap<String, Launchers> result = IterableMap();

    for (final JsonLaunchers jsonLaunchers in json) {
      final Launchers launchers = Launchers.fromJson(jsonLaunchers);
      result.add(launchers.playerIndex, launchers);
    }

    return result;
  }

  JsonLaunchers toJson() => JsonLaunchers(
    playerIndex: playerIndex,
    locations: locations.map((location) => location.toJson()).toList(),
  );
}
