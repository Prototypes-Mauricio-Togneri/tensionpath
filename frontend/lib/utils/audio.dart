import 'package:just_audio/just_audio.dart';
import 'package:tensionpath/persistence/storage/settings_storage.dart';
import 'package:tensionpath/utils/assets.dart';
import 'package:tensionpath/utils/locator.dart';

class Audio {
  final Map<String, AudioPlayer> _soundPlayers = {};
  //final Map<String, AudioPlayer> _musicPlayers = {};
  bool _enabled = true;
  //AudioPlayer? _playerToResume;

  static const String NEW_TURN = Assets.AUDIO_SOUND_NEWTURN;

  static Audio get get => locator<Audio>();

  bool get enabled => _enabled;

  void toggle() {
    _enabled = !_enabled;
    SettingsStorage.saveAudio(_enabled);
  }

  Future playSound(String sound) async {
    if (enabled) {
      await stopSound(sound);
      await _soundPlayers[sound]?.play();
    }
  }

  Future stopSound(String sound) async {
    await _soundPlayers[sound]?.pause();
    await _soundPlayers[sound]?.seek(Duration.zero);
  }

  /*Future playMusic(String music) async {
    if (_isEnabled) {
      await stopMusic();
      await _musicPlayers[music]?.seek(const Duration(seconds: 0));
      _musicPlayers[music]?.play();
    }
  }*/

  /*void pauseMusic() {
    for (final AudioPlayer player in _musicPlayers.values) {
      if (player.playing) {
        _playerToResume = player;
        break;
      }
    }

    _playerToResume?.pause();
  }*/

  /*void resumeMusic() {
    _playerToResume?.play();
    _playerToResume = null;
  }*/

  /*Future stopMusic() async {
    for (final AudioPlayer player in _musicPlayers.values) {
      await player.stop();
    }
  }*/

  /*void volumeSound(String id, double volume) =>
      _soundPlayers[id]!.setVolume(volume);*/

  /*void speed(double value) {
    _soundPlayers.forEach((key, player) => player.setSpeed(value));
    _musicPlayers.forEach((key, player) => player.setSpeed(value));
  }*/

  void dispose() {
    //stopMusic();
    _soundPlayers.forEach((key, player) => player.dispose());
    //_musicPlayers.forEach((key, player) => player.dispose());
  }

  Future load() async {
    _enabled = await SettingsStorage.loadAudio();
    _soundPlayers[NEW_TURN] = await _getPlayer(path: NEW_TURN);
  }

  Future<AudioPlayer> _getPlayer({
    required String path,
    LoopMode loopMode = LoopMode.off,
  }) async {
    final AudioPlayer player = AudioPlayer();
    await player.setAsset(path);

    if (loopMode != LoopMode.off) {
      await player.setLoopMode(loopMode);
    }

    return player;
  }
}
