import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/persistence/storage/base_storage.dart';

class DeckStorage extends Storage {
  static const FIELD_DECK = 'deck';

  static Future save(List<UnitType> deck) =>
      Storage.setStringList(FIELD_DECK, deck.map((type) => type.name).toList());

  static Future<List<UnitType>> load() async {
    final List<String> data = await Storage.getStringList(FIELD_DECK, []);
    final List<UnitType> result = [];

    for (final String element in data) {
      for (final UnitType type in UnitType.values) {
        if (type.name == element) {
          result.add(type);
        }
      }
    }

    return result;
  }

  static Future clear() async {
    await Storage.clear(FIELD_DECK);
  }
}
