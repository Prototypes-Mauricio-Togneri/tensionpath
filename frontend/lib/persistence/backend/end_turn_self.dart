import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/types/player_status.dart';
import 'package:tensionpath/persistence/backend/next_turn.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class EndTurnSelf {
  Future call({required JsonMatch jsonMatch, required String selfId}) async {
    JsonMatch jsonMatchUpdated = _endTurnSelf(
      jsonMatch: jsonMatch,
      selfId: selfId,
    );
    jsonMatchUpdated = await NextTurn()(jsonMatchUpdated);

    return MatchRepository.update(jsonMatchUpdated);
  }

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
        status: PlayerStatus.waiting,
        turnEndedAt: DateTime.now(),
        actions: jsonPlayer.actions,
      );
    } else {
      return jsonPlayer;
    }
  }
}
