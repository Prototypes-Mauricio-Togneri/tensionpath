import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/persistence/backend/backend.dart';

class CreateRoomCallable {
  Future<Room> call(String playerName) => Backend.createRoom(playerName);
}
