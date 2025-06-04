import 'dart:async';
import 'package:tensionpath/domain/json/json_action.dart';
import 'package:tensionpath/persistence/backend/end_turn_opponent.dart';
import 'package:tensionpath/persistence/backend/end_turn_self.dart';
import 'package:tensionpath/persistence/backend/start_matchmaking.dart';
import 'package:tensionpath/persistence/backend/stop_matchmaking.dart';

class Backend {
  /*static final StreamListener _matchListener = StreamListener();

  static void start(String matchId) {
    final DocumentReference reference = FirebaseFirestore.instance
        .collection('matches')
        .doc(matchId);

    _matchListener.start(
      reference.snapshots().listen((snapshot) {
        if (snapshot.exists) {
          final JsonMatch jsonMatch = JsonMatch.fromJson(snapshot.json);
          _onUpdated(jsonMatch);
        }
      }, onError: ErrorHandler.process),
    );
  }

  static void stop() => _matchListener.stop();

  static Future _onUpdated(JsonMatch jsonMatch) async {
    final bool allWaiting = jsonMatch.players.values.every(
      (p) => p.status == PlayerStatus.waiting,
    );

    if (allWaiting) {
      final JsonMatch jsonMatchUpdated = NextTurn()(jsonMatch);
      await MatchRepository.update(jsonMatchUpdated);
    }
  }*/

  // =============================== END POINTS ================================

  static Future<String> startMatchmaking({
    required String userId,
    required String playerName,
  }) => StartMatchmaking()(userId: userId, playerName: playerName);

  static Future stopMatchmaking({
    required String userId,
    required String roomId,
  }) => StopMatchmaking()(userId: userId, roomId: roomId);

  static Future endTurnSelf({
    required String matchId,
    required String selfId,
    required List<JsonAction> actions,
  }) => EndTurnSelf()(matchId: matchId, selfId: selfId, actions: actions);

  static Future endTurnOpponent({
    required String matchId,
    required String selfId,
  }) => EndTurnOpponent()(matchId: matchId, selfId: selfId);
}
