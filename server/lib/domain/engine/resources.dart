import 'package:tensionpath/domain/engine/location.dart';
import 'package:tensionpath/domain/json/models/start/json_resource.dart';
import 'package:tensionpath/utils/map_list.dart';

class Resources {
  final String id;
  final Location location;

  Resources({
    required this.id,
    required this.location,
  });

  factory Resources.fromJson(JsonResource json) => Resources(
    id: json.id,
    location: Location.fromJson(json.location),
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
