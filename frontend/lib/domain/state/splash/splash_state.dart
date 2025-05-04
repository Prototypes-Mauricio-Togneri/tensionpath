import 'package:dafluta/dafluta.dart';
import 'package:flutter/widgets.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/persistence/callables/room/create_room_callable.dart';
import 'package:tensionpath/persistence/callables/room/join_room_callable.dart';
import 'package:tensionpath/platform/operations/set_fullscreen.dart';
import 'package:tensionpath/utils/navigation.dart';

class SplashState extends BaseState {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roomController = TextEditingController();

  bool get canCreate => nameController.text.trim().isNotEmpty;

  bool get canJoin =>
      nameController.text.trim().isNotEmpty &&
      roomController.text.trim().isNotEmpty;

  @override
  void onLoad() {
    /*if (Environment.get.isDebug) {
      Delayed.post(() => _onPlay(Constants.PLAYER_1));
    }*/
  }

  void onFullscreen() => SetFullscreen.set();

  Future onCreateRoom() async {
    final Room room = await CreateRoomCallable()(
      playerName: nameController.text.trim(),
    );
    Navigation.lobbyScreen(room: room, playerId: room.playerIds.first);
  }

  Future onJoinRoom() async {
    final Room room = await JoinRoomCallable()(
      roomId: roomController.text.trim(),
      playerName: nameController.text.trim(),
    );
    Navigation.lobbyScreen(room: room, playerId: room.playerIds[1]);
  }
}
