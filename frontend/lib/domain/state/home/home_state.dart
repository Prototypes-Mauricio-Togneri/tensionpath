import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/navigation.dart';

class HomeState extends BaseState {
  void onSettings() => Navigation.settingsScreen();

  void onPlay() => Navigation.lobbyScreen();

  void onFullscreen() => SetFullscreen.set();
}
