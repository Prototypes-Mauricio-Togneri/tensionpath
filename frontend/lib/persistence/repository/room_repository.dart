import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/json/models/room/json_room.dart';
import 'package:tensionpath/extensions/document_snapshot_extension.dart';
import 'package:tensionpath/utils/error_handler.dart';

class RoomRepository {
  static StreamSubscription listen({
    required String roomId,
    required Function(Room) onUpdated,
  }) {
    final DocumentReference reference = FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId);

    return reference.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        final JsonRoom jsonRoom = JsonRoom.fromJson(snapshot.json);
        onUpdated(jsonRoom.object);
      }
    }, onError: ErrorHandler.process);
  }
}
