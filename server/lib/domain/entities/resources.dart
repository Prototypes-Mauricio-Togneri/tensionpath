import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/start/json_resource_start.dart';
import 'package:tensionpath/utils/iterable_map.dart';

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

  factory Resources.fromJson({
    required JsonResourceStart json,
    required Node node,
  }) => Resources(
    id: json.id,
    location: node.location,
    position: node.position,
    amountCurrent: json.amountCurrent,
    amountMax: json.amountMax,
  );

  static IterableMap<String, Resources> list({
    required List<JsonResourceStart> json,
    required IterableMap<String, Node> nodes,
  }) {
    final IterableMap<String, Resources> result = IterableMap();

    for (final JsonResourceStart jsonResources in json) {
      final Resources resources = Resources.fromJson(
        json: jsonResources,
        node: nodes.get(jsonResources.location.id),
      );
      result.add(resources.id, resources);
    }

    return result;
  }

  JsonResourceStart toJsonStart() => JsonResourceStart(
    id: id,
    location: location.toJson(),
    position: position.toJson(),
    amountCurrent: amountCurrent,
    amountMax: amountMax,
  );
}
