import 'package:tensionpath/domain/engine/battlefield.dart';
import 'package:tensionpath/domain/engine/location.dart';
import 'package:tensionpath/domain/engine/player.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/json/models/start/json_match.dart';
import 'package:tensionpath/domain/json/models/update/json_match_update.dart';
import 'package:tensionpath/domain/json/models/update/json_player_update.dart';
import 'package:tensionpath/domain/types/match_status.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/server/connection.dart';
import 'package:tensionpath/utils/map_list.dart';

class Match {
  final Connection connection;
  final Battlefield battlefield;
  final MapList<String, Player> players;
  double totalTime = 0;
  MatchStatus status;

  Match._({
    required this.connection,
    required this.status,
    required this.battlefield,
    required this.players,
  });

  factory Match.fromJson({
    required Connection connection,
    required JsonMatch jsonMatch,
  }) => Match._(
    connection: connection,
    status: MatchStatus.playing,
    battlefield: Battlefield.fromJson(jsonMatch.battlefield),
    players: Player.list(jsonMatch.players),
  );

  void deployUnit({
    required String playerIndex,
    required Location location,
    required UnitType type,
  }) {
    final Player player = players.get(playerIndex);
    player.removeResources(type.cost.toDouble());
    _sendMatchUpdate();
  }

  void update(double dt) {
    if (status == MatchStatus.playing) {
      totalTime += dt;

      /*
      - For each unit:
        - If moving
          - If target node is free
            - Update position
            - If unit inside of target node -> assign node to unit
          - If target node is not free
            - Re-assign node
            - Update position
            - If unit inside of target node -> assign node to unit
      */
    }
  }

  void _sendMatchUpdate() {
    final Map<String, JsonPlayerUpdate> playersUpdate = {
      for (final Player player in players) player.index: player.toJsonUpdate(),
    };

    final JsonMatchUpdate jsonMatchUpdate = JsonMatchUpdate(
      players: playersUpdate,
      missile: battlefield.missile.toJsonUpdate(),
    );

    connection.broadcast(JsonMessage.update(jsonMatchUpdate));
  }
}
