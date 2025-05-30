import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/entities/matchmaking_info.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/persistence/repository/room_repository.dart';
import 'package:tensionpath/utils/navigation.dart';

class LobbyState extends BaseState {
  final MatchmakingInfo info;
  StreamSubscription? _roomSubscription;

  LobbyState(this.info);

  @override
  void onLoad() {
    _roomSubscription = RoomRepository.listen(
      roomId: info.roomId,
      onUpdated: _onUpdated,
    );
  }

  @override
  void onDestroy() {
    _roomSubscription?.cancel();
    _roomSubscription = null;

    super.onDestroy();
  }

  Future _onUpdated(Room room) async {
    if (room.isReady) {
      Navigation.matchScreen(matchId: room.matchId!, selfId: info.playerId);
    }
  }
}
