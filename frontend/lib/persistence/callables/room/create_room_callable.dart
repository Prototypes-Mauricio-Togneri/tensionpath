import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/json/json_room.dart';
import 'package:tensionpath/domain/types/room_status.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';
import 'package:tensionpath/persistence/repository/room_repository.dart';
import 'package:tensionpath/utils/id.dart';

class CreateRoomCallable {
  Future<Room> call({required String playerName}) {
    final String playerId = Id.get;
    final JsonRoom json = JsonRoom(
      id: '',
      version: 1,
      createdAt: DateTime.now(),
      numberOfPlayers: 2,
      visibility: RoomVisibility.public,
      status: RoomStatus.open,
      matchType: '1v1',
      playerIds: [playerId],
      players: {playerId: playerName},
    );

    return RoomRepository.create(json);
  }
}
