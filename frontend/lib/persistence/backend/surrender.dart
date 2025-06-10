import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/types/match_status.dart';
import 'package:tensionpath/domain/types/player_status.dart';
import 'package:tensionpath/persistence/repository/history_repository.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class Surrender {
  Future call({required String matchId, required String selfId}) =>
      FirebaseFirestore.instance.runTransaction((transaction) async {
        final JsonMatch jsonMatch = await MatchRepository.get(
          transaction: transaction,
          matchId: matchId,
          selfId: selfId,
        );

        if (jsonMatch.status == MatchStatus.active) {
          for (final MapEntry<String, JsonPlayer> entry
              in jsonMatch.players.entries) {
            final String playerId = entry.key;
            final JsonPlayer jsonPlayer = entry.value;

            jsonPlayer.status = PlayerStatus.waiting;
            jsonPlayer.turnEndedAt = DateTime.now();

            if (playerId == selfId) {
              jsonPlayer.baseHealth = 0;
            }
          }

          jsonMatch.status = MatchStatus.finished;
          jsonMatch.turn.turn += 1;
          jsonMatch.turn.startedAt = DateTime.now();

          MatchRepository.update(
            transaction: transaction,
            jsonMatch: jsonMatch,
          );

          HistoryRepository.addSnapshotTransaction(
            transaction: transaction,
            jsonMatch: jsonMatch,
          );
        }
      });
}
