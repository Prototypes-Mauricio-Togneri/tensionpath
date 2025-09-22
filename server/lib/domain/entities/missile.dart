import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/nodes.dart';
import 'package:tensionpath/domain/entities/platform.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/start/json_missile_start.dart';
import 'package:tensionpath/domain/json/models/update/json_missile_update.dart';
import 'package:tensionpath/utils/constants.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Missile {
  final Location location;
  final Position position;
  final num chargeMax;
  final num chargeBuffer;
  final IterableMap<String, Platform> platforms;
  String? owner;
  num charge = 0;

  Missile({
    required this.location,
    required this.position,
    required this.chargeMax,
    required this.chargeBuffer,
    required this.platforms,
  });

  bool update() {
    final String? previousOwner = owner;

    for (final Platform platform in platforms) {
      platform.update();
    }

    owner = _newOwner;

    return (owner != previousOwner);
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

  factory Missile.fromJson({
    required JsonMissileStart json,
    required Nodes nodes,
  }) {
    final Node node = nodes.get(json.location.id);

    return Missile(
      location: node.location,
      position: node.position,
      chargeMax: json.chargeMax,
      chargeBuffer: json.chargeBuffer,
      platforms: Platform.list(
        json: json.platforms,
        nodes: nodes,
      ),
    );
  }

  JsonMissileUpdate toJsonUpdate() => JsonMissileUpdate(
    charge: charge,
    owner: owner,
    platforms: {
      for (final Platform platform in platforms) platform.id: platform.owner,
    },
  );

  JsonMissileStart toJsonStart() => JsonMissileStart(
    location: location.toJson(),
    position: position.toJson(),
    chargeMax: chargeMax,
    chargeBuffer: chargeBuffer,
    platforms: platforms.map((p) => p.toJsonStart()).toList(),
  );
}
