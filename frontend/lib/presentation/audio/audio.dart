import 'package:tensionpath/persistence/storage/audio_storage.dart';
import 'package:tensionpath/presentation/audio/music.dart';
import 'package:tensionpath/presentation/audio/sound.dart';
import 'package:tensionpath/utils/locator.dart';

class Audio with Music, Sound {
  bool enabled = true;

  static Audio get get => locator<Audio>();

  Future toggle() {
    enabled = !enabled;

    return AudioStorage.save(enabled);
  }

  void dispose() {
    disposeSound();
    disposeMusic();
  }

  Future load() async {
    enabled = await AudioStorage.load();
    await loadSound();
    await loadMusic();
  }
}
