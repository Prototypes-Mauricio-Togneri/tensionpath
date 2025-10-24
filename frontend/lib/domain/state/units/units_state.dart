import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/persistence/storage/deck_storage.dart';
import 'package:tensionpath/utils/navigation.dart';

class UnitsState extends BaseState {
  static const int MAX_CARDS = 6;

  final List<UnitType> deck = [];

  @override
  Future onLoad() async {
    deck.addAll(await DeckStorage.load());
    notify();
  }

  void onClose() => Navigation.pop();

  bool get isDeckFull => deck.length == MAX_CARDS;

  bool isSelected(UnitType unitType) => deck.contains(unitType);

  void onCardSelected(UnitType unitType) {
    if (isSelected(unitType)) {
      deck.remove(unitType);
    } else if (deck.length < MAX_CARDS) {
      deck.add(unitType);
    }

    notify();
  }
}
