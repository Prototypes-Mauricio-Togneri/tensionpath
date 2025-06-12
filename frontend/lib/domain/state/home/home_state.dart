import 'package:dafluta/dafluta.dart';
import 'package:flutter/widgets.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';
import 'package:tensionpath/persistence/callables/room/start_matchmaking_callable.dart';
import 'package:tensionpath/persistence/storage/name_storage.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/navigation.dart';

class HomeState extends BaseState {
  final TextEditingController nameController = TextEditingController();

  @override
  Future onLoad() async {
    final String name = await NameStorage.load();
    nameController.text = name;
    notify();
  }

  bool get canPlay => nameController.text.trim().isNotEmpty;

  void onFullscreen() => SetFullscreen.set();

  Future onPlay() async {
    final String name = await _playerName;
    final Room room = await const StartMatchmakingCallable()(
      playerName: name,
      version: 1,
      matchType: 'pvp',
      numberOfPlayers: 2,
      visibility: RoomVisibility.public,
    );
    Navigation.lobbyScreen(room);
  }

  Future<String> get _playerName async {
    final String name = nameController.text.trim();
    await NameStorage.save(name);

    return name;
  }
}
