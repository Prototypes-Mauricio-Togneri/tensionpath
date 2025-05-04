import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/json/json_room.dart';
import 'package:tensionpath/domain/types/room_status.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';
import 'package:tensionpath/persistence/repository/room_repository.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:uuid/uuid.dart';

class SplashState extends BaseState {
  @override
  void onLoad() {
    /*if (Environment.get.isDebug) {
      Delayed.post(() => _onPlay(Constants.PLAYER_1));
    }*/
  }

  //void _onPlay(String selfId) =>
  //    Navigation.matchScreen(matchId: 'test', selfId: selfId);

  void onFullscreen() => SetFullscreen.set();

  Future onCreateRoom() async {
    final String playerId = const Uuid().v4();
    const String playerName = 'Pepe';

    final JsonRoom json = JsonRoom(
      id: '',
      version: 1,
      createdAt: DateTime.now(),
      numberOfPlayers: 2,
      visibility: RoomVisibility.public,
      status: RoomStatus.open,
      matchType: '1v1',
      playerIds: [playerId],
      players: {playerId: playerName},
    );

    final String roomId = await RoomRepository.create(json);
    print('Room created: $roomId');
    //Navigation.matchScreen(matchId: matchId, selfId: Constants.PLAYER_1);
  }

  /*Future onCreateMatch() async {
    final String content = await rootBundle.loadString(Assets.TEMPLATES_W9H7);
    final JsonMatch json = JsonMatch.fromJson(jsonDecode(content));
    final String matchId = await MatchRepository.create(json);
    Navigation.matchScreen(matchId: matchId, selfId: Constants.PLAYER_1);
  }*/
}
