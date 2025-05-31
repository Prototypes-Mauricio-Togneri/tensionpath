import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class EndTurn {
  Future call({required JsonMatch jsonMatch, required String selfId}) =>
      MatchRepository.update(
        _endTurnSelf(jsonMatch: jsonMatch, selfId: selfId),
      );

  JsonMatch _endTurnSelf({
    required JsonMatch jsonMatch,
    required String selfId,
  }) => JsonMatch(
    id: jsonMatch.id,
    version: jsonMatch.version,
    createdAt: jsonMatch.createdAt,
    config: jsonMatch.config,
    turn: jsonMatch.turn,
    players: Map.fromEntries(
      jsonMatch.players.entries.map(
        (entry) => MapEntry(
          entry.key,
          _jsonPlayer(
            playerId: entry.key,
            jsonPlayer: entry.value,
            selfId: selfId,
          ),
        ),
      ),
    ),
    battlefield: jsonMatch.battlefield,
  );

  JsonPlayer _jsonPlayer({
    required String playerId,
    required JsonPlayer jsonPlayer,
    required String selfId,
  }) {
    if (playerId == selfId) {
      return JsonPlayer(
        name: jsonPlayer.name,
        baseHealth: jsonPlayer.baseHealth,
        resources: jsonPlayer.resources,
        status: jsonPlayer.status,
        turnEndedAt: DateTime.now(),
      );
    } else {
      return jsonPlayer;
    }
  }
}
