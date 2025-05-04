import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/entities/room.dart';
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

  void _onUpdated(Room room) {
    if (room.isFull) {
      Navigation.matchScreen(matchId: matchId, selfId: playerId);
    }
  }

  /*Future onCreateMatch() async {
    final String content = await rootBundle.loadString(Assets.TEMPLATES_W9H7);
    final JsonMatch json = JsonMatch.fromJson(jsonDecode(content));
    final String matchId = await MatchRepository.create(json);
    Navigation.matchScreen(matchId: matchId, selfId: Constants.PLAYER_1);
  }*/
}
