import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/persistence/callables/room/stop_matchmaking_callable.dart';
import 'package:tensionpath/persistence/repository/room_repository.dart';
import 'package:tensionpath/utils/authentication.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/stream_listener.dart';

class LobbyState extends BaseState {
  final Room room;
  final StreamListener _roomListener = StreamListener();

  LobbyState(this.room);

  @override
  void onLoad() {
    _roomListener.start(
      RoomRepository.listen(
        roomId: room.id,
        onUpdated: _onUpdated,
      ),
    );
  }

  @override
  void onDestroy() {
    _roomListener.stop();
  }

  Future onCancel() async {
    await const StopMatchmakingCallable()(roomId: room.id);
    Navigation.pop();
  }

  Future _onUpdated(Room room) async {
    if (room.isReady) {
      Navigation.matchScreen(
        matchId: room.matchId!,
        userId: Authentication.userId,
      );
    }
  }
}
