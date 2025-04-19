import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/extensions/document_snapshot_extension.dart';
import 'package:tensionpath/utils/error_handler.dart';

class MatchRepository {
  static DocumentReference _ref([String? id]) =>
      FirebaseFirestore.instance.collection('matches').doc(id);

  static StreamSubscription listen({
    required String matchId,
    required Function(JsonMatch) onUpated,
  }) => _ref(matchId).snapshots().listen((snapshot) {
    if (snapshot.exists) {
      final JsonMatch json = JsonMatch.fromJson(snapshot.json);
      onUpated(json);
    }
  }, onError: ErrorHandler.process);

  static Future update(JsonMatch json) => _ref(json.id).update(json.toJson());

  static Future load({
    required String id,
    required Function(JsonMatch) onLoaded,
  }) async {
    final DocumentSnapshot snapshot = await _ref(id).get();

    if (snapshot.exists) {
      final JsonMatch json = JsonMatch.fromJson(snapshot.json);
      onLoaded(json);
    }
  }

  static Future<String> create(JsonMatch json) async {
    final DocumentReference ref = _ref();
    await ref.set(json.withId(ref.id).toJson());

    return ref.id;
  }
}
