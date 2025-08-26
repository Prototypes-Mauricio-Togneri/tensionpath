import 'package:tensionpath/persistence/storage/base_storage.dart';

class NameStorage extends Storage {
  static const FIELD_PLAYER_NAME = 'player.name';

  static Future save(String name) => Storage.setString(FIELD_PLAYER_NAME, name);

  static Future<String> load() => Storage.getString(FIELD_PLAYER_NAME, '');

  static Future clear() async {
    await Storage.clear(FIELD_PLAYER_NAME);
  }
}
