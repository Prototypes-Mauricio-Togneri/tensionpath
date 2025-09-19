import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/json/models/start/json_resource.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Resources {
  final String id;
  final Location location;
  final num amountMax;
  num amountCurrent;

  Resources({
    required this.id,
    required this.location,
    required this.amountCurrent,
    required this.amountMax,
  });

  factory Resources.fromJson(JsonResource json) => Resources(
    id: json.id,
    location: Location.fromJson(json.location),
    amountCurrent: json.amountCurrent,
    amountMax: json.amountMax,
  );

  static IterableMap<String, Resources> list(List<JsonResource> json) {
    final IterableMap<String, Resources> result = IterableMap();

    for (final JsonResource jsonResources in json) {
      final Resources resources = Resources.fromJson(jsonResources);
      result.add(resources.id, resources);
    }

    return result;
  }
}
