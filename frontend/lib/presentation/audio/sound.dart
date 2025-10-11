import 'package:just_audio/just_audio.dart';
import 'package:tensionpath/presentation/audio/audio.dart';
import 'package:tensionpath/presentation/audio/audio_spec.dart';
import 'package:tensionpath/utils/assets.dart';

mixin Sound {
  final Map<String, AudioPlayer> _soundPlayers = {};
  final List<AudioPlayer> _freePlayers = [];

  // Effects
  static const AudioSpec MISSILE_ALARM = AudioSpec(
    path: Assets.AUDIO_SOUND_MISSILE_ALARM,
    loop: true,
  );

  // Voices
  static const AudioSpec BASE_UNDER_ATTACK = AudioSpec(
    path: Assets.AUDIO_SOUND_BASE_UNDER_ATTACK,
  );
  static const AudioSpec HARVESTER_UNDER_ATTACK = AudioSpec(
    path: Assets.AUDIO_SOUND_HARVESTER_UNDER_ATTACK,
  );
  static const AudioSpec CANNOT_DEPLOY = AudioSpec(
    path: Assets.AUDIO_SOUND_CANNOT_DEPLOY,
  );
  static const AudioSpec MISSILE_LAUNCHED = AudioSpec(
    path: Assets.AUDIO_SOUND_MISSILE_LAUNCHED,
  );
  static const AudioSpec MISSION_ACCOMPLISHED = AudioSpec(
    path: Assets.AUDIO_SOUND_MISSION_ACCOMPLISHED,
  );
  static const AudioSpec MISSION_FAILED = AudioSpec(
    path: Assets.AUDIO_SOUND_MISSION_FAILED,
  );
  static const AudioSpec SELECT_TARGET = AudioSpec(
    path: Assets.AUDIO_SOUND_SELECT_TARGET,
  );
  static const AudioSpec UNIT_LOST = AudioSpec(
    path: Assets.AUDIO_SOUND_UNIT_LOST,
  );
  static const AudioSpec UNIT_READY = AudioSpec(
    path: Assets.AUDIO_SOUND_UNIT_READY,
  );

  static const List<AudioSpec> ALL_SOUNDS = [
    // Effects
    MISSILE_ALARM,

    // Voices
    BASE_UNDER_ATTACK,
    HARVESTER_UNDER_ATTACK,
    CANNOT_DEPLOY,
    MISSILE_LAUNCHED,
    MISSION_ACCOMPLISHED,
    MISSION_FAILED,
    SELECT_TARGET,
    UNIT_LOST,
    UNIT_READY,
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
    await player.setVolume(spec.volume);

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
