import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';
import 'package:tensionpath/persistence/callables/room/start_matchmaking_callable.dart';
import 'package:tensionpath/persistence/callables/room/stop_matchmaking_callable.dart';
import 'package:tensionpath/persistence/repository/room_repository.dart';
import 'package:tensionpath/persistence/storage/settings_storage.dart';
import 'package:tensionpath/utils/authentication.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/stream_listener.dart';

class LobbyState extends BaseState {
  Room? _room;
  final StreamListener _roomListener = StreamListener();

  bool get isLoading => _room == null;

  @override
  Future onLoad() async {
    final String name = await SettingsStorage.loadName();
    _room = await const StartMatchmakingCallable()(
      playerName: name,
      version: 1,
      matchType: 'pvp',
      numberOfPlayers: 2,
      visibility: RoomVisibility.public,
    );

    _roomListener.start(
      RoomRepository.listen(
        roomId: _room!.id,
        onUpdated: _onUpdated,
      ),
    );
  }

  @override
  void onDestroy() {
    _roomListener.stop();
  }

  Future onCancel() async {
    await const StopMatchmakingCallable()(roomId: _room!.id);
    Navigation.pop();
  }

  Future _onUpdated(Room room) async {
    if (room.isReady) {
      Navigation.matchScreen(
        matchId: room.matchId!,
        userId: Authentication.userId,
      );
    }
  }
}
