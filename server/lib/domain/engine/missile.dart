import 'package:tensionpath/domain/engine/location.dart';
import 'package:tensionpath/domain/engine/platform.dart';
import 'package:tensionpath/domain/json/models/start/json_missile.dart';
import 'package:tensionpath/utils/map_list.dart';

class Missile {
  final Location location;
  final double chargeMax;
  final double chargeBuffer;
  final MapList<String, Platform> platforms;

  const Missile({
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
