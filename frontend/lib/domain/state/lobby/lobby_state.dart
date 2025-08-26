import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/entities/room.dart';

class LobbyState extends BaseState {
  final Room room;
  final String playerId;

  LobbyState({required this.room, required this.playerId});

  @override
  void onLoad() {
    /*_roomSubscription = RoomRepository.listen(
      roomId: room.id,
      onUpdated: _onUpdated,
    );*/
  }

  /*@override
  void onDestroy() {
    _roomSubscription?.cancel();
    _roomSubscription = null;

    super.onDestroy();
  }*/

  /*Future _onUpdated(Room room) async {
    if (room.isFull) {
      if (room.hasMatchId) {
        Navigation.matchScreen(matchId: room.matchId!, selfId: playerId);
      } else if (playerId == Constants.PLAYER_1) {
        await CreateMatchCallable()(room: room);
      }
    }
  }*/
}
