import 'package:tensionpath/domain/data/nodes.dart';
import 'package:tensionpath/domain/data/players.dart';
import 'package:tensionpath/domain/data/units.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/platform.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_missile.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_event.dart';
import 'package:tensionpath/domain/json/models/start/json_missile_start.dart';
import 'package:tensionpath/domain/json/models/update/json_missile_update.dart';
import 'package:tensionpath/utils/constants.dart';
import 'package:tensionpath/utils/iterable_map.dart';
import 'package:tensionpath/utils/logger.dart';

class Missile {
  final Units units;
  final Players players;
  final Location location;
  final Position position;
  final num chargeMax;
  final num chargeBuffer;
  final num chargeAlarm;
  final num chargeRate;
  final num damage;
  final IterableMap<String, Platform> platforms;
  String? owner;
  num chargeCurrent = 0;

  Missile({
    required this.units,
    required this.players,
    required this.location,
    required this.position,
    required this.chargeMax,
    required this.chargeBuffer,
    required this.chargeAlarm,
    required this.chargeRate,
    required this.damage,
    required this.platforms,
  });

  bool get isFullyCharged => (chargeCurrent >= chargeMax) && (owner != null);

  JsonEvent? update(double dt) {
    final num deltaCharge = dt * chargeRate;
    final String? previousOwner = owner;
    final num previousCharge = chargeCurrent;
    bool platformsOwnershipChanged = false;

    for (final Platform platform in platforms) {
      platformsOwnershipChanged |= platform.update(units);
    }

    owner = _newOwner;

    if (owner != null) {
      chargeCurrent += deltaCharge;
    } else if ((owner == '') && (chargeCurrent > chargeBuffer)) {
      chargeCurrent -= deltaCharge;
    }

    chargeCurrent = chargeCurrent.clamp(0, chargeMax);

    bool fired = false;

    if (isFullyCharged) {
      final Player otherPlayer = players.other(owner!);
      otherPlayer.removeHealth(otherPlayer.baseMaxHealth * damage);
      Logger.debug('Missile launched to ${otherPlayer.index}');
      fired = true;
      chargeCurrent = 0;
    }

    final bool missileOwnershipChanged = owner != previousOwner;
    final bool alarm =
        (previousCharge < chargeAlarm) && (chargeCurrent >= chargeAlarm);

    if (alarm ||
        fired ||
        platformsOwnershipChanged ||
        missileOwnershipChanged) {
      return JsonEvent(
        missile: JsonEventMissile(
          charge: chargeCurrent,
          owner: owner,
          platforms: {
            for (final Platform platform in platforms)
              platform.id: platform.owner,
          },
          alarm: alarm,
          fired: fired,
        ),
      );
    } else {
      return null;
    }
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
    required Units units,
    required Players players,
  }) {
    final Node node = nodes.get(json.location.id);

    return Missile(
      units: units,
      players: players,
      location: node.location,
      position: node.position,
      chargeMax: json.chargeMax,
      chargeBuffer: json.chargeBuffer,
      chargeAlarm: json.chargeAlarm,
      chargeRate: json.chargeRate,
      damage: json.damage,
      platforms: Platform.list(
        json: json.platforms,
        nodes: nodes,
      ),
    );
  }

  JsonMissileUpdate toJsonUpdate() => JsonMissileUpdate(
    charge: chargeCurrent,
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
    chargeAlarm: chargeAlarm,
    chargeRate: chargeRate,
    damage: damage,
    platforms: platforms.map((p) => p.toJsonStart()).toList(),
  );
}
