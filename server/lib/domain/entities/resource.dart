import 'package:tensionpath/domain/data/nodes.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/start/json_resource_start.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Resource {
  final String id;
  final Location location;
  final Position position;
  final num amountMax;
  num amountCurrent;

  Resource({
    required this.id,
    required this.location,
    required this.position,
    required this.amountCurrent,
    required this.amountMax,
  });

  bool get hasResources => amountCurrent > 0;

  factory Resource.fromJson({
    required JsonResourceStart json,
    required Node node,
  }) => Resource(
    id: json.id,
    location: node.location,
    position: node.position,
    amountCurrent: json.amountCurrent,
    amountMax: json.amountMax,
  );

  static IterableMap<String, Resource> list({
    required List<JsonResourceStart> json,
    required Nodes nodes,
  }) {
    final IterableMap<String, Resource> result = IterableMap();

    for (final JsonResourceStart jsonResources in json) {
      final Resource resources = Resource.fromJson(
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
