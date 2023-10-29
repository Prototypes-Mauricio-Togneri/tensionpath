import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/utils/navigation.dart';

class MainState extends BaseState {
  final List<bool> selectedPlayers = [
    true,
    false,
    false,
  ];

  void onSelectPlayers(int index) {
    for (int i = 0; i < selectedPlayers.length; i++) {
      selectedPlayers[i] = i == index;
    }

    notify();
  }

  void onSettings() => Navigation.setNameScreen(false);

  void onMatchmaking() => Navigation.lobbyScreen();
}
