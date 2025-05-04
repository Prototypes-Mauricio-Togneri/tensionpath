import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/persistence/callables/room/create_room_callable.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/navigation.dart';

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
    final Room room = await CreateRoomCallable()(playerName: 'Pepe');
    Navigation.lobbyScreen(room: room, playerId: room.playerIds.first);
  }

  /*Future onCreateMatch() async {
    final String content = await rootBundle.loadString(Assets.TEMPLATES_W9H7);
    final JsonMatch json = JsonMatch.fromJson(jsonDecode(content));
    final String matchId = await MatchRepository.create(json);
    Navigation.matchScreen(matchId: matchId, selfId: Constants.PLAYER_1);
  }*/
}
