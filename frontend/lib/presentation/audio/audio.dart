import 'package:tensionpath/environments/environment.dart';
import 'package:tensionpath/persistence/storage/settings_storage.dart';
import 'package:tensionpath/presentation/audio/music.dart';
import 'package:tensionpath/presentation/audio/sound.dart';
import 'package:tensionpath/utils/locator.dart';

class Audio with Music, Sound {
  bool enabled = true;

  static Audio get get => locator<Audio>();

  Future toggle() {
    enabled = !enabled;

    return SettingsStorage.saveAudio(enabled);
  }

  void dispose() {
    disposeSound();
    disposeMusic();
  }

  Future load() async {
    enabled = Environment.get.audioEnabled && await SettingsStorage.loadAudio();
    await loadSound();
    await loadMusic();
  }
}
