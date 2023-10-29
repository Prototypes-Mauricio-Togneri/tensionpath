import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/model/document.dart';
import 'package:tensionpath/domain/model/room.dart';
import 'package:tensionpath/domain/model/user_logged.dart';
import 'package:tensionpath/domain/types/room_status.dart';
import 'package:tensionpath/persistence/callables/start_matchmaking_callable.dart';
import 'package:tensionpath/persistence/callables/stop_matchmaking_callable.dart';

class LobbyState extends BaseState {
  StreamSubscription? subscription;
  String roomId = '';

  @override
  Future onLoad() async {
    final Room room = await const StartMatchmakingCallable()(
      playerName: LoggedUser.get.name,
      matchType: 'test',
      numberOfPlayers: 2,
    );

    roomId = room.id;

    subscription = FirebaseFirestore.instance
        .collection('rooms')
        .doc(room.id)
        .snapshots()
        .listen(_onRoomChanged);
  }

  @override
  void onDestroy() {
    subscription?.cancel();
  }

  void _onRoomChanged(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      final Document document = Document.load(snapshot);
      final Room room = Room.fromDocument(document);

      if (room.status == RoomStatus.closed) {
        subscription?.cancel();
      }
    }
  }

  Future<bool> onLeave() async {
    if (roomId.isNotEmpty) {
      await const StopMatchmakingCallable()(
        roomId: roomId,
      );
    }

    return true;
  }
}
