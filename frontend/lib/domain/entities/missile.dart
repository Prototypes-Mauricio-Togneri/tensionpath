import 'package:tensionpath/domain/entities/event.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/platform.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/start/json_missile_start.dart';
import 'package:tensionpath/presentation/audio/audio.dart';
import 'package:tensionpath/presentation/audio/sound.dart';

class Missile {
  final Location location;
  final Position position;
  final num chargeMax;
  final num chargeBuffer;
  final List<Platform> platforms;
  String? owner;
  num chargeCurrent = 0;

  static const num ALARM_THRESHOLD = 8;

  Missile({
    required this.location,
    required this.position,
    required this.chargeMax,
    required this.chargeBuffer,
    required this.platforms,
  });

  void update(EventMissile event) {
    owner = event.owner;
    chargeCurrent = event.charge.clamp(0, chargeMax);

    for (final Platform platform in platforms) {
      platform.update(event.platforms[platform.id]);
    }

    if (event.alarm) {
      Audio.get.playSound(Sound.EFFECT_MISSILE_ALARM);
    } else {
      Audio.get.stopSound(Sound.EFFECT_MISSILE_ALARM);
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
