import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/types/player_status.dart';
import 'package:tensionpath/persistence/backend/next_turn.dart';
import 'package:tensionpath/persistence/repository/history_repository.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class EndTurnOpponent {
  Future call({required String matchId, required String selfId}) =>
      FirebaseFirestore.instance.runTransaction((transaction) async {
        JsonMatch jsonMatch = await MatchRepository.get(
          transaction: transaction,
          matchId: matchId,
          selfId: selfId,
        );

        for (final MapEntry<String, JsonPlayer> entry
            in jsonMatch.players.entries) {
          final String playerId = entry.key;
          final JsonPlayer jsonPlayer = entry.value;

          if (playerId != selfId) {
            jsonPlayer.status = PlayerStatus.waiting;
            jsonPlayer.turnEndedAt = DateTime.now();
            jsonPlayer.actions = [];
          }
        }

        final int turnBefore = jsonMatch.turn.turn;

        jsonMatch = await NextTurn()(jsonMatch);

        MatchRepository.update(transaction: transaction, json: jsonMatch);

        if (jsonMatch.turn.turn != turnBefore) {
          HistoryRepository.addSnapshotTransaction(
            transaction: transaction,
            jsonMatch: jsonMatch,
          );
        }
      });
}
