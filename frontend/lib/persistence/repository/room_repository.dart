import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/json/json_room.dart';
import 'package:tensionpath/domain/types/room_status.dart';
import 'package:tensionpath/extensions/document_snapshot_extension.dart';
import 'package:tensionpath/utils/error_handler.dart';

class RoomRepository {
  static DocumentReference _ref([String? roomId]) =>
      FirebaseFirestore.instance.collection('rooms').doc(roomId);

  static Future stopMatchmaking({
    required String userId,
    required String roomId,
  }) async {
    final DocumentReference ref = _ref(roomId);
    final DocumentSnapshot snapshot = await ref.get();
    final JsonRoom jsonRoom = JsonRoom.fromJson(snapshot.json);

    if (!jsonRoom.users.containsKey(userId)) {
      throw Exception('User is not in the room');
    }

    if (jsonRoom.status != RoomStatus.open) {
      throw Exception('Room is not open');
    }

    if (jsonRoom.users.length == 1) {
      await ref.delete();
    } else {
      jsonRoom.status = RoomStatus.closed;
      jsonRoom.userIds = jsonRoom.userIds.where((id) => id != userId).toList();
      jsonRoom.users = jsonRoom.users
        ..removeWhere((key, value) => key == userId);

      await RoomRepository._update(jsonRoom);
    }
  }

  static StreamSubscription listen({
    required String roomId,
    required Function(Room) onUpdated,
  }) => _ref(roomId).snapshots().listen((snapshot) {
    if (snapshot.exists) {
      final JsonRoom jsonRoom = JsonRoom.fromJson(snapshot.json);
      onUpdated(jsonRoom.object);
    }
  }, onError: ErrorHandler.process);

  static Future<Room> _update(JsonRoom jsonRoom) async {
    await _ref(jsonRoom.id).update(jsonRoom.toJson());

    return jsonRoom.object;
  }
}
