import 'package:flame/components.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/start/json_resource_start.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Resources {
  final String id;
  final Location location;
  final Position position;
  final num amountMax;
  num amountCurrent;
  num ratio;

  Resources({
    required this.id,
    required this.location,
    required this.position,
    required this.amountCurrent,
    required this.amountMax,
    required this.ratio,
  });

  Vector2 get scale => Vector2(ratio.toDouble(), ratio.toDouble());

  void update(num newAmountCurrent) {
    amountCurrent = newAmountCurrent;
    ratio = amountCurrent / amountMax;
  }

  factory Resources.fromJson(JsonResourceStart json) => Resources(
    id: json.id,
    location: Location.fromJson(json.location),
    position: Position.fromJson(json.position),
    amountCurrent: json.amountCurrent,
    amountMax: json.amountMax,
    ratio: json.amountCurrent / json.amountMax,
  );

  static IterableMap<String, Resources> list(List<JsonResourceStart> json) {
    final IterableMap<String, Resources> result = IterableMap();

    for (final JsonResourceStart jsonResources in json) {
      final Resources resources = Resources.fromJson(jsonResources);
      result.add(resources.id, resources);
    }

    return result;
  }
}
