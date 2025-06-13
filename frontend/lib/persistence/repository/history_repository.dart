import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/domain/json/json_match.dart';

class HistoryRepository {
  static void addSnapshotTransaction({
    required Transaction transaction,
    required JsonMatch jsonMatch,
  }) {
    final DocumentReference ref = FirebaseFirestore.instance
        .collection('matches')
        .doc(jsonMatch.id)
        .collection('history')
        .doc();

    transaction.set(ref, jsonMatch.toJson());
  }
}
