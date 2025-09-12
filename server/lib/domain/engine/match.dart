import 'package:tensionpath/domain/engine/player.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/start/json_match.dart';
import 'package:tensionpath/domain/json/models/start/json_player.dart';
import 'package:tensionpath/domain/json/models/update/json_match_update.dart';
import 'package:tensionpath/domain/json/models/update/json_player_update.dart';
import 'package:tensionpath/domain/types/match_status.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/server/connection.dart';

class Match {
  final Connection connection;
  final List<Player> players;
  double totalTime = 0;
  MatchStatus status;

  Match._({
    required this.connection,
    required this.status,
    required this.players,
  });

  factory Match.create({
    required Connection connection,
    required JsonMatch jsonMatch,
  }) {
    final List<Player> players = [];

    for (final JsonPlayer jsonPlayer in jsonMatch.players) {
      final Player player = Player(
        id: jsonPlayer.id,
        name: jsonPlayer.name,
        index: jsonPlayer.index,
        baseMaxHealth: jsonPlayer.baseMaxHealth,
        baseHealth: jsonPlayer.baseHealth,
        resources: jsonPlayer.resources,
      );
      players.add(player);
    }

    return Match._(
      connection: connection,
      status: MatchStatus.playing,
      players: players,
    );
  }

  /*JsonMatch json(Player self) {
    final List<JsonPlayer> jsonPlayers = players
        .map((e) => e.json(e == self))
        .toList();
    final List<JsonLane> jsonLanes = lanes.map((e) => e.json()).toList();

    return JsonMatch(
      id: match.id,
      remainingTime: Constants.MATCH_TIMEOUT - totalTime,
      players: jsonPlayers,
      lanes: jsonLanes,
      status: status,
    );
  }*/

  void deployUnit({
    required String playerId,
    required JsonLocation location,
    required UnitType type,
  }) {
    final JsonMatchUpdate update = JsonMatchUpdate(
      players: {
        playerId: JsonPlayerUpdate(
          baseHealth: 100,
          resources: 50,
        ),
      },
    );

    connection.broadcast(JsonMessage.update(update));
  }

  void update(double dt) {
    if (status == MatchStatus.playing) {
      totalTime += dt;

      /*for (final Player player in players) {
        player.update(dt);
      }

      final List<LaneUpdate> laneUpdates = [];

      for (final Lane lane in lanes) {
        final List<LaneUpdate> updates = lane.update(
          dt: dt,
          player1: players.list[0],
          player2: players.list[1],
        );
        laneUpdates.addAll(updates);
      }

      if (laneUpdates.isNotEmpty) {
        _sendMatchUpdate();
      }

      for (final LaneUpdate update in laneUpdates) {
        _sendToPlayer(
          player: update.player,
          json: update.message,
        );
      }

      if (!_checkWinnerByPoints()) {
        if (totalTime >= Constants.MATCH_TIMEOUT) {
          _checkWinnerByTerritory();
        }
      }*/
    }
  }

  /*void _sendMatchUpdate() {
    for (final Player player in players) {
      _sendToPlayer(
        player: player,
        json: JsonMessage.update(json(player)),
      );
    }
  }

  void _sendToPlayer({
    required Player player,
    required JsonMessage json,
  }) => match.direct(
    playerId: player.id,
    json: json,
  );*/
}
