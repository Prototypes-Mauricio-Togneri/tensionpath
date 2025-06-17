import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/extensions/document_snapshot_extension.dart';
import 'package:tensionpath/utils/error_handler.dart';

class MatchRepository {
  static DocumentReference _ref(String id) =>
      FirebaseFirestore.instance.collection('matches').doc(id);

  static StreamSubscription listen({
    required String matchId,
    required String selfId,
    required Function(Match) onUpdated,
  }) => _ref(matchId).snapshots().listen((snapshot) {
    if (snapshot.exists) {
      final JsonMatch jsonMatch = JsonMatch.fromJson(snapshot.json);
      final Match match = jsonMatch.object(selfId);
      onUpdated(match);
    }
  }, onError: ErrorHandler.process);

  static Future load({
    required String matchId,
    required String selfId,
    required Function(Match) onLoaded,
  }) async {
    final DocumentSnapshot snapshot = await _ref(matchId).get();

    if (snapshot.exists) {
      final JsonMatch jsonMatch = JsonMatch.fromJson(snapshot.json);
      final Match match = jsonMatch.object(selfId);
      onLoaded(match);
    }
  }

  static Future<List<Match>> pastMatches(String userId) async {
    final Query query = FirebaseFirestore.instance
        .collection('matches')
        .where('room.userIds', arrayContains: userId)
        .where('status', isEqualTo: 'finished')
        .orderBy('createdAt', descending: true);

    final QuerySnapshot snapshot = await query.get();

    return snapshot.docs.map((doc) {
      final JsonMatch jsonMatch = JsonMatch.fromJson(doc.json);
      return jsonMatch.object(userId);
    }).toList();
  }
}
