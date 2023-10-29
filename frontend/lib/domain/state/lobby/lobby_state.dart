import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/model/document.dart';
import 'package:tensionpath/domain/model/room.dart';
import 'package:tensionpath/domain/types/room_status.dart';
import 'package:tensionpath/persistence/callables/start_matchmaking_callable.dart';

class LobbyState extends BaseState {
  StreamSubscription? subscription;
  String status = 'loading';

  @override
  Future onLoad() async {
    final Room room = await const StartMatchmakingCallable()(
      numberOfPlayers: 2,
    );

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
    final Document document = Document.load(snapshot);
    final Room room = Room.fromDocument(document);

    if (room.status == RoomStatus.closed) {
      status = 'ready';
      subscription?.cancel();
    } else {
      status = 'waiting';
    }

    notify();
  }
}
