import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/update/json_match_update.dart';
import 'package:tensionpath/domain/json/models/update/json_player_update.dart';
import 'package:tensionpath/domain/types/match_status.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/server/connection.dart';

class Match {
  final Connection match;

  double totalTime = 0;
  MatchStatus status;

  Match._({
    required this.match,
    required this.status,
  });

  factory Match.create(Connection match) => Match._(
    match: match,
    status: MatchStatus.playing,
  );

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

    match.broadcast(JsonMessage.update(update));
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
