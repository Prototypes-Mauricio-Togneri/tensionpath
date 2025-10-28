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
  final num chargeAlarm;
  final num chargeRate;
  final List<Platform> platforms;
  String? owner;
  num chargeCurrent = 0;
  bool playingAlarm = false;

  Missile({
    required this.location,
    required this.position,
    required this.chargeMax,
    required this.chargeBuffer,
    required this.chargeAlarm,
    required this.chargeRate,
    required this.platforms,
  });

  void refresh(EventMissile event) {
    owner = event.owner;
    chargeCurrent = event.charge.clamp(0, chargeMax);

    for (final Platform platform in platforms) {
      platform.refresh(event.platforms[platform.id]);
    }

    if (event.fired) {
      playingAlarm = false;
      Audio.get.stopSound(Sound.EFFECT_MISSILE_ALARM);
    }
  }

  void charge(double dt) {
    final num deltaCharge = dt * chargeRate;

    if (owner == '') {
      if (chargeCurrent > chargeBuffer) {
        chargeCurrent -= deltaCharge;
      }
    } else if (owner != null) {
      chargeCurrent += deltaCharge;
    }

    chargeCurrent = chargeCurrent.clamp(0, chargeMax);

    if ((chargeCurrent >= chargeAlarm) && !playingAlarm) {
      playingAlarm = true;
      Audio.get.playSound(Sound.EFFECT_MISSILE_ALARM);
    }
  }

  factory Missile.fromJson(JsonMissileStart json) => Missile(
    location: Location.fromJson(json.location),
    position: Position.fromJson(json.position),
    chargeMax: json.chargeMax,
    chargeBuffer: json.chargeBuffer,
    chargeAlarm: json.chargeAlarm,
    chargeRate: json.chargeRate,
    platforms: Platform.list(json.platforms),
  );
}
