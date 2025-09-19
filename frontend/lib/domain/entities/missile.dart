import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/platform.dart';
import 'package:tensionpath/domain/json/models/start/json_missile.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Missile {
  final Location location;
  final num chargeMax;
  final num chargeBuffer;
  final IterableMap<String, Platform> platforms;
  String? owner;
  num charge = 0;

  Missile({
    required this.location,
    required this.chargeMax,
    required this.chargeBuffer,
    required this.platforms,
  });

  factory Missile.fromJson(JsonMissile json) => Missile(
    location: Location.fromJson(json.location),
    chargeMax: json.chargeMax,
    chargeBuffer: json.chargeBuffer,
    platforms: Platform.list(json.platforms),
  );
}
