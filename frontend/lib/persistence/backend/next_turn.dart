import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_turn.dart';
import 'package:tensionpath/domain/types/player_status.dart';

class NextTurn {
  JsonMatch call(JsonMatch jsonMatch) => JsonMatch(
    id: jsonMatch.id,
    version: jsonMatch.version,
    createdAt: jsonMatch.createdAt,
    config: jsonMatch.config,
    turn: _nextTurn(jsonMatch.turn),
    players: _playersNextTurn(jsonMatch.players),
    battlefield: jsonMatch.battlefield,
  );

  static JsonTurn _nextTurn(JsonTurn jsonTurn) =>
      JsonTurn(turn: jsonTurn.turn + 1, startedAt: DateTime.now());

  static Map<String, JsonPlayer> _playersNextTurn(
    Map<String, JsonPlayer> jsonPlayers,
  ) => Map.fromEntries(
    jsonPlayers.entries.map(
      (entry) => MapEntry(entry.key, _playerNextTurn(entry.value)),
    ),
  );

  static JsonPlayer _playerNextTurn(JsonPlayer player) => JsonPlayer(
    name: player.name,
    baseHealth: player.baseHealth,
    resources: player.resources,
    status: PlayerStatus.playing,
    turnEndedAt: null,
  );
}
