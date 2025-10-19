import 'package:tensionpath/domain/data/nodes.dart';
import 'package:tensionpath/domain/data/units.dart';
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

  bool update(Units units) {
    final String? previousOwner = owner;

    for (final Pad pad in pads) {
      pad.update(units);
    }

    owner = _newOwner;

    return (owner != previousOwner);
  }

  /*
    '': contested
    null: none
    '1': player 1
    '2': player 2
  */
  String? get _newOwner {
    int player1 = 0;
    int player2 = 0;

    for (final Pad pad in pads) {
      if (pad.owner == Constants.PLAYER_1) {
        player1++;
      } else if (pad.owner == Constants.PLAYER_2) {
        player2++;
      }
    }

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

  factory Platform.fromJson({
    required JsonPlatformStart json,
    required Nodes nodes,
  }) => Platform(
    id: json.id,
    pads: json.pads
        .map((p) => Pad.fromJson(json: p, node: nodes.get(p.location.id)))
        .toList(),
  );

  static IterableMap<String, Platform> list({
    required List<JsonPlatformStart> json,
    required Nodes nodes,
  }) {
    final IterableMap<String, Platform> result = IterableMap();

    for (final JsonPlatformStart jsonPlatform in json) {
      final Platform platform = Platform.fromJson(
        json: jsonPlatform,
        nodes: nodes,
      );
      result.add(platform.id, platform);
    }

    return result;
  }

  JsonPlatformStart toJsonStart() => JsonPlatformStart(
    id: id,
    pads: pads.map((p) => p.toJsonStart()).toList(),
  );
}
