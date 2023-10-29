import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/utils/navigation.dart';

class MainState extends BaseState {
  void onSettings() => Navigation.setNameScreen(false);

  void onMatchmaking() => Navigation.lobbyScreen();
}
