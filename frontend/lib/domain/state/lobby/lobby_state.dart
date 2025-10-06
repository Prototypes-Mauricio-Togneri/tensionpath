import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/persistence/callables/room/start_matchmaking_callable.dart';
import 'package:tensionpath/persistence/callables/room/stop_matchmaking_callable.dart';
import 'package:tensionpath/persistence/repository/room_repository.dart';
import 'package:tensionpath/persistence/storage/settings_storage.dart';
import 'package:tensionpath/utils/authentication.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/stream_listener.dart';

class LobbyState extends BaseState {
  Room? _room;
  bool isCanceling = false;
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
      deck: [
        // TODO(momo): fill with user selection
        UnitType.riflemen,
        UnitType.missiles,
        UnitType.rhino,
        UnitType.predator,
        UnitType.orca,
        UnitType.hammerhead,
      ],
    );
    notify();

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
    isCanceling = true;
    notify();

    await const StopMatchmakingCallable()(roomId: _room!.id);
    Navigation.pop();
  }

  void _onUpdated(Room room) {
    if (room.isReady) {
      Navigation.matchScreen(
        host: room.matchHost!,
        matchId: room.matchId!,
        userId: Authentication.userId,
      );
    }
  }
}
