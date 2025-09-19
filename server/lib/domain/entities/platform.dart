import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/json/models/start/json_platform.dart';
import 'package:tensionpath/utils/constants.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Platform {
  final String id;
  final List<Location> pads;
  String? owner;

  Platform({
    required this.id,
    required this.pads,
  });

  void update() {
    owner = _newOwner;
  }

  String? get _newOwner {
    const int player1 = 0;
    const int player2 = 0;

    // TODO(momo): check what units are in the platform
    /*for (final Node node in nodes) {
      if (node.hasUnit) {
        if (node.unit!.player.isPlayer1) {
          player1++;
        } else if (node.unit!.player.isPlayer2) {
          player2++;
        }
      }
    }*/

    if ((player1 > 0) && (player2 == 0)) {
      return Constants.PLAYER_1;
    } else if ((player2 > 0) && (player1 == 0)) {
      return Constants.PLAYER_2;
    } else if ((player1 > 0) && (player2 > 0)) {
      return '';
    } else {
      return null;
    }
  }

  factory Platform.fromJson(JsonPlatform json) => Platform(
    id: json.id,
    pads: json.pads.map(Location.fromJson).toList(),
  );

  static IterableMap<String, Platform> list(List<JsonPlatform> json) {
    final IterableMap<String, Platform> result = IterableMap();

    for (final JsonPlatform jsonPlatform in json) {
      final Platform platform = Platform.fromJson(jsonPlatform);
      result.add(platform.id, platform);
    }

    return result;
  }

  JsonPlatform toJson() => JsonPlatform(
    id: id,
    pads: pads.map((p) => p.toJson()).toList(),
  );
}
