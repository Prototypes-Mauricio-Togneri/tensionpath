import 'package:tensionpath/persistence/storage/base_storage.dart';

class AudioStorage extends Storage {
  static const FIELD_AUDIO = 'audio';

  static Future save(bool value) => Storage.setBool(FIELD_AUDIO, value);

  static Future<bool> load() => Storage.getBool(FIELD_AUDIO, true);
}
