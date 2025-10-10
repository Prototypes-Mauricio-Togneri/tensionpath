import 'package:just_audio/just_audio.dart';
import 'package:tensionpath/presentation/audio/audio.dart';
import 'package:tensionpath/presentation/audio/audio_spec.dart';
import 'package:tensionpath/utils/assets.dart';

mixin Sound {
  final Map<String, AudioPlayer> _soundPlayers = {};
  final List<AudioPlayer> _freePlayers = [];

  static const AudioSpec DOOR_LOCKED = AudioSpec(
    path: Assets.AUDIO_SOUNDS_DETECTION,
  );

  static const List<AudioSpec> ALL_SOUNDS = [
    DOOR_LOCKED,
  ];

  Future playSound(AudioSpec spec) async {
    if (Audio.get.enabled) {
      if (spec.loop) {
        await _playLoopableSound(spec);
      } else {
        await _playEmphirealSound(spec);
      }
    }
  }

  Future stopSound(AudioSpec spec) async => _soundPlayers[spec.path]?.stop();

  Future _playLoopableSound(AudioSpec spec) async {
    final AudioPlayer player = _soundPlayers[spec.path]!;

    if (!player.playing) {
      await player.stop();
      await player.play();
    }
  }

  Future _playEmphirealSound(AudioSpec spec) async {
    final AudioPlayer player = await _getPlayer(spec);
    await player.play();
    await player.stop();

    _freePlayers.add(player);
  }

  Future<AudioPlayer> _getFreePlayer(AudioSpec spec) async {
    if (_freePlayers.isNotEmpty) {
      return _freePlayers.removeLast();
    } else {
      return AudioPlayer();
    }
  }

  Future<AudioPlayer> _getPlayer(AudioSpec spec) async {
    final AudioPlayer player = await _getFreePlayer(spec);
    await player.setAsset(spec.path);
    await player.setLoopMode(spec.loop ? LoopMode.all : LoopMode.off);

    return player;
  }

  Future loadSound() async {
    for (final AudioSpec spec in ALL_SOUNDS) {
      if (spec.loop) {
        _soundPlayers[spec.path] = await _getPlayer(spec);
      }
    }
  }

  void soundSpeed(double value) {
    _soundPlayers.forEach((key, player) => player.setSpeed(value));
  }

  void disposeSound() {
    _soundPlayers.forEach((key, player) => player.dispose());
  }
}
