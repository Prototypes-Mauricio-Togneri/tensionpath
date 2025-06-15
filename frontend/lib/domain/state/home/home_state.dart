import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';
import 'package:tensionpath/persistence/callables/room/start_matchmaking_callable.dart';
import 'package:tensionpath/persistence/storage/settings_storage.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/navigation.dart';

class HomeState extends BaseState {
  void onHistory() {}

  void onSettings() => Navigation.settingsScreen();

  Future onPlay() async {
    final String name = await SettingsStorage.loadName();
    final Room room = await const StartMatchmakingCallable()(
      playerName: name,
      version: 1,
      matchType: 'pvp',
      numberOfPlayers: 2,
      visibility: RoomVisibility.public,
    );
    Navigation.lobbyScreen(room);
  }

  void onFullscreen() => SetFullscreen.set();
}
