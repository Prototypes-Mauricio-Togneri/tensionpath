import 'package:tensionpath/domain/entities/pad.dart';
import 'package:tensionpath/domain/json/models/start/json_platform_start.dart';
import 'package:tensionpath/utils/constants.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Platform {
  final String id;
  final List<Pad> pads;
  String? owner;

  Platform({
    required this.id,
    required this.pads,
  });

  void update() {
    for (final Pad pad in pads) {
      pad.update();
    }

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

  factory Platform.fromJson(JsonPlatformStart json) => Platform(
    id: json.id,
    pads: json.pads.map(Pad.fromJson).toList(),
  );

  static IterableMap<String, Platform> list(List<JsonPlatformStart> json) {
    final IterableMap<String, Platform> result = IterableMap();

    for (final JsonPlatformStart jsonPlatform in json) {
      final Platform platform = Platform.fromJson(jsonPlatform);
      result.add(platform.id, platform);
    }

    return result;
  }

  JsonPlatformStart toJsonStart() => JsonPlatformStart(
    id: id,
    pads: pads.map((p) => p.toJsonStart()).toList(),
  );
}
