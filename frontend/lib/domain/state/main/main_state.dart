import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/utils/navigation.dart';

class MainState extends BaseState {
  void onSettings() => Navigation.settingsScreen(false);

  // void pve() => Navigation.matchScreen(Battlefield.lanes3());

  void pvp() => Navigation.lobbyScreen(
        version: 1,
        matchType: 'tensionpath',
        numberOfPlayers: 2,
      );
}
