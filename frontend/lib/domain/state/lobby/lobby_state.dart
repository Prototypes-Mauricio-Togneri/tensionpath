import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/entities/matchmaking_info.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/persistence/repository/room_repository.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/stream_listener.dart';

class LobbyState extends BaseState {
  final MatchmakingInfo info;
  final StreamListener _roomListener = StreamListener();

  LobbyState(this.info);

  @override
  void onLoad() {
    _roomListener.start(
      RoomRepository.listen(roomId: info.roomId, onUpdated: _onUpdated),
    );
  }

  @override
  void onDestroy() {
    _roomListener.stop();
  }

  Future _onUpdated(Room room) async {
    if (room.isReady) {
      Navigation.matchScreen(matchId: room.matchId!, selfId: info.playerId);
    }
  }
}
