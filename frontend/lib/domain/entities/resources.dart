import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/start/json_resource_start.dart';

class Resources {
  final String id;
  final Location location;
  final Position position;
  final num amountMax;
  num amountCurrent;

  Resources({
    required this.id,
    required this.location,
    required this.position,
    required this.amountCurrent,
    required this.amountMax,
  });

  bool get hasResources => amountCurrent > 0;

  void deplete() {
    amountCurrent = 0;
  }

  factory Resources.fromJson(JsonResourceStart json) => Resources(
    id: json.id,
    location: Location.fromJson(json.location),
    position: Position.fromJson(json.position),
    amountCurrent: json.amountCurrent,
    amountMax: json.amountMax,
  );

  static List<Resources> list(List<JsonResourceStart> json) {
    final List<Resources> result = [];

    for (final JsonResourceStart jsonResources in json) {
      final Resources resources = Resources.fromJson(jsonResources);
      result.add(resources);
    }

    return result;
  }
}
