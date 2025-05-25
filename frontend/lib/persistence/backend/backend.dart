import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/extensions/document_snapshot_extension.dart';
import 'package:tensionpath/persistence/backend/create_match.dart';
import 'package:tensionpath/persistence/backend/create_room.dart';
import 'package:tensionpath/persistence/backend/end_turn.dart';
import 'package:tensionpath/persistence/backend/end_turn_opponent.dart';
import 'package:tensionpath/persistence/backend/join_room.dart';
import 'package:tensionpath/utils/error_handler.dart';

class Backend {
  static StreamSubscription? _subscription;

  static void start(String matchId) {
    final DocumentReference reference = FirebaseFirestore.instance
        .collection('matches')
        .doc(matchId);
    _subscription = reference.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        final JsonMatch json = JsonMatch.fromJson(snapshot.json);
        _onUpdated(json);
      }
    }, onError: ErrorHandler.process);
  }

  static void stop() {
    _subscription?.cancel();
    _subscription = null;
  }

  static void _onUpdated(JsonMatch json) {
    // Handle the updated match object
  }

  // =============================== END POINTS ================================

  static Future<Room> createRoom(String playerName) =>
      CreateRoom().call(playerName);

  static Future<Room> joinRoom({
    required String roomId,
    required String playerName,
  }) => JoinRoom().call(roomId: roomId, playerName: playerName);

  static Future createMatch(Room room) => CreateMatch().call(room: room);

  static Future endTurn(Match match) => EndTurn().call(match);

  static Future endTurnOpponent(Match match) => EndTurnOpponent().call(match);
}
