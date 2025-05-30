import 'package:dafluta/dafluta.dart';
import 'package:flutter/widgets.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/matchmaking_info.dart';
import 'package:tensionpath/environments/environment.dart';
import 'package:tensionpath/persistence/callables/room/matchmaking_callable.dart';
import 'package:tensionpath/persistence/storage/name_storage.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/navigation.dart';

class SplashState extends BaseState {
  final TextEditingController nameController = TextEditingController();

  @override
  Future onLoad() async {
    final String name = await NameStorage.load();
    nameController.text = name;
    notify();

    if (!Environment.get.isDebug) {
      Delayed.post(
        () => Navigation.matchScreen(
          matchId: 'test2',
          selfId: Constants.PLAYER_1,
        ),
      );
    }
  }

  bool get canPlay => nameController.text.trim().isNotEmpty;

  void onFullscreen() => SetFullscreen.set();

  Future onPlay() async {
    final MatchmakingInfo info = await MatchmakingCallable()(await _playerName);
    Navigation.lobbyScreen(info);
  }

  Future<String> get _playerName async {
    final String name = nameController.text.trim();
    await NameStorage.save(name);

    return name;
  }
}
