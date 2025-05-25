import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/persistence/callables/match/create_match_callable.dart';
import 'package:tensionpath/persistence/repository/room_repository.dart';
import 'package:tensionpath/utils/navigation.dart';

class LobbyState extends BaseState {
  final Room room;
  final String playerId;
  StreamSubscription? _roomSubscription;

  LobbyState({required this.room, required this.playerId});

  @override
  void onLoad() {
    _roomSubscription = RoomRepository.listen(
      roomId: room.id,
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
    if (room.isFull) {
      if (room.hasMatchId) {
        Navigation.matchScreen(matchId: room.matchId!, selfId: playerId);
      } else if (playerId == Constants.PLAYER_1) {
        await CreateMatchCallable()(room);
      }
    }
  }
}
