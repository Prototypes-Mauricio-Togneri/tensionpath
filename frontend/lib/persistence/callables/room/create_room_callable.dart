import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/json/json_room.dart';
import 'package:tensionpath/domain/types/room_status.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';
import 'package:tensionpath/persistence/repository/room_repository.dart';

class CreateRoomCallable {
  Future<Room> call({required String playerName}) {
    final JsonRoom json = JsonRoom(
      id: '',
      version: 1,
      createdAt: DateTime.now(),
      numberOfPlayers: 2,
      visibility: RoomVisibility.public,
      status: RoomStatus.open,
      matchType: '1v1',
      playerIds: [Constants.PLAYER_1],
      players: {Constants.PLAYER_1: playerName},
    );

    return RoomRepository.create(json);
  }
}
