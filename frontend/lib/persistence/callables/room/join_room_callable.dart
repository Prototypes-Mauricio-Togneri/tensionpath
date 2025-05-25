import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/persistence/backend/backend.dart';

class JoinRoomCallable {
  Future<Room> call({required String roomId, required String playerName}) =>
      Backend.joinRoom(roomId: roomId, playerName: playerName);
}
