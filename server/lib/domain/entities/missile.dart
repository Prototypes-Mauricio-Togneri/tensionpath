import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/platform.dart';
import 'package:tensionpath/domain/json/models/start/json_missile.dart';
import 'package:tensionpath/domain/json/models/update/json_missile_update.dart';
import 'package:tensionpath/utils/constants.dart';
import 'package:tensionpath/utils/map_list.dart';

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

  void update() {
    for (final Platform platform in platforms) {
      platform.update();
    }

    owner = _newOwner;
  }

  String? get _newOwner {
    int player1 = 0;
    int player2 = 0;
    int none = 0;

    for (final Platform platform in platforms) {
      if (platform.owner == Constants.PLAYER_1) {
        player1++;
      } else if (platform.owner == Constants.PLAYER_2) {
        player2++;
      } else if (platform.owner == null) {
        none++;
      }
    }

    if (none == platforms.length) {
      return null;
    } else if (player1 > player2) {
      return Constants.PLAYER_1;
    } else if (player2 > player1) {
      return Constants.PLAYER_2;
    } else {
      return '';
    }
  }

  factory Missile.fromJson(JsonMissile json) => Missile(
    location: Location.fromJson(json.location),
    chargeMax: json.chargeMax,
    chargeBuffer: json.chargeBuffer,
    platforms: Platform.list(json.platforms),
  );

  JsonMissileUpdate toJsonUpdate() => JsonMissileUpdate(
    charge: charge,
    owner: owner,
    platforms: {
      for (final Platform platform in platforms) platform.id: null,
    },
  );

  JsonMissile toJson() => JsonMissile(
    location: location.toJson(),
    chargeMax: chargeMax,
    chargeBuffer: chargeBuffer,
    platforms: platforms.map((p) => p.toJson()).toList(),
  );
}
