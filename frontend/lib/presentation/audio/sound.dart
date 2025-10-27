import 'dart:math';
import 'package:just_audio/just_audio.dart';
import 'package:tensionpath/presentation/audio/audio.dart';
import 'package:tensionpath/presentation/audio/audio_spec.dart';
import 'package:tensionpath/utils/assets.dart';

mixin Sound {
  final Map<String, AudioPlayer> _soundPlayers = {};
  final List<AudioPlayer> _freePlayers = [];

  // Effects
  static const AudioSpec EFFECT_PAD = AudioSpec(
    path: Assets.AUDIO_SOUND_EFFECTS_PAD,
  );
  static const AudioSpec EFFECT_MISSILE_ALARM = AudioSpec(
    path: Assets.AUDIO_SOUND_EFFECTS_MISSILE_ALARM,
    loop: true,
  );
  static const AudioSpec EFFECT_MISSILE_IMPACT = AudioSpec(
    path: Assets.AUDIO_SOUND_EFFECTS_MISSILE_IMPACT,
  );

  // Voices (Eva)
  static const AudioSpec EVA_BASE_UNDER_ATTACK = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_EVA_BASE_UNDER_ATTACK,
  );
  static const AudioSpec EVA_HARVESTER_UNDER_ATTACK = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_EVA_HARVESTER_UNDER_ATTACK,
  );
  static const AudioSpec EVA_CANNOT_DEPLOY = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_EVA_CANNOT_DEPLOY,
  );
  static const AudioSpec EVA_BUILDING_ONLINE = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_EVA_BUILDING_ONLINE,
  );
  static const AudioSpec EVA_MISSILE_LAUNCHED = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_EVA_MISSILE_LAUNCHED,
  );
  static const AudioSpec EVA_MISSION_ACCOMPLISHED = AudioSpec(
    path: Assets.AUDIO_SOUND_EFFECTS_MISSION_ACCOMPLISHED,
  );
  static const AudioSpec EVA_MISSION_FAILED = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_EVA_MISSION_FAILED,
  );
  static const AudioSpec EVA_SELECT_TARGET = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_EVA_SELECT_TARGET,
  );
  static const AudioSpec EVA_UNIT_LOST = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_EVA_UNIT_LOST,
  );
  static const AudioSpec EVA_UNIT_READY = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_EVA_UNIT_READY,
  );

  // Voices (Moving)
  static const AudioSpec MOVEMENT_MOVING_OUT = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_MOVEMENT_MOVING_OUT,
  );
  static const AudioSpec MOVEMENT_ON_MY_WAY = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_MOVEMENT_ON_MY_WAY,
  );
  static const AudioSpec MOVEMENT_ADVANCING = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_MOVEMENT_ADVANCING,
  );
  static const AudioSpec MOVEMENT_COPY_THAT = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_MOVEMENT_COPY_THAT,
  );
  static const AudioSpec MOVEMENT_ORDERS_RECEIVED = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_MOVEMENT_ORDERS_RECEIVED,
  );

  // Voices (Attack)
  static const AudioSpec ATTACK_TARGET_ACQUIRED = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_ATTACK_TARGET_ACQUIRED,
  );
  static const AudioSpec ATTACK_FIRE_AT_WILL = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_ATTACK_FIRE_AT_WILL,
  );
  static const AudioSpec ATTACK_GIVE_EM_HELL = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_ATTACK_GIVE_EM_HELL,
  );
  static const AudioSpec ATTACK_TARGET_LOCKED = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_ATTACK_TARGET_LOCKED,
  );
  static const AudioSpec ATTACK_OPEN_FIRE = AudioSpec(
    path: Assets.AUDIO_SOUND_VOICE_ATTACK_OPEN_FIRE,
  );

  static const List<AudioSpec> MOVEMENT_SOUNDS = [
    MOVEMENT_MOVING_OUT,
    MOVEMENT_ON_MY_WAY,
    MOVEMENT_ADVANCING,
    MOVEMENT_COPY_THAT,
    MOVEMENT_ORDERS_RECEIVED,
  ];

  static AudioSpec randomMovementSound() =>
      MOVEMENT_SOUNDS[Random().nextInt(MOVEMENT_SOUNDS.length)];

  static const List<AudioSpec> ATTACK_SOUNDS = [
    ATTACK_TARGET_ACQUIRED,
    ATTACK_FIRE_AT_WILL,
    ATTACK_GIVE_EM_HELL,
    ATTACK_TARGET_LOCKED,
    ATTACK_OPEN_FIRE,
  ];

  static AudioSpec randomAttackSound() =>
      ATTACK_SOUNDS[Random().nextInt(ATTACK_SOUNDS.length)];

  static const List<AudioSpec> ALL_SOUNDS = [
    // Effects
    EFFECT_PAD,
    EFFECT_MISSILE_ALARM,
    EFFECT_MISSILE_IMPACT,

    // Voices (Eva)
    EVA_BASE_UNDER_ATTACK,
    EVA_HARVESTER_UNDER_ATTACK,
    EVA_CANNOT_DEPLOY,
    EVA_BUILDING_ONLINE,
    EVA_MISSILE_LAUNCHED,
    EVA_MISSION_ACCOMPLISHED,
    EVA_MISSION_FAILED,
    EVA_SELECT_TARGET,
    EVA_UNIT_LOST,
    EVA_UNIT_READY,

    // Voices (Moving)
    ...MOVEMENT_SOUNDS,

    // Voices (Attack)
    ...ATTACK_SOUNDS,
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

  Future stopAllSounds() =>
      Future.wait(_soundPlayers.values.map((player) => player.stop()));

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
