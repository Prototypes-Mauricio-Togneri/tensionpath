import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/utils/navigation.dart';

class MainState extends BaseState {
  void onSettings() => Navigation.settingsScreen(false);

  void onStart3Lanes() => Navigation.matchScreen(Battlefield.lanes3());

  void onStart5Lanes() => Navigation.matchScreen(Battlefield.lanes5());
}
