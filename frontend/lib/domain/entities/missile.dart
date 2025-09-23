import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/platform.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/entities/update.dart';
import 'package:tensionpath/domain/json/models/start/json_missile_start.dart';

class Missile {
  final Location location;
  final Position position;
  final num chargeMax;
  final num chargeBuffer;
  final List<Platform> platforms;
  String? owner;
  num chargeCurrent = 0;

  Missile({
    required this.location,
    required this.position,
    required this.chargeMax,
    required this.chargeBuffer,
    required this.platforms,
  });

  void update(MissileUpdate missileUpdate) {
    owner = missileUpdate.owner;
    chargeCurrent = missileUpdate.charge.clamp(0, chargeMax);
    print('Missile updated: owner=$owner, charge=$chargeCurrent');

    for (final Platform platform in platforms) {
      platform.update(missileUpdate.platforms[platform.id]);
      print(
        'Platform ${platform.id} updated: ${missileUpdate.platforms[platform.id]}',
      );
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

    chargeCurrent = chargeCurrent.clamp(0, chargeMax);
  }

  factory Missile.fromJson(JsonMissileStart json) => Missile(
    location: Location.fromJson(json.location),
    position: Position.fromJson(json.position),
    chargeMax: json.chargeMax,
    chargeBuffer: json.chargeBuffer,
    platforms: Platform.list(json.platforms),
  );
}
