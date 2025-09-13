import 'package:tensionpath/domain/engine/platform.dart';
import 'package:tensionpath/domain/json/models/start/json_missile.dart';
import 'package:tensionpath/domain/json/models/start/json_platform.dart';
import 'package:tensionpath/domain/json/models/update/json_missile_update.dart';
import 'package:tensionpath/utils/map_list.dart';

class Missile {
  final MapList<String, Platform> platforms;
  final double chargeMax;
  final double chargeBuffer;
  double charge = 0;

  Missile({
    required this.platforms,
    required this.chargeMax,
    required this.chargeBuffer,
  });

  factory Missile.fromJson({
    required JsonMissile jsonMissile,
    required List<JsonPlatform> jsonPlatforms,
  }) => Missile(
    chargeMax: jsonMissile.chargeMax,
    chargeBuffer: jsonMissile.chargeBuffer,
    platforms: Platform.list(jsonPlatforms),
  );

  JsonMissileUpdate toJsonUpdate() => JsonMissileUpdate(
    charge: charge,
    platforms: {
      for (final Platform platform in platforms) platform.id: null,
    },
  );
}
