import 'package:tensionpath/domain/engine/location.dart';
import 'package:tensionpath/domain/json/models/start/json_resource.dart';
import 'package:tensionpath/utils/map_list.dart';

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

  static MapList<String, Resources> list(List<JsonResource> json) {
    final MapList<String, Resources> result = MapList();

    for (final JsonResource jsonResources in json) {
      final Resources resources = Resources.fromJson(jsonResources);
      result.add(resources.id, resources);
    }

    return result;
  }
}
