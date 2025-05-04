import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/json/json_event.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/extensions/document_snapshot_extension.dart';
import 'package:tensionpath/utils/error_handler.dart';

class MatchRepository {
  static DocumentReference _ref([String? id]) =>
      FirebaseFirestore.instance.collection('matches').doc(id);

  static StreamSubscription listen({
    required String matchId,
    required String selfId,
    required Function(Match) onUpated,
  }) => _ref(matchId).snapshots().listen((snapshot) {
    if (snapshot.exists) {
      final JsonMatch json = JsonMatch.fromJson(snapshot.json);
      final Match match = json.object(selfId);
      onUpated(match);
    }
  }, onError: ErrorHandler.process);

  static Future update({required JsonMatch json, required JsonEvent event}) {
    final Map<String, dynamic> data = json.toJson();
    data['events'] = FieldValue.arrayUnion([event.toJson()]);

    return _ref(json.id).update(data);
  }

  static Future load({
    required String matchId,
    required String selfId,
    required Function(Match) onLoaded,
  }) async {
    final DocumentSnapshot snapshot = await _ref(matchId).get();

    if (snapshot.exists) {
      final JsonMatch json = JsonMatch.fromJson(snapshot.json);
      final Match match = json.object(selfId);
      onLoaded(match);
    }
  }

  static Future<String> create(JsonMatch json) async {
    final DocumentReference ref = _ref('test');
    await ref.set(json.withId(ref.id).toJson());

    return ref.id;
  }
}
