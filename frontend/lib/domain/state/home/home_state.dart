import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/navigation.dart';

class HomeState extends BaseState {
  static const int MAX_CARDS = 6;

  final List<UnitType> cardsSelected = [];

  void onSettings() => Navigation.settingsScreen();

  void onPlay() => Navigation.lobbyScreen();

  void onFullscreen() => SetFullscreen.set();

  bool get isDeckFull => cardsSelected.length == MAX_CARDS;

  bool isSelected(UnitType unitType) => cardsSelected.contains(unitType);

  void onCardSelected(UnitType unitType) {
    if (isSelected(unitType)) {
      cardsSelected.remove(unitType);
    } else if (cardsSelected.length < MAX_CARDS) {
      cardsSelected.add(unitType);
    }

    notify();
  }
}
