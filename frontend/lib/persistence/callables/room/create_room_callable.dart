import 'package:tensionpath/domain/entities/room.dart';

class CreateRoomCallable {
  Future<Room> call({required String playerName}) {
    /*final JsonRoom json = JsonRoom(
      id: '',
      version: 1,
      createdAt: DateTime.now(),
      numberOfPlayers: 2,
      visibility: RoomVisibility.public,
      status: RoomStatus.open,
      matchType: '1v1',
      playerIds: [Constants.PLAYER_1],
      players: {Constants.PLAYER_1: playerName},
      matchId: null,
    );*/

    //return RoomRepository.create(json);
    throw UnimplementedError();
  }
}
