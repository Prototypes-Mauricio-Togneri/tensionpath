import 'package:tensionpath/domain/entities/room.dart';

class JoinRoomCallable {
  Future<Room> call({
    required String roomId,
    required String playerName,
  }) async {
    /*final Room room = await RoomRepository.load(roomId);
    final JsonRoom json = JsonRoom(
      id: room.id,
      version: room.version,
      createdAt: room.createdAt,
      numberOfPlayers: room.numberOfPlayers,
      visibility: room.visibility,
      status: room.status,
      matchType: room.matchType,
      playerIds: [...room.playerIds, Constants.PLAYER_2],
      players: {...room.players, Constants.PLAYER_2: playerName},
      matchId: null,
    );

    return RoomRepository.update(json);*/
    throw UnimplementedError();
  }
}
