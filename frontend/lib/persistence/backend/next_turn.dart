import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_turn.dart';
import 'package:tensionpath/domain/types/player_status.dart';

class NextTurn {
  Future<JsonMatch> call(JsonMatch jsonMatch) async {
    final bool allWaiting = jsonMatch.players.values.every(
      (p) => p.status == PlayerStatus.waiting,
    );

    if (allWaiting) {
      return JsonMatch(
        id: jsonMatch.id,
        version: jsonMatch.version,
        createdAt: jsonMatch.createdAt,
        config: jsonMatch.config,
        turn: _nextTurn(jsonMatch.turn),
        players: _nextPlayers(jsonMatch.players),
        battlefield: jsonMatch.battlefield,
      );
    } else {
      return jsonMatch;
    }
  }

  static JsonTurn _nextTurn(JsonTurn jsonTurn) =>
      JsonTurn(turn: jsonTurn.turn + 1, startedAt: DateTime.now());

  static Map<String, JsonPlayer> _nextPlayers(
    Map<String, JsonPlayer> jsonPlayers,
  ) => Map.fromEntries(
    jsonPlayers.entries.map(
      (entry) => MapEntry(entry.key, _nextPlayer(entry.value)),
    ),
  );

  static JsonPlayer _nextPlayer(JsonPlayer player) => JsonPlayer(
    name: player.name,
    baseHealth: player.baseHealth,
    resources: player.resources,
    status: PlayerStatus.playing,
    turnEndedAt: null,
    actions: [],
  );
}
