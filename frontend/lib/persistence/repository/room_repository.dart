import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/domain/json/json_room.dart';

class RoomRepository {
  static DocumentReference _ref() =>
      FirebaseFirestore.instance.collection('rooms').doc();

  static Future<String> create(JsonRoom json) async {
    final DocumentReference ref = _ref();
    await ref.set(json.clone(id: ref.id).toJson());

    return ref.id;
  }
}
