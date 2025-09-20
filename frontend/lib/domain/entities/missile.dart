import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/platform.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/start/json_missile.dart';
import 'package:tensionpath/domain/json/models/update/json_missile_update.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Missile {
  final Location location;
  final Position position;
  final num chargeMax;
  final num chargeBuffer;
  final IterableMap<String, Platform> platforms;
  String? owner;
  num chargeCurrent = 0;

  Missile({
    required this.location,
    required this.position,
    required this.chargeMax,
    required this.chargeBuffer,
    required this.platforms,
  });

  void update(JsonMissileUpdate json) {
    owner = json.owner;
    chargeCurrent = json.charge;

    for (final Platform platform in platforms) {
      platform.update(json.platforms[platform.id]);
    }
  }

  void charge(double dt) {
    if (owner == '') {
      if (chargeCurrent > chargeBuffer) {
        chargeCurrent -= dt;
      }
    } else if (owner != null) {
      chargeCurrent += dt;
    }
  }

  factory Missile.fromJson(JsonMissile json) => Missile(
    location: Location.fromJson(json.location),
    position: Position.fromJson(json.position),
    chargeMax: json.chargeMax,
    chargeBuffer: json.chargeBuffer,
    platforms: Platform.list(json.platforms),
  );
}
