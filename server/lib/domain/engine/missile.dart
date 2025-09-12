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

  factory Missile.fromJson(JsonMissile json) {
    final MapList<String, Platform> platforms = MapList();

    for (final jsonPlatform in json.platforms) {
      final platform = Platform.fromJson(jsonPlatform);
      platforms.add(platform.id, platform);
    }

    return Missile(
      location: Location.fromJson(json.location),
      chargeMax: json.chargeMax,
      chargeBuffer: json.chargeBuffer,
      platforms: platforms,
    );
  }

  /*
  "location": {
      "x": 0,
      "y": 0
  },
  "chargeMax": 40,
  "chargeBuffer": 35,
  "platforms": [
      {
          "id": "platform1",
          "pads": [
              {
                  "x": 0,
                  "y": -1
              },
              {
                  "x": 1,
                  "y": -2
              },
              {
                  "x": 0,
                  "y": -2
              }
          ]
      },
      {
          "id": "platform2",
          "pads": [
              {
                  "x": 0,
                  "y": 1
              },
              {
                  "x": 0,
                  "y": 2
              },
              {
                  "x": -1,
                  "y": 2
              }
          ]
      }
  ]
  */
}
