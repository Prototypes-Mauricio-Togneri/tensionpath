import 'package:dafluta/dafluta.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';
import 'package:tensionpath/persistence/callables/room/start_matchmaking_callable.dart';
import 'package:tensionpath/persistence/storage/name_storage.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/navigation.dart';

class HomeState extends BaseState {
  String version = '';

  @override
  Future onLoad() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = 'v${packageInfo.version} (${packageInfo.buildNumber})';
    notify();
  }

  void onHistory() {}

  void onSettings() {}

  Future onPlay() async {
    final String name = await NameStorage.load();
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
