import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/platform.dart';
import 'package:tensionpath/domain/json/models/start/json_missile.dart';

class Missile {
  final Location location;
  final num chargeMax;
  final num chargeBuffer;
  final MapList<String, Platform> platforms;
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
