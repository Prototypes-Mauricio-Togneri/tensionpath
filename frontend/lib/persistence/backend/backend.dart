import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/types/player_status.dart';
import 'package:tensionpath/extensions/document_snapshot_extension.dart';
import 'package:tensionpath/persistence/backend/end_turn.dart';
import 'package:tensionpath/persistence/backend/end_turn_opponent.dart';
import 'package:tensionpath/persistence/backend/json_utils.dart';
import 'package:tensionpath/persistence/backend/start_matchmaking.dart';
import 'package:tensionpath/persistence/backend/stop_matchmaking.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';
import 'package:tensionpath/utils/error_handler.dart';
import 'package:tensionpath/utils/stream_listener.dart';

class Backend {
  static final StreamListener _matchListener = StreamListener();

  static void start(String matchId) => _matchListener.start(_listen(matchId));

  static void stop() => _matchListener.stop();

  static StreamSubscription _listen(String matchId) {
    final DocumentReference reference = FirebaseFirestore.instance
        .collection('matches')
        .doc(matchId);
    return reference.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        final JsonMatch json = JsonMatch.fromJson(snapshot.json);
        _onUpdated(json);
      }
    }, onError: ErrorHandler.process);
  }

  static Future _onUpdated(JsonMatch json) async {
    final bool allWaiting = json.players.values.every(
      (p) => p.status == PlayerStatus.waiting,
    );

    if (allWaiting) {
      await MatchRepository.update(JsonUtils.nexTurn(json));
    }
  }

  // =============================== END POINTS ================================

  static Future<String> startMatchmaking({
    required String userId,
    required String playerName,
  }) => StartMatchmaking().call(userId: userId, playerName: playerName);

  static Future stopMatchmaking({
    required String userId,
    required String roomId,
  }) => StopMatchmaking().call(userId: userId, roomId: roomId);

  static Future endTurn(Match match) => EndTurn().call(match);

  static Future endTurnOpponent(Match match) => EndTurnOpponent().call(match);
}
