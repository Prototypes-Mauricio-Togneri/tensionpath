import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/models/room.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/utils/navigation.dart';

class MainState extends BaseState {
  void onSettings() => Navigation.settingsScreen(false);

  void pve() => Navigation.matchScreen(
        room: Room.empty(),
        battlefield: Battlefield.lanes5(),
      );

  void pvp() => Navigation.lobbyScreen(
        version: 1,
        matchType: 'tensionpath',
        numberOfPlayers: 2,
      );
}
