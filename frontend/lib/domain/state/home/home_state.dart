import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/navigation.dart';

class HomeState extends BaseState {
  final List<UnitType> cardsSelected = [];

  void onSettings() => Navigation.settingsScreen();

  void onPlay() => Navigation.lobbyScreen();

  void onFullscreen() => SetFullscreen.set();

  bool isSelected(UnitType unitType) => cardsSelected.contains(unitType);

  void onCardSelected(UnitType unitType) {
    if (isSelected(unitType)) {
      cardsSelected.remove(unitType);
    } else {
      cardsSelected.add(unitType);
    }

    notify();
  }
}
